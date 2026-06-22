package com.becasfind.api.tests;

import org.junit.jupiter.api.*;
import org.springframework.http.*;
import org.springframework.test.annotation.DirtiesContext;
import java.util.*;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("CP-01 a CP-16: Autenticacion y Recuperacion")
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class AuthTest extends BaseTest {

    @Test @DisplayName("CP-01: Login exitoso con credenciales validas")
    void loginSuccess() {
        var res = post("/api/auth/login", null, Map.of("email","admin@becasfind.cl","password","admin123"), Map.class);
        assertEquals(200, res.getStatusCodeValue());
        var data = (Map)res.getBody().get("data");
        assertNotNull(data.get("token"));
        assertEquals("ADMIN", data.get("nombreRol"));
    }

    @Test @DisplayName("CP-02: Login fallido - contrasena incorrecta")
    void loginBadPassword() {
        var res = post("/api/auth/login", null, Map.of("email","admin@becasfind.cl","password","wrong"), Map.class);
        assertEquals(401, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-03: Login fallido - email no registrado")
    void loginUnknownEmail() {
        var res = post("/api/auth/login", null, Map.of("email","fake@noexiste.cl","password","admin123"), Map.class);
        assertEquals(401, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-04: Login fallido - campos vacios")
    void loginEmptyFields() {
        var res = post("/api/auth/login", null, Map.of("email","","password",""), Map.class);
        assertTrue(res.getStatusCodeValue() == 400 || res.getStatusCodeValue() == 401);
    }

    @Test @DisplayName("CP-05: Login fallido - email invalido")
    void loginInvalidEmail() {
        var res = post("/api/auth/login", null, Map.of("email","not-an-email","password","admin123"), Map.class);
        assertTrue(res.getStatusCodeValue() == 400 || res.getStatusCodeValue() == 401);
    }

    @Test @DisplayName("CP-06: Registro exitoso con datos validos")
    void registerSuccess() {
        var res = post("/api/auth/register", null, Map.of("nombreCompleto","Test User","email","nuevo@test.cl","password","password123"), Map.class);
        assertTrue(res.getStatusCodeValue() >= 200 && res.getStatusCodeValue() < 300);
        var data = (Map)res.getBody().get("data");
        assertNotNull(data.get("token"));
    }

    @Test @DisplayName("CP-07: Registro fallido - email duplicado")
    void registerDuplicateEmail() {
        var res = post("/api/auth/register", null, Map.of("nombreCompleto","X","email","admin@becasfind.cl","password","password123"), Map.class);
        assertTrue(res.getStatusCodeValue() >= 400);
    }

    @Test @DisplayName("CP-08: Registro fallido - contrasena corta")
    void registerShortPassword() {
        var res = post("/api/auth/register", null, Map.of("nombreCompleto","X","email","x@x.cl","password","123"), Map.class);
        assertEquals(400, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-09: Registro fallido - email invalido")
    void registerInvalidEmail() {
        var res = post("/api/auth/register", null, Map.of("nombreCompleto","X","email","bad","password","password123"), Map.class);
        assertEquals(400, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-10: Registro fallido - campos vacios")
    void registerEmptyFields() {
        var res = post("/api/auth/register", null, Map.of("nombreCompleto","","email","","password",""), Map.class);
        assertEquals(400, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-11: Recuperacion - envio exitoso")
    void forgotPassword() {
        var res = post("/api/auth/forgot-password", null, Map.of("email","admin@becasfind.cl"), Map.class);
        assertEquals(200, res.getStatusCodeValue());
        var resFake = post("/api/auth/forgot-password", null, Map.of("email","noexiste@test.cl"), Map.class);
        assertTrue(resFake.getStatusCodeValue() == 200 || resFake.getStatusCodeValue() == 404);
    }

    @Test @DisplayName("CP-13+CP-14: Reset password - token invalido")
    void resetPasswordInvalidToken() {
        var res = post("/api/auth/reset-password", null, Map.of("token","fake-token","newPassword","password123"), Map.class);
        assertEquals(401, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-16: Reset password - contrasena corta")
    void resetPasswordShort() {
        var res = post("/api/auth/reset-password", null, Map.of("token","fake-token","newPassword","123"), Map.class);
        assertEquals(400, res.getStatusCodeValue());
    }
}
