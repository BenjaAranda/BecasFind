package com.becasfind.api.services.impl;

import com.becasfind.api.exceptions.BusinessException;
import com.becasfind.api.exceptions.EmailDeliveryException;
import com.becasfind.api.services.ResetEmailService;
import com.becasfind.api.utils.PasswordResetEmail;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@ConditionalOnProperty(name = "RESET_EMAIL_PROVIDER", havingValue = "resend")
public class ResendResetEmailService implements ResetEmailService {
    private final ObjectMapper mapper;
    private final HttpClient client;
    private final boolean enabled;
    private final String apiKey;
    private final String from;
    private final URI frontend;
    private final URI endpoint;

    @Autowired
    public ResendResetEmailService(ObjectMapper mapper, Environment environment) {
        this(mapper, HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(5)).build(),
                environment.getProperty("RESET_EMAIL_ENABLED", Boolean.class, false),
                environment.getProperty("RESEND_API_KEY", ""), environment.getProperty("RESET_EMAIL_FROM", ""),
                PasswordResetEmail.frontendUrl(environment), URI.create("https://api.resend.com/emails"));
    }

    // Endpoint sustituible únicamente desde pruebas locales, nunca mediante variables externas.
    ResendResetEmailService(ObjectMapper mapper, HttpClient client, boolean enabled,
                            String apiKey, String from, URI frontend, URI endpoint) {
        this.mapper = mapper;
        this.client = client;
        this.enabled = enabled;
        this.apiKey = apiKey;
        this.from = from;
        this.frontend = frontend;
        this.endpoint = endpoint;
        if (enabled && (apiKey.isBlank() || apiKey.contains("\r") || apiKey.contains("\n")
                || from.isBlank() || from.contains("\r") || from.contains("\n"))) {
            throw new IllegalArgumentException("Configurar RESEND_API_KEY y RESET_EMAIL_FROM para habilitar el envío");
        }
    }

    @Override
    public void requireConfigured() {
        if (!enabled) throw new BusinessException(
                "La recuperación por correo aún no está disponible. Inténtalo más tarde.", HttpStatus.SERVICE_UNAVAILABLE);
    }

    @Override
    public void sendPasswordReset(String email, String token) {
        requireConfigured();
        String safeToken = UUID.fromString(token).toString();
        String text = PasswordResetEmail.text(frontend, safeToken);
        try {
            String body = mapper.writeValueAsString(Map.of("from", from, "to", List.of(email),
                    "subject", PasswordResetEmail.SUBJECT, "text", text));
            HttpRequest request = HttpRequest.newBuilder(endpoint).timeout(Duration.ofSeconds(10))
                    .header("Authorization", "Bearer " + apiKey)
                    .header("Content-Type", "application/json; charset=UTF-8")
                    .header("Idempotency-Key", "password-reset/" + safeToken)
                    .POST(HttpRequest.BodyPublishers.ofString(body, StandardCharsets.UTF_8)).build();
            var response = client.send(request, HttpResponse.BodyHandlers.discarding());
            if (response.statusCode() < 200 || response.statusCode() >= 300) throw new EmailDeliveryException();
        } catch (InterruptedException exception) {
            Thread.currentThread().interrupt();
            throw new EmailDeliveryException();
        } catch (IOException exception) {
            throw new EmailDeliveryException();
        }
    }
}
