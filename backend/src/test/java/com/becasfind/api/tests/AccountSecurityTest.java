package com.becasfind.api.tests;

import com.becasfind.api.config.bootstrap.DatabaseSeeder;
import com.becasfind.api.models.entities.PasswordResetToken;
import com.becasfind.api.repositories.PasswordResetTokenRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.repositories.RolRepository;
import com.becasfind.api.services.AuthService;
import com.becasfind.api.utils.JwtUtil;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.TestPropertySource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
@TestPropertySource(properties = "CORS_ALLOWED_ORIGINS=https://becasfind.example")
class AccountSecurityTest extends BaseTest {
    @Autowired JdbcTemplate jdbc;
    @Autowired JwtUtil jwt;
    @Autowired AuthService auth;
    @Autowired UsuarioRepository users;
    @Autowired PasswordResetTokenRepository resets;
    @Autowired ApplicationContext context;
    @Autowired RolRepository roles;
    @Autowired PasswordEncoder encoder;
    private String originalHash;

    @BeforeEach
    void rememberPassword() {
        originalHash = jdbc.queryForObject("SELECT password_hash FROM usuarios WHERE email = ?", String.class, "admin@becasfind.cl");
    }

    @AfterEach
    void restoreFixtures() {
        jdbc.update("UPDATE usuarios SET activo = true, password_hash = ?, id_rol = (SELECT id_rol FROM roles WHERE nombre_rol = 'ADMIN') WHERE email = ?", originalHash, "admin@becasfind.cl");
        jdbc.update("DELETE FROM password_reset_tokens");
    }

    @Test
    void disabledAccountCannotReuseToken() {
        String token = adminToken();
        assertNotNull(token);
        jdbc.update("UPDATE usuarios SET activo = false WHERE email = ?", "admin@becasfind.cl");
        assertEquals(401, get("/api/usuarios", token, Map.class).getStatusCode().value());
    }

    @Test
    void demotedAdministratorCannotReuseOldRole() {
        String token = adminToken();
        assertEquals(200, get("/api/usuarios", token, Map.class).getStatusCode().value());
        jdbc.update("UPDATE usuarios SET id_rol = (SELECT id_rol FROM roles WHERE nombre_rol = 'STUDENT') WHERE email = ?", "admin@becasfind.cl");
        assertEquals(403, get("/api/usuarios", token, Map.class).getStatusCode().value());
        assertEquals(200, get("/api/perfil", token, Map.class).getStatusCode().value());
    }

    @Test
    void tokenForMissingAccountIsRejected() {
        String token = jwt.generateToken("missing@test.cl", "ADMIN", "Missing", originalHash);
        assertEquals(401, get("/api/usuarios", token, Map.class).getStatusCode().value());
    }

    @Test
    void signedRoleCannotGrantMoreThanDatabaseRole() {
        String hash = jdbc.queryForObject("SELECT password_hash FROM usuarios WHERE email = ?", String.class, "estudiante@duoc.cl");
        String token = jwt.generateToken("estudiante@duoc.cl", "ADMIN", "Student", hash);
        assertEquals(403, get("/api/usuarios", token, Map.class).getStatusCode().value());
    }

    @Test
    void anonymousRecommendationsAreRejectedBeforeController() {
        assertEquals(401, get("/api/becas/recomendadas", null, Map.class).getStatusCode().value());
    }

    @Test
    void corsAcceptsOnlyExplicitOrigin() {
        HttpHeaders headers = new HttpHeaders();
        headers.setOrigin("https://becasfind.example");
        headers.setAccessControlRequestMethod(HttpMethod.GET);
        var allowed = rest.exchange(url("/api/regiones"), HttpMethod.OPTIONS, new HttpEntity<>(headers), String.class);
        assertEquals(200, allowed.getStatusCode().value());
        assertEquals("https://becasfind.example", allowed.getHeaders().getAccessControlAllowOrigin());
        headers.setOrigin("https://untrusted.vercel.app");
        var blocked = rest.exchange(url("/api/regiones"), HttpMethod.OPTIONS, new HttpEntity<>(headers), String.class);
        assertEquals(403, blocked.getStatusCode().value());
        assertNull(blocked.getHeaders().getAccessControlAllowOrigin());
    }

    @Test
    void recoveryDoesNotRevealWhetherAccountExists() {
        var known = post("/api/auth/forgot-password", null, Map.of("email", "admin@becasfind.cl"), Map.class);
        var unknown = post("/api/auth/forgot-password", null, Map.of("email", "unknown@test.cl"), Map.class);
        assertEquals(200, known.getStatusCode().value());
        assertEquals(known.getStatusCode(), unknown.getStatusCode());
        assertEquals(known.getBody().get("message"), unknown.getBody().get("message"));
    }

    @Test
    void expiredRecoveryIsDeletedDespiteRejection() {
        PasswordResetToken reset = createReset(LocalDateTime.now().minusMinutes(1));
        assertThrows(BadCredentialsException.class, () -> auth.resetPassword(reset.getToken(), "new-password123"));
        assertTrue(resets.findByToken(reset.getToken()).isEmpty());
    }

    @Test
    void disabledAccountCannotResetPassword() {
        PasswordResetToken reset = createReset(LocalDateTime.now().plusMinutes(15));
        String hash = jdbc.queryForObject("SELECT password_hash FROM usuarios WHERE email = ?", String.class, "admin@becasfind.cl");
        jdbc.update("UPDATE usuarios SET activo = false WHERE email = ?", "admin@becasfind.cl");
        assertThrows(BadCredentialsException.class, () -> auth.resetPassword(reset.getToken(), "new-password123"));
        assertEquals(hash, jdbc.queryForObject("SELECT password_hash FROM usuarios WHERE email = ?", String.class, "admin@becasfind.cl"));
    }

    @Test
    void testProfileDoesNotRegisterDemoSeeder() {
        assertTrue(context.getBeansOfType(DatabaseSeeder.class).isEmpty());
    }

    @Test
    void demoStartupPreservesDisabledAccountAndPassword() {
        jdbc.update("UPDATE usuarios SET activo = false WHERE email = ?", "admin@becasfind.cl");
        new DatabaseSeeder(users, roles, encoder, jdbc).run();
        assertFalse(jdbc.queryForObject("SELECT activo FROM usuarios WHERE email = ?", Boolean.class, "admin@becasfind.cl"));
        assertEquals(originalHash, jdbc.queryForObject("SELECT password_hash FROM usuarios WHERE email = ?", String.class, "admin@becasfind.cl"));
    }

    @Test
    void recoveryTokenCanOnlyBeUsedOnce() {
        PasswordResetToken reset = createReset(LocalDateTime.now().plusMinutes(15));
        auth.resetPassword(reset.getToken(), "new-password123");
        assertNotNull(login("admin@becasfind.cl", "new-password123"));
        assertTrue(resets.findByToken(reset.getToken()).isEmpty());
        assertThrows(BadCredentialsException.class, () -> auth.resetPassword(reset.getToken(), "another-password123"));
    }

    @Test
    void successfulRecoveryInvalidatesPreviouslyIssuedSessions() {
        String oldToken = adminToken();
        assertEquals(200, get("/api/usuarios", oldToken, Map.class).getStatusCode().value());
        PasswordResetToken reset = createReset(LocalDateTime.now().plusMinutes(15));
        auth.resetPassword(reset.getToken(), "new-session-password123");
        assertEquals(401, get("/api/usuarios", oldToken, Map.class).getStatusCode().value());
        String freshToken = login("admin@becasfind.cl", "new-session-password123");
        assertNotNull(freshToken);
        assertEquals(200, get("/api/usuarios", freshToken, Map.class).getStatusCode().value());
    }

    @Test
    void concurrentRecoveryHasExactlyOneWinner() throws Exception {
        PasswordResetToken reset = createReset(LocalDateTime.now().plusMinutes(15));
        var workers = Executors.newFixedThreadPool(2);
        CountDownLatch ready = new CountDownLatch(2);
        CountDownLatch start = new CountDownLatch(1);
        try {
            var first = workers.submit(() -> consumeReset(reset.getToken(), "first-password123", ready, start));
            var second = workers.submit(() -> consumeReset(reset.getToken(), "second-password123", ready, start));
            assertTrue(ready.await(5, TimeUnit.SECONDS));
            start.countDown();
            boolean firstWon = first.get(10, TimeUnit.SECONDS);
            boolean secondWon = second.get(10, TimeUnit.SECONDS);
            assertNotEquals(firstWon, secondWon);
            String hash = jdbc.queryForObject("SELECT password_hash FROM usuarios WHERE email = ?", String.class, "admin@becasfind.cl");
            assertTrue(encoder.matches(firstWon ? "first-password123" : "second-password123", hash));
            assertFalse(encoder.matches(firstWon ? "second-password123" : "first-password123", hash));
            assertTrue(resets.findByToken(reset.getToken()).isEmpty());
        } finally {
            start.countDown();
            workers.shutdownNow();
            assertTrue(workers.awaitTermination(10, TimeUnit.SECONDS));
        }
    }

    private boolean consumeReset(String token, String password, CountDownLatch ready, CountDownLatch start) throws Exception {
        ready.countDown();
        if (!start.await(5, TimeUnit.SECONDS)) { throw new IllegalStateException("Concurrent test did not start"); }
        try {
            auth.resetPassword(token, password);
            return true;
        } catch (BadCredentialsException expected) {
            return false;
        }
    }

    private PasswordResetToken createReset(LocalDateTime expires) {
        PasswordResetToken reset = new PasswordResetToken();
        reset.setToken(UUID.randomUUID().toString());
        reset.setUsuario(users.findByEmail("admin@becasfind.cl").orElseThrow());
        reset.setFechaExpiracion(expires);
        return resets.save(reset);
    }
}
