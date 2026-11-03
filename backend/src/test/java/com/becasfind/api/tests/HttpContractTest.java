package com.becasfind.api.tests;

import org.junit.jupiter.api.Test;
import org.springframework.http.*;
import org.springframework.test.annotation.DirtiesContext;
import java.util.Map;
import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class HttpContractTest extends BaseTest {
    @Test void validationErrorsKeepFieldDetailsInTheCommonEnvelope() {
        ResponseEntity<Map> response = post("/api/auth/login", null,
                Map.of("email", "invalid", "password", ""), Map.class);
        assertError(response, 400);
        assertEquals("/api/auth/login", response.getBody().get("path"));
        assertNotNull(response.getBody().get("error"));
        assertTrue(((Map) response.getBody().get("validationErrors")).containsKey("email"));
    }

    @Test void authenticationNotFoundAndAuthorizationErrorsUseTheCommonEnvelope() {
        assertError(post("/api/auth/login", null,
                Map.of("email", "missing@example.com", "password", "password123"), Map.class), 401);
        assertError(get("/api/usuarios/999999", adminToken(), Map.class), 404);
        assertError(get("/api/usuarios", studentToken(), Map.class), 403);
    }

    @Test void malformedJsonAndTypesReturn400AcrossControllers() {
        assertError(post("/api/auth/login", null, "{", Map.class), 400);
        assertError(put("/api/perfil", studentToken(), "{", Map.class), 400);
        assertError(get("/api/usuarios/abc", adminToken(), Map.class), 400);
        assertError(post("/api/favoritos/abc", studentToken(), null, Map.class), 400);
    }

    @Test void missingImportFileReturns400() {
        HttpHeaders headers = authHeaders(adminToken());
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        assertError(rest.postForEntity(url("/api/becas/importar-csv"),
                new HttpEntity<>(new org.springframework.util.LinkedMultiValueMap<>(), headers), Map.class), 400);
    }

    @Test void unsupportedMethodPreserves405AndAllowHeader() {
        ResponseEntity<Map> response = rest.exchange(url("/api/favoritos"), HttpMethod.PUT,
                new HttpEntity<>("{}", authHeaders(studentToken())), Map.class);
        assertError(response, 405);
        assertTrue(response.getHeaders().getAllow().contains(HttpMethod.GET));
    }

    @Test void unsupportedContentReturns415() {
        HttpHeaders headers = authHeaders(null);
        headers.setContentType(MediaType.TEXT_PLAIN);
        assertError(rest.postForEntity(url("/api/auth/login"),
                new HttpEntity<>("hello", headers), Map.class), 415);
    }

    @Test void createdRegistrationHasMatchingBodyStatus() {
        ResponseEntity<Map> response = post("/api/auth/register", null,
                Map.of("nombreCompleto", "Contrato HTTP", "email", "http-contract@example.com",
                        "password", "password123"), Map.class);
        assertEquals(201, response.getStatusCode().value());
        assertEquals(201, response.getBody().get("status"));
        assertNotNull(response.getBody().get("data"));
    }

    private void assertError(ResponseEntity<Map> response, int status) {
        assertEquals(status, response.getStatusCode().value());
        assertNotNull(response.getBody());
        assertEquals(status, response.getBody().get("status"));
        assertNotNull(response.getBody().get("timestamp"));
        assertNotNull(response.getBody().get("message"));
        assertTrue(response.getBody().containsKey("data"));
        assertNull(response.getBody().get("data"));
    }

    @Test void administrativeCreationHasMatchingStatusAndRejectsStudent() {
        Map<String, Object> user = Map.of("nombreCompleto", "Usuario HTTP", "email",
                "admin-http-contract@example.com", "password", "password123", "idRol", 2);
        assertEquals(403, post("/api/usuarios", studentToken(), user, Map.class).getStatusCode().value());
        ResponseEntity<Map> created = post("/api/usuarios", adminToken(), user, Map.class);
        assertEquals(201, created.getStatusCode().value());
        assertEquals(201, created.getBody().get("status"));
        assertFalse(((Map) created.getBody().get("data")).containsKey("password"));
        Map<String, Object> scholarship = Map.of("nombre", "Beca HTTP", "idInstitucion", 1,
                "idTipoBeca", 1, "fechaCierrePostulacion", "2027-12-31");
        assertEquals(403, post("/api/becas", studentToken(), scholarship, Map.class).getStatusCode().value());
        created = post("/api/becas", adminToken(), scholarship, Map.class);
        assertEquals(201, created.getStatusCode().value());
        assertEquals(201, created.getBody().get("status"));
    }
}
