package com.becasfind.api.tests;

import com.becasfind.api.exceptions.BusinessException;
import com.becasfind.api.exceptions.EmailDeliveryException;
import com.becasfind.api.models.entities.PasswordResetToken;
import com.becasfind.api.repositories.PasswordResetTokenRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.services.AuthService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

class PasswordRecoveryDeliveryTest extends BaseTest {
    @Autowired PasswordResetTokenRepository tokens;
    @Autowired UsuarioRepository users;
    @Autowired AuthService auth;
    @Autowired JdbcTemplate jdbc;

    @AfterEach
    void cleanup() { jdbc.update("DELETE FROM password_reset_tokens"); }

    private String previousToken() {
        var token = new PasswordResetToken();
        token.setToken(UUID.randomUUID().toString());
        token.setUsuario(users.findByEmail("admin@becasfind.cl").orElseThrow());
        token.setFechaExpiracion(LocalDateTime.now().plusMinutes(15));
        tokens.saveAndFlush(token);
        return token.getToken();
    }

    @Test
    void sendsPersistedTokenAndReplacesPriorLink() {
        String old = previousToken();
        var result = post("/api/auth/forgot-password", null, Map.of("email", "admin@becasfind.cl"), Map.class);
        assertEquals(200, result.getStatusCode().value());
        var captured = ArgumentCaptor.forClass(String.class);
        verify(resetEmailService).sendPasswordReset(eq("admin@becasfind.cl"), captured.capture());
        assertTrue(tokens.findByToken(captured.getValue()).isPresent());
        assertTrue(tokens.findByToken(old).isEmpty());
        assertTrue(tokens.findByToken(captured.getValue()).orElseThrow().getFechaExpiracion().isAfter(LocalDateTime.now().plusMinutes(14)));
    }

    @Test
    void unknownAccountDoesNotSendOrCreateToken() {
        auth.forgotPassword("unknown@example.com");
        verify(resetEmailService, never()).sendPasswordReset(anyString(), anyString());
        assertEquals(0, tokens.count());
    }

    @Test
    void deliveryFailureRollsBackAndKeepsResponsePrivate() {
        String old = previousToken();
        doThrow(new EmailDeliveryException()).when(resetEmailService).sendPasswordReset(anyString(), anyString());
        var known = post("/api/auth/forgot-password", null, Map.of("email", "admin@becasfind.cl"), Map.class);
        var unknown = post("/api/auth/forgot-password", null, Map.of("email", "unknown@example.com"), Map.class);
        assertEquals(200, known.getStatusCode().value());
        assertEquals(unknown.getBody().get("message"), known.getBody().get("message"));
        assertTrue(tokens.findByToken(old).isPresent());
        assertEquals(1, tokens.count());
    }

    @Test
    void disabledSendingReturnsSameUnavailableStatusForEveryone() {
        doThrow(new BusinessException("Recuperación temporalmente no disponible", HttpStatus.SERVICE_UNAVAILABLE))
                .when(resetEmailService).requireConfigured();
        assertEquals(503, post("/api/auth/forgot-password", null, Map.of("email", "admin@becasfind.cl"), Map.class).getStatusCode().value());
        assertEquals(503, post("/api/auth/forgot-password", null, Map.of("email", "unknown@example.com"), Map.class).getStatusCode().value());
        assertEquals(0, tokens.count());
    }

    @Test
    void multibytePasswordDoesNotReachBcryptOrConsumeLink() {
        String token = previousToken();
        assertThrows(BusinessException.class, () -> auth.resetPassword(token, "ñ".repeat(40)));
        assertTrue(tokens.findByToken(token).isPresent());
    }

    @Test
    void recoveryLinkChangesLoginAndCannotBeReused() {
        String original = jdbc.queryForObject("SELECT password_hash FROM usuarios WHERE email = ?", String.class, "admin@becasfind.cl");
        try {
            assertEquals(200, post("/api/auth/forgot-password", null, Map.of("email", "admin@becasfind.cl"), Map.class).getStatusCode().value());
            var captured = ArgumentCaptor.forClass(String.class);
            verify(resetEmailService).sendPasswordReset(eq("admin@becasfind.cl"), captured.capture());
            Map<String, String> reset = Map.of("token", captured.getValue(), "newPassword", "changed-password123");
            assertEquals(200, post("/api/auth/reset-password", null, reset, Map.class).getStatusCode().value());
            assertNotNull(login("admin@becasfind.cl", "changed-password123"));
            assertNull(login("admin@becasfind.cl", "admin123"));
            assertEquals(401, post("/api/auth/reset-password", null, reset, Map.class).getStatusCode().value());
        } finally {
            jdbc.update("UPDATE usuarios SET password_hash = ? WHERE email = ?", original, "admin@becasfind.cl");
        }
    }
}
