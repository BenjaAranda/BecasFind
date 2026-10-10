package com.becasfind.api.tests;

import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.test.context.TestPropertySource;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@TestPropertySource(properties = "AUTH_RATE_LIMIT_ENABLED=true")
class AuthRateLimitTest extends BaseTest {
    @Test
    void loginHttpRejectsEleventhAttemptWithStandardResponse() {
        for (int i = 0; i < 10; i++) {
            assertEquals(HttpStatus.UNAUTHORIZED, post("/api/auth/login", null,
                    Map.of("email", "nobody@example.com", "password", "incorrect123"), Map.class).getStatusCode());
        }
        var response = post("/api/auth/login", null,
                Map.of("email", "nobody@example.com", "password", "incorrect123"), Map.class);
        assertEquals(HttpStatus.TOO_MANY_REQUESTS, response.getStatusCode());
        assertEquals(429, response.getBody().get("status"));
        assertNotNull(response.getBody().get("timestamp"));
        assertTrue(Integer.parseInt(response.getHeaders().getFirst("Retry-After")) > 0);
    }
}
