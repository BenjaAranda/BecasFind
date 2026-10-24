package com.becasfind.api.services.impl;

import com.becasfind.api.exceptions.BusinessException;
import com.becasfind.api.exceptions.EmailDeliveryException;
import com.becasfind.api.services.ResetEmailService;
import com.becasfind.api.utils.PasswordResetEmail;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.nio.charset.StandardCharsets;

@Service
@ConditionalOnProperty(name = "RESET_EMAIL_PROVIDER", havingValue = "gmail", matchIfMissing = true)
public class GmailResetEmailService implements ResetEmailService {
    private final JavaMailSender sender;
    private final boolean enabled;
    private final String from;
    private final URI frontend;

    @Autowired
    public GmailResetEmailService(Environment environment) {
        this(configureSender(environment), environment.getProperty("RESET_EMAIL_ENABLED", Boolean.class, false),
                environment.getProperty("GMAIL_USERNAME", ""), PasswordResetEmail.frontendUrl(environment));
    }

    GmailResetEmailService(JavaMailSender sender, boolean enabled, String from, URI frontend) {
        this.sender = sender;
        this.enabled = enabled;
        this.from = from;
        this.frontend = frontend;
    }

    static JavaMailSenderImpl configureSender(Environment environment) {
        var sender = new JavaMailSenderImpl();
        sender.setHost("smtp.gmail.com");
        sender.setPort(587);
        sender.setDefaultEncoding(StandardCharsets.UTF_8.name());
        var properties = sender.getJavaMailProperties();
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");
        properties.setProperty("mail.smtp.starttls.required", "true");
        properties.setProperty("mail.smtp.ssl.checkserveridentity", "true");
        properties.setProperty("mail.smtp.connectiontimeout", "5000");
        properties.setProperty("mail.smtp.timeout", "5000");
        properties.setProperty("mail.smtp.writetimeout", "5000");
        properties.setProperty("mail.debug", "false");
        if (environment.getProperty("RESET_EMAIL_ENABLED", Boolean.class, false)) {
            String username = environment.getProperty("GMAIL_USERNAME", "");
            String password = environment.getProperty("GMAIL_APP_PASSWORD", "").replace(" ", "");
            if (!username.matches("[A-Za-z0-9._%+-]+@(gmail\\.com|googlemail\\.com)")
                    || !password.matches("[A-Za-z0-9]{16}")) {
                throw new IllegalArgumentException("Configurar GMAIL_USERNAME y una contraseña de aplicación de Gmail de 16 caracteres");
            }
            sender.setUsername(username);
            sender.setPassword(password);
        }
        return sender;
    }

    @Override
    public void requireConfigured() {
        if (!enabled) throw new BusinessException(
                "La recuperación por correo aún no está disponible. Inténtalo más tarde.", HttpStatus.SERVICE_UNAVAILABLE);
    }

    @Override
    public void sendPasswordReset(String email, String token) {
        requireConfigured();
        try {
            InternetAddress recipient = new InternetAddress(email, true);
            recipient.validate();
            if (email.contains("\r") || email.contains("\n") || recipient.isGroup()
                    || recipient.getPersonal() != null || !email.equals(recipient.getAddress())) {
                throw new EmailDeliveryException();
            }
            var message = sender.createMimeMessage();
            var helper = new MimeMessageHelper(message, StandardCharsets.UTF_8.name());
            helper.setFrom(new InternetAddress(from, "BecasFind", StandardCharsets.UTF_8.name()));
            helper.setTo(recipient);
            helper.setSubject(PasswordResetEmail.SUBJECT);
            helper.setText(PasswordResetEmail.text(frontend, token), false);
            sender.send(message);
        } catch (MessagingException | MailException | java.io.UnsupportedEncodingException exception) {
            throw new EmailDeliveryException();
        }
    }
}
