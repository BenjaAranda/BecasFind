package com.becasfind.api.tests;

import com.becasfind.api.services.CatalogoPublico;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import java.util.Map;
import static org.junit.jupiter.api.Assertions.*;

class PublicCatalogTest extends BaseTest {
    @Autowired JdbcTemplate jdbc;
    @Autowired CatalogoPublico catalogo;

    @Test void approvedUnknownDatesRemainVisibleWithoutOpeningApplications() {
        var original = jdbc.queryForMap("select public_id,estado_activa,fecha_inicio_postulacion,fecha_cierre_postulacion from becas where id_beca=1");
        var approved = catalogo.getPublicIds().iterator().next();
        try {
            jdbc.update("update becas set estado_activa=false,fecha_cierre_postulacion=null where id_beca=1");
            assertEquals(404, get("/api/becas/catalogo/" + original.get("public_id"), null, Map.class).getStatusCode().value());
            jdbc.update("update becas set public_id=?,estado_activa=false,fecha_inicio_postulacion=null,fecha_cierre_postulacion=null where id_beca=1", approved);
            var detail = get("/api/becas/catalogo/" + approved, null, Map.class);
            assertEquals(200, detail.getStatusCode().value());
            var data = (Map<?, ?>) detail.getBody().get("data");
            assertEquals(approved.toString(), data.get("idBeca"));
            assertEquals(false, data.get("estadoActiva"));
            assertTrue(java.util.Set.of("FECHAS_POR_CONFIRMAR", "EN_REVISION").contains(data.get("estadoPostulacion")));
            assertNull(data.get("fechaCierrePostulacion"));
            var response = post("/api/becas/catalogo/buscar", null, Map.of("page", 0, "size", 100), Map.class);
            assertEquals(200, response.getStatusCode().value());
            assertTrue(response.getBody().toString().contains(approved.toString()));
            assertEquals(404, get("/api/becas/" + approved, null, Map.class).getStatusCode().value());
            assertEquals(404, get("/api/becas/catalogo/00000000-0000-0000-0000-000000000001", null, Map.class).getStatusCode().value());
        } finally {
            jdbc.update("update becas set public_id=?,estado_activa=?,fecha_inicio_postulacion=?,fecha_cierre_postulacion=? where id_beca=1", original.get("public_id"), original.get("estado_activa"), original.get("fecha_inicio_postulacion"), original.get("fecha_cierre_postulacion"));
        }
    }
}
