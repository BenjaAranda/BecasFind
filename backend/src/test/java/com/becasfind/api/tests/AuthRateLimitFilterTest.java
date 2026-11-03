package com.becasfind.api.tests;

import com.becasfind.api.config.AuthRateLimitFilter;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.IntStream;

import static org.junit.jupiter.api.Assertions.*;

class AuthRateLimitFilterTest {
    private final AtomicLong time = new AtomicLong(1000);
    private final AuthRateLimitFilter filter = new AuthRateLimitFilter(
            new ObjectMapper().findAndRegisterModules(), true, time::get);

    private int attempt(AuthRateLimitFilter target, String path, String ip, String forwarded) throws Exception {
        var request = new MockHttpServletRequest("POST", path);
        request.setServletPath(path);
        request.setRemoteAddr(ip);
        request.addHeader("X-Forwarded-For", forwarded);
        var response = new MockHttpServletResponse();
        target.doFilter(request, response, (req, res) -> res.setContentType("passed"));
        if (response.getStatus() == 429) assertNotEquals("passed", response.getContentType());
        return response.getStatus();
    }

    @Test
    void expiryRestoresBudgetAndForwardedHeaderCannotBypassIt() throws Exception {
        for (int i = 0; i < 5; i++) assertEquals(200,
                attempt(filter, "/api/auth/forgot-password", "127.0.0.1", "spoof" + i));
        assertEquals(429, attempt(filter, "/api/auth/forgot-password", "127.0.0.1", "new"));
        time.addAndGet(900_000);
        assertEquals(200, attempt(filter, "/api/auth/forgot-password", "127.0.0.1", "new"));
    }

    @Test
    void clientsAndOperationsHaveIndependentBudgets() throws Exception {
        for (int i = 0; i < 5; i++) attempt(filter, "/api/auth/forgot-password", "a", "a");
        assertEquals(429, attempt(filter, "/api/auth/forgot-password", "a", "a"));
        assertEquals(200, attempt(filter, "/api/auth/forgot-password", "b", "a"));
        assertEquals(200, attempt(filter, "/api/auth/login", "a", "a"));
    }

    @Test
    void publicRequestsAndDisabledLimiterAreUnaffected() throws Exception {
        var disabled = new AuthRateLimitFilter(new ObjectMapper(), false, time::get);
        for (int i = 0; i < 20; i++) {
            assertEquals(200, attempt(filter, "/api/becas", "a", "a"));
            assertEquals(200, attempt(disabled, "/api/auth/login", "a", "a"));
        }
    }

    @Test
    void concurrentRequestsCannotExceedBudget() {
        AtomicInteger allowed = new AtomicInteger();
        IntStream.range(0, 40).parallel().forEach(i -> {
            try {
                if (attempt(filter, "/api/auth/login", "a", "a") == 200) allowed.incrementAndGet();
            } catch (Exception exception) {
                throw new AssertionError(exception);
            }
        });
        assertEquals(10, allowed.get());
    }
}
