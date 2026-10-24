package com.becasfind.api.utils;

import org.springframework.core.env.Environment;
import org.springframework.core.env.Profiles;

import java.net.URI;
import java.util.List;
import java.util.UUID;

/** El origen del enlace procede exclusivamente de configuración confiable. */
public final class PasswordResetEmail {
    public static final String SUBJECT = "Recupera tu contraseña de BecasFind";

    private PasswordResetEmail() {}

    public static URI frontendUrl(Environment environment) {
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

    public static String text(URI frontend, String token) {
        String link = frontend.resolve("/reset-password") + "#token=" + UUID.fromString(token);
        return "Recupera tu acceso a BecasFind\n\nAbre este enlace para crear una nueva contraseña:\n"
                + link + "\n\nEl enlace vence en 15 minutos y solo puede usarse una vez. "
                + "Si no solicitaste este cambio, ignora este correo. Tu contraseña seguirá siendo la misma.";
    }
}
