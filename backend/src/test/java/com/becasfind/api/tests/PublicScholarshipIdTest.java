package com.becasfind.api.tests;

import org.junit.jupiter.api.Test;
import org.springframework.test.annotation.DirtiesContext;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class PublicScholarshipIdTest extends BaseTest {
    @Test void publicSearchAndDetailExposeStableUuidWithoutPrivateChildIds() {
        String id = publicScholarshipId(1);
        UUID.fromString(id);
        var search = post("/api/becas/buscar", studentToken(), Map.of("query", "Nuevo Milenio"), Map.class);
        var rows = (List<?>) ((Map<?, ?>) search.getBody().get("data")).get("content");
        var summary = (Map<?, ?>) rows.get(0);
        assertEquals(id, summary.get("idBeca"));
        assertFalse(summary.containsKey("publicId"));
        var detail = (Map<?, ?>) get("/api/becas/" + id, null, Map.class).getBody().get("data");
        assertEquals(id, detail.get("idBeca"));
        assertFalse(((Map<?, ?>) detail.get("requisitoPerfil")).containsKey("idRequisito"));
        for (var doc : (List<?>) detail.get("documentosRequeridos")) assertFalse(((Map<?, ?>) doc).containsKey("idDocumento"));
        assertEquals(id, ((Map<?, ?>) get("/api/becas/" + id, null, Map.class).getBody().get("data")).get("idBeca"));
    }

    @Test void numericPublicLinksAreRejectedAndAdministrativeDetailRequiresAdmin() {
        assertEquals(400, get("/api/becas/1", null, Map.class).getStatusCode().value());
        assertEquals(401, get("/api/becas/administracion/1", null, Map.class).getStatusCode().value());
        assertEquals(403, get("/api/becas/administracion/1", studentToken(), Map.class).getStatusCode().value());
        var admin = get("/api/becas/administracion/1", adminToken(), Map.class);
        assertEquals(200, admin.getStatusCode().value());
        assertEquals(1, ((Map<?, ?>) admin.getBody().get("data")).get("idBeca"));
        var listing = get("/api/becas/administracion?query=Nuevo%20Milenio", adminToken(), Map.class);
        var row = (Map<?, ?>)((List<?>)((Map<?, ?>)listing.getBody().get("data")).get("content")).get(0);
        assertEquals(publicScholarshipId(1), row.get("publicId"));
        assertEquals(404, get("/api/becas/" + UUID.randomUUID(), null, Map.class).getStatusCode().value());
    }

    @Test void favoritesUseUuidAndRemainAccountIsolated() {
        String id = publicScholarshipId(1);
        String student = studentToken();
        String admin = adminToken();
        try {
            assertEquals(200, post("/api/favoritos/" + id, student, null, Map.class).getStatusCode().value());
            var favorites = (List<?>) get("/api/favoritos", student, Map.class).getBody().get("data");
            assertEquals(1, favorites.stream().filter(b -> id.equals(((Map<?, ?>) b).get("idBeca"))).count());
            var other = (Map<?, ?>) get("/api/favoritos/" + id + "/check", admin, Map.class).getBody().get("data");
            assertEquals(false, other.get("favorito"));
            assertEquals(400, post("/api/favoritos/1", student, null, Map.class).getStatusCode().value());
        } finally { delete("/api/favoritos/" + id, student); }
    }
}
