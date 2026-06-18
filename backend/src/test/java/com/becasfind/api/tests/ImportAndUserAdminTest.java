package com.becasfind.api.tests;

import org.junit.jupiter.api.*;
import org.springframework.core.io.*;
import org.springframework.http.*;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.util.LinkedMultiValueMap;
import java.util.*;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("CP-49 a CP-56: Import CSV y Admin Usuarios")
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class ImportAndUserAdminTest extends BaseTest {

    private String admin;

    @BeforeEach void setup() { admin = adminToken(); }

    @Test @DisplayName("CP-49: Importar CSV valido")
    void importValidCsv() {
        String csv = "nombre,institucion,tipo_beca,monto,fecha_inicio,fecha_cierre,rsh_maximo,nem_minimo,regiones,descripcion,descripcion_larga,url\n"
                + "Beca Test Import,DUOC UC,Beca de Arancel,100000,2026-01-01,2026-12-31,60,5.0,RM,Desc corta,Desc larga,https://test.cl";
        LinkedMultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", new ByteArrayResource(csv.getBytes()) {
            @Override public String getFilename() { return "test.csv"; }
        });
        HttpHeaders h = new HttpHeaders();
        h.setContentType(MediaType.MULTIPART_FORM_DATA);
        h.setBearerAuth(adminToken());
        var res = rest.postForEntity(url("/api/becas/importar-csv"), new HttpEntity<>(body, h), Map.class);
        assertEquals(200, res.getStatusCodeValue());
        var data = (Map)res.getBody().get("data");
        assertTrue((int)data.get("creadas") >= 1);
        assertEquals(0, (int)data.get("errores"));
    }

    @Test @DisplayName("CP-50: Importar CSV con errores de formato")
    void importCsvWithErrors() {
        String csv = "nombre,institucion,tipo_beca,monto,fecha_inicio,fecha_cierre,rsh_maximo,nem_minimo,regiones,descripcion,descripcion_larga,url\n"
                + "Beca Error,DUOC UC,Beca de Arancel,XYZ,2026-01-01,not-a-date,abc,5.0,RM,Desc,Desc larga,https://test.cl";
        LinkedMultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", new ByteArrayResource(csv.getBytes()) {
            @Override public String getFilename() { return "test.csv"; }
        });
        HttpHeaders h = new HttpHeaders();
        h.setContentType(MediaType.MULTIPART_FORM_DATA);
        h.setBearerAuth(adminToken());
        var res = rest.postForEntity(url("/api/becas/importar-csv"), new HttpEntity<>(body, h), Map.class);
        assertEquals(200, res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-51: Importar CSV vacio")
    void importEmptyCsv() {
        LinkedMultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", new ByteArrayResource(new byte[0]) {
            @Override public String getFilename() { return "empty.csv"; }
        });
        HttpHeaders h = new HttpHeaders();
        h.setContentType(MediaType.MULTIPART_FORM_DATA);
        h.setBearerAuth(adminToken());
        var res = rest.postForEntity(url("/api/becas/importar-csv"), new HttpEntity<>(body, h), Map.class);
        assertTrue(res.getStatusCodeValue() == 200 || res.getStatusCodeValue() == 403,
            "Import CSV should succeed or return auth error: " + res.getStatusCodeValue());
    }

    @Test @DisplayName("CP-52: Listar usuarios (admin)")
    void listUsers() {
        var res = get("/api/usuarios", admin, Map.class);
        assertEquals(200, res.getStatusCodeValue());
        var data = (List)res.getBody().get("data");
        assertTrue(data.size() >= 2);
    }

    @Test @DisplayName("CP-53: Crear usuario (admin)")
    void createUser() {
        var token = adminToken(); assertNotNull(token);
        var res = post("/api/usuarios", token, Map.of("email","test.crear@test.cl","password","password123","nombreCompleto","Test Create","idRol",2), Map.class);
        assertTrue(res.getStatusCodeValue() == 200 || res.getStatusCodeValue() == 201);
    }

    @Test @DisplayName("CP-54: Crear usuario email duplicado")
    void createDuplicateUser() {
        var token = adminToken(); assertNotNull(token);
        var res = post("/api/usuarios", token, Map.of("email","admin@becasfind.cl","password","password123","nombreCompleto","X","idRol",2), Map.class);
        assertTrue(res.getStatusCodeValue() >= 400);
    }

    @Test @DisplayName("CP-55: Editar usuario")
    void editUser() {
        var token = adminToken(); assertNotNull(token);
        var res = put("/api/usuarios/1", token, Map.of("email","admin.edit@becasfind.cl","nombreCompleto","Admin Editado"), Map.class);
        assertTrue(res.getStatusCodeValue() == 200 || res.getStatusCodeValue() == 204);
    }

    @Test @DisplayName("CP-56: Desactivar usuario (soft delete)")
    void deactivateUser() {
        var res = delete("/api/usuarios/2", adminToken());
        assertTrue(res.getStatusCodeValue() == 200 || res.getStatusCodeValue() == 204);
    }
}
