package com.becasfind.api.config;

import com.becasfind.api.models.dtos.ApiResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.function.LongSupplier;

/** Límites por dirección de conexión y operación, antes de procesar credenciales. */
public class AuthRateLimitFilter extends OncePerRequestFilter {
    private static final long WINDOW_MS = 15 * 60 * 1000L;
    private static final int MAX_BUCKETS = 4096;
    private final Map<String, Window> windows = new HashMap<>();
    private final ObjectMapper mapper;
    private final boolean enabled;
    private final LongSupplier clock;
    private record Window(long start, int attempts) {}

    public AuthRateLimitFilter(ObjectMapper mapper, boolean enabled, LongSupplier clock) {
        this.mapper = mapper;
        this.enabled = enabled;
        this.clock = clock;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain chain) throws ServletException, IOException {
        int limit = switch (request.getServletPath()) {
            case "/api/auth/login", "/api/auth/reset-password" -> 10;
            case "/api/auth/forgot-password", "/api/auth/register" -> 5;
            default -> 0;
        };
        if (enabled && "POST".equals(request.getMethod()) && limit > 0) {
            // ponytail: contador local para una instancia; reinicios reinician límites.
            // No confiar en X-Forwarded-For enviado directamente por el cliente.
            long retry = consume(request.getRemoteAddr() + "|" + request.getServletPath(), limit);
            if (retry > 0) {
                response.setStatus(429);
                response.setHeader("Retry-After", Long.toString(retry));
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                mapper.writeValue(response.getWriter(), ApiResponse.error(429,
                        "Demasiados intentos. Inténtalo de nuevo más tarde."));
                return;
            }
        }
        chain.doFilter(request, response);
    }

    private synchronized long consume(String key, int limit) {
        long now = clock.getAsLong();
        windows.entrySet().removeIf(entry -> now - entry.getValue().start() >= WINDOW_MS);
        Window window = windows.get(key);
        if (window == null) {
            if (windows.size() >= MAX_BUCKETS) {
                long first = windows.values().stream().mapToLong(Window::start).min().orElse(now);
                return Math.max(1, (WINDOW_MS - (now - first) + 999) / 1000);
            }
            windows.put(key, new Window(now, 1));
            return 0;
        }
        if (window.attempts() >= limit) {
            return Math.max(1, (WINDOW_MS - (now - window.start()) + 999) / 1000);
        }
        windows.put(key, new Window(window.start(), window.attempts() + 1));
        return 0;
    }
}
