package com.becasfind.api.services.impl;

import com.becasfind.api.exceptions.BusinessException;
import com.becasfind.api.exceptions.EmailDeliveryException;
import com.becasfind.api.services.ResetEmailService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.core.env.Profiles;
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
                frontendUrl(environment), URI.create("https://api.resend.com/emails"));
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

    private static URI frontendUrl(Environment environment) {
        if (!environment.getProperty("RESET_EMAIL_ENABLED", Boolean.class, false)) return URI.create("https://localhost");
        URI uri = URI.create(environment.getProperty("FRONTEND_URL", ""));
        boolean localDev = environment.acceptsProfiles(Profiles.of("dev & !prod"))
                && "http".equals(uri.getScheme())
                && List.of("localhost", "127.0.0.1").contains(uri.getHost());
        if (!("https".equals(uri.getScheme()) || localDev) || uri.getHost() == null
                || uri.getUserInfo() != null || uri.getQuery() != null || uri.getFragment() != null
                || !(uri.getPath().isEmpty() || "/".equals(uri.getPath()))) {
            throw new IllegalArgumentException("FRONTEND_URL debe ser un origen HTTPS; HTTP local solo está permitido en dev");
        }
        return uri;
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
        String link = frontend.resolve("/reset-password").toString() + "#token=" + safeToken;
        String text = "Recupera tu acceso a BecasFind\n\nAbre este enlace para crear una nueva contraseña:\n"
                + link + "\n\nEl enlace vence en 15 minutos y solo puede usarse una vez. "
                + "Si no solicitaste este cambio, ignora este correo. Tu contraseña seguirá siendo la misma.";
        try {
            String body = mapper.writeValueAsString(Map.of("from", from, "to", List.of(email),
                    "subject", "Recupera tu contraseña de BecasFind", "text", text));
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
