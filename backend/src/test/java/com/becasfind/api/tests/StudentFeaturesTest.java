package com.becasfind.api.tests;

import org.junit.jupiter.api.*;
import org.springframework.http.*;
import org.springframework.test.annotation.DirtiesContext;
import java.util.*;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("CP-30 a CP-44: Recomendaciones, Favoritos, Perfil, Catalogos")
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class StudentFeaturesTest extends BaseTest {

    private String token;

    @BeforeEach
    void setup() {
        token = studentToken();
        assertNotNull(token, "Student login must work");
    }

    @Test @DisplayName("CP-32: Agregar beca a favoritos")
    void addFavorito() {
        var token = studentToken();
        assertNotNull(token, "Student login failed");
        var res = post("/api/favoritos/1", token, null, Map.class);
        assertTrue(res.getStatusCodeValue() == 200 || res.getStatusCodeValue() == 201);
    }

    @Test @DisplayName("CP-33: Eliminar beca de favoritos")
    void removeFavorito() {
        var token = studentToken();
        assertNotNull(token);
        post("/api/favoritos/1", token, null, Map.class);
        var res = delete("/api/favoritos/1", token);
        assertTrue(res.getStatusCodeValue() == 200 || res.getStatusCodeValue() == 204);
    }

    @Test @DisplayName("CP-34: Verificar estado de favorito")
    void checkFavorito() {
        var token = studentToken(); assertNotNull(token);
        post("/api/favoritos/2", token, null, Map.class);
        var res = get("/api/favoritos/2/check", token, Map.class);
        assertEquals(200, res.getStatusCodeValue());
        var data = (Map)res.getBody().get("data");
        assertNotNull(data);
    }

    @Test @DisplayName("CP-35: Listar favoritos")
    void listFavoritos() {
        var token = studentToken(); assertNotNull(token);
        post("/api/favoritos/1", token, null, Map.class);
        var res = get("/api/favoritos", token, Map.class);
        assertEquals(200, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-36: Crear perfil estudiante")
    void createProfile() {
        var token = studentToken(); assertNotNull(token);
        var res = put("/api/perfil", token, Map.of("rshPorcentaje",70,"nemPromedio",6.0,"idRegion",1,"idInstitucion",2,"carreraInteres","Derecho"), Map.class);
        assertEquals(200, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-37: Actualizar perfil")
    void updateProfile() {
        var token = studentToken(); assertNotNull(token);
        put("/api/perfil", token, Map.of("rshPorcentaje",50,"nemPromedio",4.5), Map.class);
        var res = get("/api/perfil", token, Map.class);
        assertEquals(200, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-38: Ver perfil precargado")
    void getProfilePopulated() {
        var token = studentToken(); assertNotNull(token);
        put("/api/perfil", token, Map.of("rshPorcentaje",80,"nemPromedio",5.0,"idRegion",1,"idInstitucion",1,"carreraInteres","Ing"), Map.class);
        var res = get("/api/perfil", token, Map.class);
        assertEquals(200, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-39: Ver perfil sin configurar")
    void getProfileEmpty() {
        var freshToken = login("estudiante@duoc.cl", "admin123");
        assertNotNull(freshToken, "Student login must work");
        var res = get("/api/perfil", freshToken, Map.class);
        assertTrue(res.getStatusCodeValue() == 200 || res.getStatusCodeValue() == 404);
    }

    @Test @DisplayName("CP-30: Recomendaciones con perfil")
    void recomendacionesWithProfile() {
        var token = studentToken(); assertNotNull(token);
        put("/api/perfil", token, Map.of("rshPorcentaje",60,"nemPromedio",5.5,"idRegion",1,"idInstitucion",1,"carreraInteres","Informatica","esPrimerAnio",true), Map.class);
        var res = get("/api/becas/recomendadas", token, Map.class);
        assertEquals(200, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-31: Recomendaciones sin perfil")
    void recomendacionesWithoutProfile() {
        var token = studentToken(); assertNotNull(token);
        var res = get("/api/becas/recomendadas", token, Map.class);
        assertTrue(res.getStatusCodeValue() == 200);
    }

    @Test @DisplayName("CP-40: Catalogo regiones")
    void catalogoRegiones() { var d = (List)get("/api/regiones",null,Map.class).getBody().get("data"); assertTrue(d.size()>=4); }

    @Test @DisplayName("CP-41: Catalogo comunas")
    void catalogoComunas() { assertEquals(200, get("/api/comunas/region/1",null,Map.class).getStatusCodeValue()); }

    @Test @DisplayName("CP-42: Catalogo tipos beca")
    void catalogoTiposBeca() { var d = (List)get("/api/tipos-beca",null,Map.class).getBody().get("data"); assertTrue(d.size()>=8); }

    @Test @DisplayName("CP-43: Catalogo tipos institucion")
    void catalogoTiposInstitucion() { var res = get("/api/tipos-institucion", adminToken(), Map.class); assertTrue(res.getStatusCodeValue() == 200 || res.getStatusCodeValue() == 403); }

    @Test @DisplayName("CP-44: Catalogo instituciones")
    void catalogoInstituciones() { var d = (List)get("/api/instituciones",null,Map.class).getBody().get("data"); assertTrue(d.size()>=3); }
}
