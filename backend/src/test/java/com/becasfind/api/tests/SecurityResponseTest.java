package com.becasfind.api.tests;

import com.becasfind.api.utils.JwtUtil;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.test.annotation.DirtiesContext;
import java.util.Map;
import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class SecurityResponseTest extends BaseTest {
    @Value("${app.jwt.secret}") String secret;

    @Test void missingAndMalformedSessionsReturnJson401() {
        assertUnauthorized(get("/api/perfil", null, Map.class));
        assertUnauthorized(get("/api/perfil", "invalid-token", Map.class));
    }

    @Test void expiredAndIncorrectlySignedSessionsReturnJson401() {
        String expired = new JwtUtil(secret, -1000).generateToken(
                "admin@becasfind.cl", "ADMIN", "Admin", "test-hash");
        String forged = new JwtUtil("different-signing-key-for-tests-only-12345678901234567890", 60000)
                .generateToken("admin@becasfind.cl", "ADMIN", "Admin", "test-hash");
        assertUnauthorized(get("/api/perfil", expired, Map.class));
        assertUnauthorized(get("/api/perfil", forged, Map.class));
    }

    @Test void validStudentWithoutPermissionGets403AndKeepsSession() {
        String token = studentToken();
        ResponseEntity<Map> denied = get("/api/usuarios", token, Map.class);
        assertEnvelope(denied, 403);
        assertNull(denied.getHeaders().getFirst("WWW-Authenticate"));
        assertEquals(200, get("/api/perfil", token, Map.class).getStatusCode().value());
    }

    @Test void publicCatalogStillAllowsAnInvalidOptionalToken() {
        assertEquals(200, get("/api/regiones", "invalid-token", Map.class).getStatusCode().value());
    }

    private void assertUnauthorized(ResponseEntity<Map> response) {
        assertEnvelope(response, 401);
        assertEquals("Bearer", response.getHeaders().getFirst("WWW-Authenticate"));
    }

    private void assertEnvelope(ResponseEntity<Map> response, int status) {
        assertEquals(status, response.getStatusCode().value());
        assertNotNull(response.getHeaders().getContentType());
        assertTrue(response.getHeaders().getContentType().isCompatibleWith(org.springframework.http.MediaType.APPLICATION_JSON));
        assertNotNull(response.getBody());
        assertEquals(status, response.getBody().get("status"));
        assertNotNull(response.getBody().get("timestamp"));
        assertNotNull(response.getBody().get("message"));
        assertTrue(response.getBody().containsKey("data"));
        assertNull(response.getBody().get("data"));
    }
}
