package com.becasfind.api.services.impl;

import com.becasfind.api.exceptions.BusinessException;
import com.becasfind.api.exceptions.EmailDeliveryException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpServer;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.mock.env.MockEnvironment;

import java.net.InetSocketAddress;
import java.net.URI;
import java.net.http.HttpClient;
import java.nio.charset.StandardCharsets;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

import static org.junit.jupiter.api.Assertions.*;

class ResendResetEmailServiceTest {
    private HttpServer server;
    private final ObjectMapper mapper = new ObjectMapper();
    private final AtomicInteger status = new AtomicInteger(200);
    private final AtomicReference<String> body = new AtomicReference<>();
    private final AtomicReference<String> authorization = new AtomicReference<>();
    private final AtomicReference<String> idempotency = new AtomicReference<>();

    @BeforeEach
    void startFakeProvider() throws Exception {
        server = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
        server.createContext("/emails", exchange -> {
            body.set(new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8));
            authorization.set(exchange.getRequestHeaders().getFirst("Authorization"));
            idempotency.set(exchange.getRequestHeaders().getFirst("Idempotency-Key"));
            exchange.sendResponseHeaders(status.get(), -1);
            exchange.close();
        });
        server.start();
    }

    @AfterEach
    void stop() { server.stop(0); }

    private ResendResetEmailService service(boolean enabled) {
        return new ResendResetEmailService(mapper, HttpClient.newHttpClient(), enabled,
                "test-key", "BecasFind <recovery@example.com>", URI.create("https://becasfind.example"),
                URI.create("http://127.0.0.1:" + server.getAddress().getPort() + "/emails"));
    }

    @Test
    void sendsUtf8EmailWithTrustedFragmentLinkAndIdempotencyKey() throws Exception {
        String token = UUID.randomUUID().toString();
        service(true).sendPasswordReset("student@example.com", token);
        var json = mapper.readTree(body.get());
        assertEquals("Bearer test-key", authorization.get());
        assertEquals("password-reset/" + token, idempotency.get());
        assertEquals("student@example.com", json.get("to").get(0).asText());
        assertTrue(json.get("text").asText().contains("https://becasfind.example/reset-password#token=" + token));
        assertTrue(json.get("subject").asText().contains("contraseña"));
        assertTrue(json.get("text").asText().contains("15 minutos"));
    }

    @Test
    void rejectedEmailRaisesSanitizedFailure() {
        status.set(429);
        var error = assertThrows(EmailDeliveryException.class,
                () -> service(true).sendPasswordReset("student@example.com", UUID.randomUUID().toString()));
        assertFalse(error.getMessage().contains("test-key"));
        assertNull(error.getCause());
    }

    @Test
    void disabledProviderCannotPretendToDeliver() {
        assertThrows(BusinessException.class, () -> service(false).requireConfigured());
        assertNull(body.get());
    }

    @Test
    void startupRejectsMissingCredentialsAndUntrustedFrontendUrls() {
        var environment = new MockEnvironment().withProperty("RESET_EMAIL_ENABLED", "true")
                .withProperty("FRONTEND_URL", "https://becasfind.example");
        assertThrows(IllegalArgumentException.class, () -> new ResendResetEmailService(mapper, environment));
        environment.withProperty("RESEND_API_KEY", "test-key").withProperty("RESET_EMAIL_FROM", "recovery@example.com");
        environment.withProperty("FRONTEND_URL", "http://attacker.example");
        assertThrows(IllegalArgumentException.class, () -> new ResendResetEmailService(mapper, environment));
        environment.withProperty("FRONTEND_URL", "https://example.com/?redirect=attacker");
        assertThrows(IllegalArgumentException.class, () -> new ResendResetEmailService(mapper, environment));
    }

    @Test
    void networkFailureIsSanitized() {
        var service = service(true);
        server.stop(0);
        assertThrows(EmailDeliveryException.class, () -> service.sendPasswordReset("student@example.com", UUID.randomUUID().toString()));
    }
}
