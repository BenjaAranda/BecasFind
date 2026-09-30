package com.becasfind.api.tests;

import com.becasfind.api.utils.JwtUtil;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.junit.jupiter.api.Test;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Date;
import static org.junit.jupiter.api.Assertions.*;

class JwtCredentialBindingTest {
    private static final String SECRET = "test-signing-secret-for-credential-binding-only-12345678901234567890";
    private final JwtUtil jwt = new JwtUtil(SECRET, 86400000);

    @Test void passwordChangesInvalidateBindingWithoutExposingStoredHash() {
        String hash = "$2a$10$example-stored-bcrypt-hash";
        String token = jwt.generateToken("user@example.com", "STUDENT", "Usuario", hash);
        assertTrue(jwt.isTokenValid(token));
        assertTrue(jwt.matchesCredentials(token, hash));
        assertFalse(jwt.matchesCredentials(token, "$2a$10$different-stored-bcrypt-hash"));
        String payload = new String(Base64.getUrlDecoder().decode(token.split("\\.")[1]), StandardCharsets.UTF_8);
        assertFalse(payload.contains(hash));
        assertFalse(payload.contains("passwordHash"));
    }

    @Test void legacySignedTokensWithoutBindingAreRejected() {
        String token = Jwts.builder().subject("user@example.com")
                .expiration(new Date(System.currentTimeMillis() + 60000))
                .signWith(Keys.hmacShaKeyFor(SECRET.getBytes(StandardCharsets.UTF_8))).compact();
        assertTrue(jwt.isTokenValid(token));
        assertFalse(jwt.matchesCredentials(token, "stored-hash"));
    }

    @Test void bindingWithWrongClaimTypeIsRejectedWithoutThrowing() {
        String token = Jwts.builder().subject("user@example.com").claim("cv", 123)
                .expiration(new Date(System.currentTimeMillis() + 60000))
                .signWith(Keys.hmacShaKeyFor(SECRET.getBytes(StandardCharsets.UTF_8))).compact();
        assertTrue(jwt.isTokenValid(token));
        assertFalse(jwt.matchesCredentials(token, "stored-hash"));
    }
}
