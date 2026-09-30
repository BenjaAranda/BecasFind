package com.becasfind.api.tests;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class AdminScholarshipListingTest extends BaseTest {
    @Autowired JdbcTemplate jdbc;

    @Test
    void onlyAdminCanAccessTheCompleteListing() {
        assertEquals(401, get("/api/becas/administracion", null, Map.class).getStatusCode().value());
        assertEquals(403, get("/api/becas/administracion", studentToken(), Map.class).getStatusCode().value());
        assertEquals(200, get("/api/becas/administracion", adminToken(), Map.class).getStatusCode().value());
    }

    @Test
    void adminCanSearchInactiveExpiredScholarshipWhilePublicSearchExcludesIt() {
        var previous = jdbc.queryForMap("SELECT estado_activa, fecha_cierre_postulacion FROM becas WHERE id_beca = 1");
        try {
            jdbc.update("UPDATE becas SET estado_activa = false, fecha_cierre_postulacion = DATE '2020-01-01' WHERE id_beca = 1");
            var admin = get("/api/becas/administracion?query=Nuevo&size=100", adminToken(), Map.class);
            assertEquals(200, admin.getStatusCode().value());
            var data = (Map<?, ?>) admin.getBody().get("data");
            var content = (List<Map<String, Object>>) data.get("content");
            assertTrue(content.stream().anyMatch(row -> ((Number) row.get("idBeca")).longValue() == 1));
            assertEquals(false, content.stream().filter(row -> ((Number) row.get("idBeca")).longValue() == 1).findFirst().orElseThrow().get("estadoActiva"));
            var publicResult = get("/api/becas?size=100", null, Map.class);
            var publicData = (Map<?, ?>) publicResult.getBody().get("data");
            var publicRows = (List<Map<String, Object>>) publicData.get("content");
            assertFalse(publicRows.stream().anyMatch(row -> ((Number) row.get("idBeca")).longValue() == 1));
        } finally {
            jdbc.update("UPDATE becas SET estado_activa = ?, fecha_cierre_postulacion = ? WHERE id_beca = 1",
                    previous.get("estado_activa"), previous.get("fecha_cierre_postulacion"));
        }
    }

    @Test
    void administrativePaginationAndMalformedInputsAreValidated() {
        String token = adminToken();
        var first = get("/api/becas/administracion?size=2&page=0", token, Map.class);
        var second = get("/api/becas/administracion?size=2&page=1", token, Map.class);
        var firstRows = (List<Map<String, Object>>) ((Map<?, ?>) first.getBody().get("data")).get("content");
        var secondRows = (List<Map<String, Object>>) ((Map<?, ?>) second.getBody().get("data")).get("content");
        assertEquals(2, firstRows.size());
        assertEquals(2, secondRows.size());
        assertTrue(firstRows.stream().noneMatch(a -> secondRows.stream().anyMatch(b -> a.get("idBeca").equals(b.get("idBeca")))));
        for (String params : List.of("size=101", "page=-1", "size=0", "size=no-numérico", "query=" + "x".repeat(201))) {
            assertEquals(400, get("/api/becas/administracion?" + params, token, Map.class).getStatusCode().value());
        }
        assertEquals(400, get("/api/becas?size=incorrecto", null, Map.class).getStatusCode().value());
        var malformed = post("/api/becas/buscar", token, "{", Map.class);
        assertEquals(400, malformed.getStatusCode().value());
        assertEquals(400, malformed.getBody().get("status"));
    }
}
