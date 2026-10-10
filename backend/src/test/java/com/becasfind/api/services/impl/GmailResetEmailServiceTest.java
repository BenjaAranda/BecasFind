package com.becasfind.api.services.impl;

import com.becasfind.api.exceptions.BusinessException;
import com.becasfind.api.exceptions.EmailDeliveryException;
import com.becasfind.api.services.ResetEmailService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.mail.Session;
import jakarta.mail.internet.MimeMessage;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mock.env.MockEnvironment;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Properties;
import java.util.UUID;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class GmailResetEmailServiceTest {
    private MockEnvironment enabledEnvironment() {
        return new MockEnvironment().withProperty("RESET_EMAIL_ENABLED", "true")
                .withProperty("GMAIL_USERNAME", "becasfind.test@gmail.com")
                .withProperty("GMAIL_APP_PASSWORD", "abcd efgh ijkl mnop")
                .withProperty("FRONTEND_URL", "https://becasfind.example");
    }

    @Test
    void sendsUtf8MessageWithSingleRecipientAndTrustedFragmentLink() throws Exception {
        JavaMailSender sender = mock(JavaMailSender.class);
        MimeMessage message = new MimeMessage(Session.getInstance(new Properties()));
        when(sender.createMimeMessage()).thenReturn(message);
        var service = new GmailResetEmailService(sender, true, "becasfind.test@gmail.com", URI.create("https://becasfind.example"));
        String token = UUID.randomUUID().toString();
        service.sendPasswordReset("student@example.com", token);
        message.saveChanges();
        verify(sender).send(message);
        assertEquals("Recupera tu contraseña de BecasFind", message.getSubject());
        assertEquals(1, message.getAllRecipients().length);
        assertEquals("student@example.com", message.getAllRecipients()[0].toString());
        assertTrue(message.getFrom()[0].toString().contains("BecasFind"));
        assertTrue(message.getContentType().toLowerCase().contains("charset=utf-8"));
        String content = (String) message.getContent();
        assertTrue(content.contains("https://becasfind.example/reset-password#token=" + token));
        assertTrue(content.contains("15 minutos"));
        assertTrue(content.contains("contraseña"));
    }

    @Test
    void disabledProviderDoesNotGenerateOrSendEmail() {
        JavaMailSender sender = mock(JavaMailSender.class);
        var service = new GmailResetEmailService(sender, false, "", URI.create("https://localhost"));
        assertThrows(BusinessException.class, service::requireConfigured);
        assertThrows(BusinessException.class, () -> service.sendPasswordReset("student@example.com", UUID.randomUUID().toString()));
        verifyNoInteractions(sender);
        assertDoesNotThrow(() -> new GmailResetEmailService(new MockEnvironment()));
    }

    @Test
    void credentialsAndFrontendAreValidatedWithoutDisclosingSecrets() {
        for (String username : new String[]{"", "student@example.com", "Name <student@gmail.com>", "student@gmail.com\r\nBcc:other@gmail.com"}) {
            var env = enabledEnvironment().withProperty("GMAIL_USERNAME", username);
            assertThrows(IllegalArgumentException.class, () -> new GmailResetEmailService(env));
        }
        for (String password : new String[]{"", "normal-password", "abcd\nefghijklmnop"}) {
            var env = enabledEnvironment().withProperty("GMAIL_APP_PASSWORD", password);
            var error = assertThrows(IllegalArgumentException.class, () -> new GmailResetEmailService(env));
            if (!password.isEmpty()) assertFalse(error.getMessage().contains(password));
        }
        for (String url : new String[]{"http://attacker.example", "https://example.com/?redirect=x", "https://user:pass@example.com", "https://example.com/path", "https://example.com/#token=x"}) {
            var env = enabledEnvironment().withProperty("FRONTEND_URL", url);
            assertThrows(IllegalArgumentException.class, () -> new GmailResetEmailService(env));
        }
        var env = enabledEnvironment().withProperty("FRONTEND_URL", "http://localhost:5173");
        env.setActiveProfiles("dev");
        assertDoesNotThrow(() -> new GmailResetEmailService(env));
        env.setActiveProfiles("dev", "prod");
        assertThrows(IllegalArgumentException.class, () -> new GmailResetEmailService(env));
    }

    @Test
    void deliveryFailureHasNoProviderDetailsOrCause() {
        JavaMailSender sender = mock(JavaMailSender.class);
        MimeMessage message = new MimeMessage(Session.getInstance(new Properties()));
        when(sender.createMimeMessage()).thenReturn(message);
        doThrow(new MailAuthenticationException("secret-provider-diagnostic")).when(sender).send(message);
        var service = new GmailResetEmailService(sender, true, "becasfind.test@gmail.com", URI.create("https://becasfind.example"));
        var error = assertThrows(EmailDeliveryException.class,
                () -> service.sendPasswordReset("student@example.com", UUID.randomUUID().toString()));
        assertFalse(error.getMessage().contains("secret-provider-diagnostic"));
        assertNull(error.getCause());
    }

    @Test
    void recipientInjectionAndInvalidTokenDoNotSend() {
        JavaMailSender sender = mock(JavaMailSender.class);
        when(sender.createMimeMessage()).thenAnswer(call -> new MimeMessage(Session.getInstance(new Properties())));
        var service = new GmailResetEmailService(sender, true, "becasfind.test@gmail.com", URI.create("https://becasfind.example"));
        for (String email : new String[]{"student@example.com\r\nBcc: other@example.com", "student@example.com,other@example.com", "Name <student@example.com>"}) {
            assertThrows(EmailDeliveryException.class, () -> service.sendPasswordReset(email, UUID.randomUUID().toString()));
        }
        assertThrows(IllegalArgumentException.class, () -> service.sendPasswordReset("student@example.com", "../../evil"));
        verify(sender, never()).send(any(MimeMessage.class));
    }

    @Test
    void smtpWithoutStartTlsNeverReceivesAuthenticationOrMessage() throws Exception {
        var sender = GmailResetEmailService.configureSender(enabledEnvironment());
        assertEquals("smtp.gmail.com", sender.getHost());
        assertEquals(587, sender.getPort());
        try (var server = new ServerSocket(0, 1, InetAddress.getLoopbackAddress())) {
            server.setSoTimeout(5000);
            var executor = Executors.newSingleThreadExecutor();
            try {
                var commands = executor.submit(() -> {
                    var observed = new ArrayList<String>();
                    try (var socket = server.accept()) {
                        socket.setSoTimeout(5000);
                        var reader = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.US_ASCII));
                        var writer = new PrintWriter(socket.getOutputStream(), true, StandardCharsets.US_ASCII);
                        writer.print("220 local SMTP\r\n"); writer.flush();
                        String command;
                        while ((command = reader.readLine()) != null) {
                            observed.add(command);
                            writer.print(command.startsWith("QUIT") ? "221 bye\r\n" : "250 local SMTP\r\n"); writer.flush();
                        }
                    }
                    return observed;
                });
                sender.setHost(server.getInetAddress().getHostAddress());
                sender.setPort(server.getLocalPort());
                var service = new GmailResetEmailService(sender, true, "becasfind.test@gmail.com", URI.create("https://becasfind.example"));
                assertThrows(EmailDeliveryException.class, () -> service.sendPasswordReset("student@example.com", UUID.randomUUID().toString()));
                var observed = commands.get(6, TimeUnit.SECONDS);
                assertTrue(observed.stream().anyMatch(line -> line.startsWith("EHLO")));
                assertTrue(observed.stream().noneMatch(line -> line.startsWith("AUTH") || line.startsWith("MAIL") || line.startsWith("DATA")));
            } finally { executor.shutdownNow(); }
        }
    }

    @Test
    void exactlyOneProviderIsSelectedAndGmailIsDefault() {
        var runner = new ApplicationContextRunner().withBean(ObjectMapper.class, ObjectMapper::new)
                .withUserConfiguration(GmailResetEmailService.class, ResendResetEmailService.class);
        runner.run(context -> assertInstanceOf(GmailResetEmailService.class, context.getBean(ResetEmailService.class)));
        runner.withPropertyValues("RESET_EMAIL_PROVIDER=resend").run(context ->
                assertInstanceOf(ResendResetEmailService.class, context.getBean(ResetEmailService.class)));
    }
}
