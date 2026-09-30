package com.becasfind.api.tests;

import org.junit.jupiter.api.Test;
import org.springframework.test.annotation.DirtiesContext;
import java.util.*;
import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class ProfilePersistenceTest extends BaseTest {
    private Map<?, ?> profile(String token) {
        var response = get("/api/perfil", token, Map.class);
        assertEquals(200, response.getStatusCode().value());
        return (Map<?, ?>) response.getBody().get("data");
    }

    @Test void profileRoundTripPreservesZeroAccentsAndExplicitClearing() {
        String token = studentToken();
        Map<String, Object> payload = new HashMap<>(Map.of("rshPorcentaje", 0, "nemPromedio", 5.5,
                "idRegion", 1, "idInstitucion", 1, "carreraInteres", "Educación en Ñuble",
                "esPrimerAnio", true, "esCursoSuperior", false));
        assertEquals(200, put("/api/perfil", token, payload, Map.class).getStatusCode().value());
        Map<?, ?> saved = profile(token);
        assertEquals(0, saved.get("rshPorcentaje"));
        assertEquals(5.5, ((Number) saved.get("nemPromedio")).doubleValue());
        assertEquals("Educación en Ñuble", saved.get("carreraInteres"));
        payload.put("idRegion", null);
        payload.put("idInstitucion", null);
        payload.put("carreraInteres", null);
        assertEquals(200, put("/api/perfil", token, payload, Map.class).getStatusCode().value());
        saved = profile(token);
        assertNull(saved.get("region"));
        assertNull(saved.get("institucion"));
        assertNull(saved.get("carreraInteres"));
        assertEquals(0, saved.get("rshPorcentaje"));
    }

    @Test void invalidReferenceRollsBackExistingProfile() {
        String token = studentToken();
        assertEquals(200, put("/api/perfil", token, Map.of("rshPorcentaje", 60,
                "nemPromedio", 5.5, "idRegion", 1), Map.class).getStatusCode().value());
        Map<?, ?> before = profile(token);
        assertEquals(404, put("/api/perfil", token, Map.of("rshPorcentaje", 20,
                "nemPromedio", 6.0, "idRegion", 999999), Map.class).getStatusCode().value());
        assertEquals(before, profile(token));
    }

    @Test void favoritesAreIdempotentPersistentAndIsolatedByAccount() {
        String student = studentToken();
        String admin = adminToken();
        delete("/api/favoritos/1", student);
        delete("/api/favoritos/1", admin);
        for (int i = 0; i < 2; i++) {
            assertEquals(200, post("/api/favoritos/1", student, null, Map.class).getStatusCode().value());
        }
        var check = get("/api/favoritos/1/check", student, Map.class);
        assertEquals(true, ((Map<?, ?>) check.getBody().get("data")).get("favorito"));
        List<?> favorites = (List<?>) get("/api/favoritos", student, Map.class).getBody().get("data");
        assertEquals(1, favorites.stream().filter(item -> Integer.valueOf(1).equals(((Map<?, ?>) item).get("idBeca"))).count());
        check = get("/api/favoritos/1/check", admin, Map.class);
        assertEquals(false, ((Map<?, ?>) check.getBody().get("data")).get("favorito"));
        assertEquals(200, delete("/api/favoritos/1", student).getStatusCode().value());
        assertEquals(200, delete("/api/favoritos/1", student).getStatusCode().value());
        check = get("/api/favoritos/1/check", student, Map.class);
        assertEquals(false, ((Map<?, ?>) check.getBody().get("data")).get("favorito"));
    }

    @Test void recommendationsMatchSearchUsingPersistedProfileCriteria() {
        String token = studentToken();
        assertEquals(200, put("/api/perfil", token, Map.of("rshPorcentaje", 60,
                "nemPromedio", 5.5, "idRegion", 1), Map.class).getStatusCode().value());
        var recommendations = get("/api/becas/recomendadas", token, Map.class);
        var search = post("/api/becas/buscar", token, Map.of("rsh", 60, "nem", 5.5,
                "regionId", 1, "sort", "fechaAsc", "page", 0, "size", 10), Map.class);
        assertEquals(200, recommendations.getStatusCode().value());
        assertEquals(200, search.getStatusCode().value());
        Map<?, ?> recommendedPage = (Map<?, ?>) recommendations.getBody().get("data");
        Map<?, ?> searchPage = (Map<?, ?>) search.getBody().get("data");
        assertEquals(searchPage.get("content"), recommendedPage.get("content"));
        assertEquals(searchPage.get("totalElements"), recommendedPage.get("totalElements"));
        assertFalse(((List<?>) recommendedPage.get("content")).isEmpty());
    }
}
