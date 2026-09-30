package com.becasfind.api.tests;

import com.becasfind.api.repositories.BecaRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.test.annotation.DirtiesContext;

import java.util.Arrays;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class RequestValidationTest extends BaseTest {
    @Autowired private BecaRepository becas;
    @Autowired private UsuarioRepository usuarios;

    private void rejected(ResponseEntity<Map> response, String context) {
        assertEquals(400, response.getStatusCode().value(), context);
        assertNotNull(response.getBody());
        assertEquals(400, response.getBody().get("status"));
        assertNotNull(response.getBody().get("validationErrors"), context);
    }

    private Map<Object, Object> scholarshipSnapshot(Object data) {
        var result = new LinkedHashMap<Object, Object>((Map<?, ?>) data);
        for (String key : List.of("regiones", "documentosRequeridos")) {
            result.put(key, ((List<?>) result.get(key)).stream().sorted(Comparator.comparing(Object::toString)).toList());
        }
        return result;
    }

    @Test
    void invalidProfileDoesNotOverwriteSavedValues() {
        String token = studentToken();
        var before = get("/api/perfil", token, Map.class).getBody().get("data");
        for (var entry : List.of(Map.entry("rshPorcentaje", -1), Map.entry("rshPorcentaje", 101),
                Map.entry("nemPromedio", 0.9), Map.entry("nemPromedio", 7.1), Map.entry("nemPromedio", 5.55),
                Map.entry("idRegion", 0), Map.entry("idInstitucion", -1), Map.entry("carreraInteres", "á".repeat(256)))) {
            rejected(put("/api/perfil", token, Map.of(entry.getKey(), entry.getValue()), Map.class), entry.getKey());
            assertEquals(before, get("/api/perfil", token, Map.class).getBody().get("data"));
        }
    }

    @Test
    void invalidScholarshipsAndNestedDocumentsRejectBeforeCreatingOrUpdating() {
        String token = adminToken();
        long count = becas.count();
        var original = scholarshipSnapshot(get("/api/becas/1", token, Map.class).getBody().get("data"));
        var valid = Map.<String, Object>of("nombre", "Validación de beca", "idInstitucion", 1,
                "idTipoBeca", 1, "fechaCierrePostulacion", "2030-12-31");
        for (var entry : List.of(Map.entry("nombre", "á".repeat(256)), Map.entry("idInstitucion", 0),
                Map.entry("idTipoBeca", -1), Map.entry("rshMaximoPorcentaje", 101), Map.entry("nemMinimo", 5.55),
                Map.entry("paesMinimo", 1001), Map.entry("montoCobertura", "a".repeat(256)),
                Map.entry("fechaInicioPostulacion", "2031-01-01"), Map.entry("urlOficial", "javascript:alert(1)"),
                Map.entry("urlOficial", "https://user:pass@example.com/becas"),
                Map.entry("regionesIds", List.of(-1)), Map.entry("regionesIds", Arrays.asList(1, null)),
                Map.entry("documentosRequeridos", List.of(Map.of("nombreDocumento", " ", "esObligatorio", true))),
                Map.entry("documentosRequeridos", List.of(Map.of("nombreDocumento", "Documento"))),
                Map.entry("documentosRequeridos", Arrays.asList((Object) null)))) {
            var body = new LinkedHashMap<String, Object>(valid);
            body.put(entry.getKey(), entry.getValue());
            rejected(post("/api/becas", token, body, Map.class), entry.getKey());
            rejected(put("/api/becas/1", token, body, Map.class), entry.getKey());
            assertEquals(count, becas.count());
            assertEquals(original, scholarshipSnapshot(get("/api/becas/1", token, Map.class).getBody().get("data")));
        }
        String nullState = "{\"nombre\":\"Estado nulo\",\"idInstitucion\":1,\"idTipoBeca\":1,"
                + "\"fechaCierrePostulacion\":\"2030-12-31\",\"estadoActiva\":null}";
        rejected(post("/api/becas", token, nullState, Map.class), "estadoActiva");
    }

    @Test
    void invalidAdministrativeAccountsRejectBeforeWriting() {
        String token = adminToken();
        long count = usuarios.count();
        var valid = Map.<String, Object>of("email", "validation@example.com", "nombreCompleto", "María",
                "password", "secure-password", "idRol", 1);
        for (var entry : List.of(Map.entry("password", "short"), Map.entry("password", "a".repeat(73)),
                Map.entry("password", "á".repeat(37)), Map.entry("idRol", 0),
                Map.entry("nombreCompleto", "á".repeat(256)), Map.entry("email", "a".repeat(250) + "@example.com"))) {
            var body = new LinkedHashMap<String, Object>(valid);
            body.put(entry.getKey(), entry.getValue());
            rejected(post("/api/usuarios", token, body, Map.class), entry.getKey());
            assertEquals(count, usuarios.count());
        }
        rejected(put("/api/usuarios/1", token, Map.of("email", "admin@example.com", "nombreCompleto", "a".repeat(256)), Map.class), "nombreCompleto");
    }

    @Test
    void optionalProfileCanSaveBoundaryValuesAndClearThem() {
        String token = studentToken();
        var saved = put("/api/perfil", token, Map.of("rshPorcentaje", 0, "nemPromedio", 7.0), Map.class);
        assertEquals(200, saved.getStatusCode().value());
        var data = (Map<?, ?>) saved.getBody().get("data");
        assertEquals(0, data.get("rshPorcentaje"));
        assertEquals(7.0, ((Number) data.get("nemPromedio")).doubleValue());
        assertEquals(200, put("/api/perfil", token, Map.of(), Map.class).getStatusCode().value());
        var cleared = (Map<?, ?>) get("/api/perfil", token, Map.class).getBody().get("data");
        assertNull(cleared.get("rshPorcentaje"));
        assertNull(cleared.get("nemPromedio"));
    }

    @Test
    void validNestedDocumentsAndEmptyListsRemainSupported() {
        String token = adminToken();
        var body = new LinkedHashMap<String, Object>();
        body.put("nombre", "Beca de validación positiva");
        body.put("idInstitucion", 1);
        body.put("idTipoBeca", 1);
        body.put("fechaInicioPostulacion", "2030-12-31");
        body.put("fechaCierrePostulacion", "2030-12-31");
        body.put("urlOficial", "https://example.com/becas?convocatoria=2030");
        body.put("rshMaximoPorcentaje", 100);
        body.put("nemMinimo", 1.0);
        body.put("paesMinimo", 1000);
        body.put("regionesIds", List.of(1));
        body.put("documentosRequeridos", List.of(Map.of("nombreDocumento", "Certificado de matrícula", "esObligatorio", false)));
        var created = post("/api/becas", token, body, Map.class);
        assertTrue(created.getStatusCode().is2xxSuccessful());
        long id = ((Number) ((Map<?, ?>) created.getBody().get("data")).get("idBeca")).longValue();
        body.put("regionesIds", List.of());
        body.put("documentosRequeridos", List.of());
        assertEquals(200, put("/api/becas/" + id, token, body, Map.class).getStatusCode().value());
        var detail = (Map<?, ?>) get("/api/becas/" + id, token, Map.class).getBody().get("data");
        assertTrue(((List<?>) detail.get("regiones")).isEmpty());
        assertTrue(((List<?>) detail.get("documentosRequeridos")).isEmpty());
    }
}
