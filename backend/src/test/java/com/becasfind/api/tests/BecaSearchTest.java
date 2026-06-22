package com.becasfind.api.tests;

import org.junit.jupiter.api.*;
import org.springframework.http.*;
import org.springframework.test.annotation.DirtiesContext;
import java.util.*;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("CP-17 a CP-27: Buscador de Becas")
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class BecaSearchTest extends BaseTest {

    private String userToken;
    private Long regionRM;

    @BeforeEach
    void setup() {
        userToken = studentToken();
        var regions = get("/api/regiones", null, Map.class).getBody();
        for (var r : (List<Map>)regions.get("data")) {
            if ("Metropolitana de Santiago".equals(r.get("nombre"))) regionRM = ((Number)r.get("idRegion")).longValue();
        }
    }

    @Test @DisplayName("CP-17: Listado general sin filtros")
    void searchAllActive() {
        var res = post("/api/becas/buscar", userToken, Map.of(), Map.class);
        assertEquals(200, res.getStatusCodeValue());
        var data = (Map)res.getBody().get("data");
        var content = (List)data.get("content");
        assertTrue(content.size() > 0);
        assertTrue((int)data.get("totalElements") > 0);
    }

    @Test @DisplayName("CP-18: Busqueda por texto libre")
    void searchByText() {
        var res = post("/api/becas/buscar", userToken, Map.of("query","Beca Nuevo"), Map.class);
        var data = (Map)res.getBody().get("data");
        assertNotNull(data.get("totalElements"));
    }

    @Test @DisplayName("CP-19: Filtro RSH - limite superior")
    void searchByRsh() {
        var res = post("/api/becas/buscar", userToken, Map.of("rsh",60), Map.class);
        var data = (Map)res.getBody().get("data");
        assertTrue((int)data.get("totalElements") > 0);
    }

    @Test @DisplayName("CP-20: Filtro NEM - limite inferior")
    void searchByNem() {
        var res = post("/api/becas/buscar", userToken, Map.of("nem",5.0), Map.class);
        var data = (Map)res.getBody().get("data");
        assertTrue((int)data.get("totalElements") > 0);
    }

    @Test @DisplayName("CP-21: Filtro Region (coincidencia o nacional)")
    void searchByRegion() {
        var res = post("/api/becas/buscar", userToken, Map.of("regionId",regionRM), Map.class);
        var data = (Map)res.getBody().get("data");
        assertTrue((int)data.get("totalElements") > 0);
    }

    @Test @DisplayName("CP-22: Filtro Tipo de Beca")
    void searchByTipoBeca() {
        var res = post("/api/becas/buscar", userToken, Map.of("idTipoBeca",1L), Map.class);
        assertEquals(200, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-23: Filtro Institucion")
    void searchByInstitucion() {
        var res = post("/api/becas/buscar", userToken, Map.of("idInstitucion",1L), Map.class);
        assertEquals(200, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-24: Filtro Tipo Institucion")
    void searchByTipoInstitucion() {
        var res = post("/api/becas/buscar", userToken, Map.of("idTipoInstitucion",1L), Map.class);
        assertEquals(200, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-25: Multiples filtros combinados")
    void searchMultipleFilters() {
        var res = post("/api/becas/buscar", userToken, Map.of("rsh",80,"query","Beca"), Map.class);
        var data = (Map)res.getBody().get("data");
        assertNotNull(data.get("content"));
    }

    @Test @DisplayName("CP-26: Ordenamiento dinamico")
    void searchWithSort() {
        var asc = post("/api/becas/buscar", userToken, Map.of("sort","fechaAsc"), Map.class);
        var desc = post("/api/becas/buscar", userToken, Map.of("sort","montoDesc"), Map.class);
        assertEquals(200, asc.getStatusCodeValue());
        assertEquals(200, desc.getStatusCodeValue());
    }

    @Test @DisplayName("CP-27: Paginacion de resultados")
    void searchPagination() {
        var page0 = post("/api/becas/buscar", userToken, Map.of("page",0,"size",2), Map.class);
        var data0 = (Map)page0.getBody().get("data");
        assertEquals(0, data0.get("number"));
        assertEquals(2, ((List)data0.get("content")).size());
        var page1 = post("/api/becas/buscar", userToken, Map.of("page",1,"size",2), Map.class);
        assertEquals(200, page1.getStatusCodeValue());
    }
}
