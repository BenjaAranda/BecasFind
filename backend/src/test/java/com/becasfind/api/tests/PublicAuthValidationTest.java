package com.becasfind.api.tests;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.annotation.DirtiesContext;
import java.util.Map;
import java.util.UUID;
import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class PublicAuthValidationTest extends BaseTest {
    @Autowired JdbcTemplate jdbc;

    @Test void oversizedNameIsRejectedBeforeDatabaseWrite() {
        int before = jdbc.queryForObject("SELECT count(*) FROM usuarios", Integer.class);
        assertInvalid(post("/api/auth/register", null, Map.of("nombreCompleto", "á".repeat(256),
                "email", "oversized-public@example.com", "password", "password123"), Map.class), "nombreCompleto");
        assertEquals(before, jdbc.queryForObject("SELECT count(*) FROM usuarios", Integer.class));
    }

    @Test void maximumNameAndAsciiPasswordCanRegisterAndLogin() {
        String name = "Ñ".repeat(255);
        String password = "a".repeat(72);
        var response = post("/api/auth/register", null, Map.of("nombreCompleto", name,
                "email", "boundary-public@example.com", "password", password), Map.class);
        assertEquals(201, response.getStatusCode().value());
        assertEquals(name, ((Map) response.getBody().get("data")).get("nombreCompleto"));
        assertNotNull(login("boundary-public@example.com", password));
    }

    @Test void registrationValidatesUtf8BytesWithoutRejectingAccents() {
        assertInvalid(post("/api/auth/register", null, Map.of("nombreCompleto", "Educación Ñuble",
                "email", "utf8-over-public@example.com", "password", "ñ".repeat(37)), Map.class), "passwordUtf8Valid");
        assertEquals(0, jdbc.queryForObject("SELECT count(*) FROM usuarios WHERE email = ?", Integer.class,
                "utf8-over-public@example.com"));
        assertEquals(201, post("/api/auth/register", null, Map.of("nombreCompleto", "Educación Ñuble",
                "email", "utf8-boundary-public@example.com", "password", "ñ".repeat(36)), Map.class).getStatusCode().value());
        assertNotNull(login("utf8-boundary-public@example.com", "ñ".repeat(36)));
    }

    @Test void loginBoundsEmailCharactersAndPasswordBytes() {
        assertInvalid(post("/api/auth/login", null, Map.of("email", "u@" + "a".repeat(253),
                "password", "password123"), Map.class), "email");
        assertInvalid(post("/api/auth/login", null, Map.of("email", "admin@becasfind.cl",
                "password", "a".repeat(73)), Map.class), "password");
        assertInvalid(post("/api/auth/login", null, Map.of("email", "admin@becasfind.cl",
                "password", "ñ".repeat(37)), Map.class), "passwordUtf8Valid");
    }

    @Test void malformedResetTokenIs400ButUnknownUuidRemains401() {
        for (String token : new String[]{"fake-token", "x".repeat(36), "", "a".repeat(37)}) {
            assertInvalid(post("/api/auth/reset-password", null, Map.of("token", token,
                    "newPassword", "password123"), Map.class), "token");
        }
        assertEquals(401, post("/api/auth/reset-password", null, Map.of("token", UUID.randomUUID().toString(),
                "newPassword", "password123"), Map.class).getStatusCode().value());
    }

    @Test void invalidRecoveryEmailCreatesNoTokensAndSendsNoMail() {
        int before = jdbc.queryForObject("SELECT count(*) FROM password_reset_tokens", Integer.class);
        for (String email : new String[]{"", "invalid", "u@" + "a".repeat(253)}) {
            assertInvalid(post("/api/auth/forgot-password", null, Map.of("email", email), Map.class), "email");
        }
        assertEquals(before, jdbc.queryForObject("SELECT count(*) FROM password_reset_tokens", Integer.class));
        org.mockito.Mockito.verifyNoInteractions(resetEmailService);
    }

    @Test void invalidResetPasswordPreservesTokenAndCredentialsForRetry() {
        String token = UUID.randomUUID().toString();
        String oldHash = jdbc.queryForObject("SELECT password_hash FROM usuarios WHERE id_usuario = 2", String.class);
        jdbc.update("INSERT INTO password_reset_tokens (token, id_usuario, fecha_expiracion) VALUES (?, 2, ?)",
                token, java.time.LocalDateTime.now().plusMinutes(15));
        try {
            assertInvalid(post("/api/auth/reset-password", null, Map.of("token", token,
                    "newPassword", "ñ".repeat(37)), Map.class), "newPasswordUtf8Valid");
            assertEquals(oldHash, jdbc.queryForObject("SELECT password_hash FROM usuarios WHERE id_usuario = 2", String.class));
            assertEquals(1, jdbc.queryForObject("SELECT count(*) FROM password_reset_tokens WHERE token = ?", Integer.class, token));
            assertEquals(200, post("/api/auth/reset-password", null, Map.of("token", token,
                    "newPassword", "ñ".repeat(36)), Map.class).getStatusCode().value());
            assertNotNull(login("estudiante@duoc.cl", "ñ".repeat(36)));
            assertEquals(0, jdbc.queryForObject("SELECT count(*) FROM password_reset_tokens WHERE token = ?", Integer.class, token));
        } finally {
            jdbc.update("UPDATE usuarios SET password_hash = ? WHERE id_usuario = 2", oldHash);
            jdbc.update("DELETE FROM password_reset_tokens WHERE token = ?", token);
        }
    }

    private void assertInvalid(ResponseEntity<Map> response, String field) {
        assertEquals(400, response.getStatusCode().value());
        assertNotNull(response.getBody());
        assertEquals(400, response.getBody().get("status"));
        assertTrue(response.getBody().containsKey("data"));
        assertNull(response.getBody().get("data"));
        assertTrue(((Map) response.getBody().get("validationErrors")).containsKey(field));
    }
}
