package com.becasfind.api.tests;

import org.junit.jupiter.api.*;
import org.springframework.http.*;
import org.springframework.test.annotation.DirtiesContext;
import java.util.*;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("CP-28 a CP-62: Detalle y Admin Becas")
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class BecaDetailAdminTest extends BaseTest {

    @Test @DisplayName("CP-28: Ver detalle beca ID valido")
    void detailValidId() {
        var res = get("/api/becas/" + publicScholarshipId(1), null, Map.class);
        assertEquals(200, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-29: Ver detalle beca ID inexistente")
    void detailInvalidId() {
        var res = get("/api/becas/" + publicScholarshipId(99999), null, Map.class);
        assertEquals(404, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-61: Documentos requeridos en detalle")
    void detailDocuments() {
        var res = get("/api/becas/" + publicScholarshipId(1), null, Map.class);
        var data = (Map)res.getBody().get("data");
        var docs = (List)data.get("documentosRequeridos");
        assertNotNull(docs);
    }

    @Test @DisplayName("CP-62: Indicador beca vencida")
    void detailExpiredBadge() {
        var res = get("/api/becas/" + publicScholarshipId(6), null, Map.class);
        assertEquals(200, res.getStatusCodeValue());
        assertEquals("2024-03-01", ((Map)res.getBody().get("data")).get("fechaCierrePostulacion"));
    }

    @Test @DisplayName("CP-45: Crear beca (admin)")
    void adminCreateBeca() {
        var body = Map.of("nombre","Test Beca","idTipoBeca",1,"idInstitucion",1,"fechaCierrePostulacion","2026-12-31","estadoActiva",true,"descripcionCorta","Test");
        var res = post("/api/becas", adminToken(), body, Map.class);
        assertEquals(201, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-46: Crear beca campos vacios")
    void adminCreateBecaEmptyFields() {
        var res = post("/api/becas", adminToken(), Map.of("nombre",""), Map.class);
        assertEquals(400, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-47: Editar beca")
    void adminEditBeca() {
        var token = adminToken(); assertNotNull(token);
        var body = Map.of("nombre","Beca Editada","idTipoBeca",1,"idInstitucion",1,"fechaCierrePostulacion","2026-12-31","estadoActiva",true,"descripcionCorta","X");
        var res = put("/api/becas/1", token, body, Map.class);
        assertEquals(200, res.getStatusCodeValue());
        assertEquals("Beca Editada", ((Map)res.getBody().get("data")).get("nombre"));
    }

    @Test @DisplayName("CP-48: Eliminar beca y sus relaciones según el contrato actual")
    void adminDeleteBeca() {
        var res = delete("/api/becas/3", adminToken());
        assertEquals(200, res.getStatusCodeValue());
        assertEquals(404, get("/api/becas/administracion/3", adminToken(), Map.class).getStatusCodeValue());
    }
}
