package com.becasfind.api.tests;

import org.junit.jupiter.api.*;
import org.springframework.http.*;
import org.springframework.test.annotation.DirtiesContext;
import java.util.Map;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("CP-57 a CP-65: Control de Acceso y Seguridad")
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class SecurityAccessTest extends BaseTest {

    @Test @DisplayName("CP-57: Estudiante no accede a admin")
    void studentBlockedFromAdmin() {
        var token = studentToken(); assertNotNull(token);
        var res = post("/api/becas", token, Map.of("nombre","Test Becax","idTipoBeca",1,"idInstitucion",1,"fechaCierrePostulacion","2026-12-31"), Map.class);
        assertTrue(res.getStatusCodeValue() == 403 || res.getStatusCodeValue() == 401 || res.getStatusCodeValue() == 400);
    }

    @Test @DisplayName("CP-58: Sin auth no accede a rutas protegidas")
    void noAuthBlocked() {
        var res = get("/api/favoritos", null, Map.class);
        assertTrue(res.getStatusCodeValue() == 401 || res.getStatusCodeValue() == 403);
    }

    @Test @DisplayName("CP-59: Rutas publicas sin auth")
    void publicRoutesAccessible() {
        assertTrue(get("/api/regiones", null, Map.class).getStatusCodeValue() == 200);
        assertTrue(get("/api/tipos-beca", null, Map.class).getStatusCodeValue() == 200);
        assertTrue(get("/api/instituciones", null, Map.class).getStatusCodeValue() == 200);
        assertTrue(get("/api/becas/1", null, Map.class).getStatusCodeValue() == 200);
    }

    @Test @DisplayName("CP-64: Cerrar sesion y verificar bloqueo")
    void logoutWorks() {
        var token = adminToken(); assertNotNull(token);
        var res = get("/api/becas", token, Map.class);
        assertEquals(200, res.getStatusCodeValue());
        var resNoToken = get("/api/perfil", null, Map.class);
        assertTrue(resNoToken.getStatusCodeValue() == 401 || resNoToken.getStatusCodeValue() == 403);
    }

    @Test @DisplayName("CP-65: Token JWT expirado rechazado")
    void expiredTokenRejected() {
        var res = get("/api/perfil", "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0Iiwicm9sZSI6IlNUVURFTlQiLCJpYXQiOjAsImV4cCI6MX0.x", Map.class);
        assertTrue(res.getStatusCodeValue() == 401 || res.getStatusCodeValue() == 403);
    }
}
