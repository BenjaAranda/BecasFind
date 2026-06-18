package com.becasfind.api.tests;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.*;
import org.springframework.test.context.ActiveProfiles;

import java.util.Map;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
public abstract class BaseTest {

    @LocalServerPort
    protected int port;

    @Autowired
    protected TestRestTemplate rest;

    protected String url(String path) {
        return "http://localhost:" + port + path;
    }

    protected HttpHeaders authHeaders(String token) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        if (token != null && !token.isEmpty()) {
            headers.setBearerAuth(token);
        }
        return headers;
    }

    protected String login(String email, String password) {
        Map<String, String> body = Map.of("email", email, "password", password);
        ResponseEntity<Map> response = rest.postForEntity(url("/api/auth/login"),
                new HttpEntity<>(body, authHeaders(null)), Map.class);
        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
            Object data = response.getBody().get("data");
            if (data instanceof Map) {
                return (String) ((Map) data).get("token");
            }
        }
        return null;
    }

    protected String adminToken() {
        return login("admin@becasfind.cl", "admin123");
    }

    protected String studentToken() {
        return login("estudiante@duoc.cl", "admin123");
    }

    protected <T> ResponseEntity<T> get(String path, String token, Class<T> clazz) {
        return rest.exchange(url(path), HttpMethod.GET,
                new HttpEntity<>(authHeaders(token)), clazz);
    }

    protected <T> ResponseEntity<T> post(String path, String token, Object body, Class<T> clazz) {
        return rest.postForEntity(url(path),
                new HttpEntity<>(body, authHeaders(token)), clazz);
    }

    protected <T> ResponseEntity<T> put(String path, String token, Object body, Class<T> clazz) {
        return rest.exchange(url(path), HttpMethod.PUT,
                new HttpEntity<>(body, authHeaders(token)), clazz);
    }

    protected ResponseEntity<Void> delete(String path, String token) {
        return rest.exchange(url(path), HttpMethod.DELETE,
                new HttpEntity<>(authHeaders(token)), Void.class);
    }
}
