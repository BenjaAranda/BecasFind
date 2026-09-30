package com.becasfind.api.tests;

import com.becasfind.api.repositories.BecaRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.util.LinkedMultiValueMap;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.HexFormat;

import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class CsvImportIntegrityTest extends BaseTest {
    private static final String HEADER = "nombre,institucion,tipo_beca,monto,fecha_inicio,fecha_cierre,rsh_maximo,nem_minimo,regiones,descripcion,descripcion_larga,url";
    @Autowired private JdbcTemplate jdbc;
    @Autowired private BecaRepository becas;

    private String row(String name) {
        return name + ",DUOC UC,Beca de Arancel,100000,2026-01-01,2026-12-31,60,5.0,RM,Educación,Enseñanza,https://example.com/becas";
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> upload(String csv) {
        return upload(csv.getBytes(StandardCharsets.UTF_8), adminToken());
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> upload(byte[] bytes, String token) {
        var body = new LinkedMultiValueMap<String, Object>();
        body.add("file", new ByteArrayResource(bytes) {
            @Override public String getFilename() { return "integrity.csv"; }
        });
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        headers.setBearerAuth(token);
        var response = rest.postForEntity(url("/api/becas/importar-csv"), new HttpEntity<>(body, headers), Map.class);
        assertEquals(200, response.getStatusCode().value());
        if (Boolean.TRUE.equals(jdbc.execute((ConnectionCallback<Boolean>) connection ->
                connection.getMetaData().getDatabaseProductName().equals("PostgreSQL")))) {
            assertEquals(0, jdbc.queryForObject("select count(*) from becas where encode(convert_to("
                    + "nombre || coalesce(descripcion_corta, '') || coalesce(descripcion_larga, ''), 'UTF8'), 'hex') ~ 'c383c2|c383e2|c382c2'", Integer.class));
            assertEquals(0, jdbc.queryForObject("select count(*) from instituciones where encode(convert_to(nombre, 'UTF8'), 'hex') ~ 'c383c2|c383e2|c382c2'", Integer.class));
        }
        return (Map<String, Object>) response.getBody().get("data");
    }

    private void rejected(Map<String, Object> result, long before) {
        assertEquals(0, result.get("creadas"));
        assertEquals(0, result.get("actualizadas"));
        assertTrue(((Number) result.get("errores")).intValue() > 0);
        assertEquals(before, becas.count());
    }

    @Test void parserErrorsNeverSilentlyImportOtherRows() {
        long before = becas.count();
        rejected(upload(HEADER + "\n" + row("CSV válida no persistida") + "\n" + row("")), before);
        assertEquals(0, jdbc.queryForObject("select count(*) from becas where nombre = ?", Integer.class, "CSV válida no persistida"));
        rejected(upload(HEADER + "\n" + row("CSV columna extra") + ",extra"), before);
        rejected(upload(HEADER + "\n\"comilla sin cierre"), before);
    }

    @Test void malformedValuesAndDatesRejectTheEntireFile() {
        long before = becas.count();
        for (String invalid : new String[] {
                row("CSV número inválido").replace(",60,5.0,", ",abc,5.0,"),
                row("CSV rango inválido").replace(",60,5.0,", ",101,5.0,"),
                row("CSV NEM inválido").replace(",60,5.0,", ",60,7.1,"),
                row("CSV precisión inválida").replace(",60,5.0,", ",60,5.25,"),
                row("CSV fecha inválida").replace("2026-12-31", "2026-02-30"),
                row("CSV fechas invertidas").replace("2026-01-01", "2027-01-01"),
                row("CSV URL raíz").replace("https://example.com/becas", "https://example.com/"),
                row("CSV nombre largo " + "a".repeat(255)) }) {
            rejected(upload(HEADER + "\n" + row("CSV otra válida") + "\n" + invalid), before);
        }
    }

    @Test void unknownRegionRollsBackScholarshipsAndNewCatalogRecords() {
        long before = becas.count();
        int institutions = jdbc.queryForObject("select count(*) from instituciones", Integer.class);
        int types = jdbc.queryForObject("select count(*) from tipos_beca", Integer.class);
        String invalid = row("CSV región desconocida").replace("DUOC UC", "Universidad CSV nueva")
                .replace("Beca de Arancel", "Tipo CSV nuevo").replace(",RM,", ",NO_EXISTE,");
        var result = upload(HEADER + "\n" + row("CSV debe revertir") + "\n" + invalid);
        rejected(result, before);
        assertTrue(result.get("mensajesError").toString().contains("región no encontrada"));
        assertEquals(institutions, jdbc.queryForObject("select count(*) from instituciones", Integer.class));
        assertEquals(types, jdbc.queryForObject("select count(*) from tipos_beca", Integer.class));
    }

    @Test void upsertReplacesTypeAndClearsRegionsAndDocumentsExplicitly() {
        String name = "CSV actualización Ñuble";
        String header = HEADER + ",documentos_requeridos";
        var created = upload(header + "\n" + row(name) + ",[OBLIGATORIO] Matrícula");
        assertEquals(1, created.get("creadas"));
        long id = jdbc.queryForObject("select id_beca from becas where nombre = ?", Long.class, name);
        jdbc.update("update becas set estado_activa = false where id_beca = ?", id);
        var updated = upload(header + "\n" + row(name).replace("Beca de Arancel", "Beca de Alimentacion")
                .replace(",RM,", ",,").replace(",60,5.0,", ",0,4.0,") + ",");
        assertEquals(1, updated.get("actualizadas"));
        assertEquals(0, updated.get("errores"));
        assertEquals(false, jdbc.queryForObject("select estado_activa from becas where id_beca = ?", Boolean.class, id));
        assertEquals(0, jdbc.queryForObject("select count(*) from becas_regiones where id_beca = ?", Integer.class, id));
        assertEquals(0, jdbc.queryForObject("select count(*) from documentos_requeridos where id_beca = ?", Integer.class, id));
        assertEquals("Beca de Alimentacion", jdbc.queryForObject("select tb.nombre from becas b join tipos_beca tb on b.id_tipo_beca = tb.id_tipo_beca where b.id_beca = ?", String.class, id));
        assertEquals(0, jdbc.queryForObject("select rsh_maximo_porcentaje from requisitos_perfil where id_beca = ?", Integer.class, id));
        assertEquals(1, upload(header + "\n" + row(name) + ",").get("actualizadas"));
        assertEquals(1, jdbc.queryForObject("select count(*) from becas where nombre = ?", Integer.class, name));
    }

    @Test void omittedDocumentColumnPreservesDocumentsAndMissingProfileIsCreated() {
        String name = "CSV documentos conservados";
        assertEquals(1, upload(HEADER + ",documentos_requeridos\n" + row(name) + ",[OPCIONAL] Carta").get("creadas"));
        long id = jdbc.queryForObject("select id_beca from becas where nombre = ?", Long.class, name);
        jdbc.update("delete from requisitos_perfil where id_beca = ?", id);
        assertEquals(1, upload(HEADER + "\n" + row(name)).get("actualizadas"));
        assertEquals(1, jdbc.queryForObject("select count(*) from documentos_requeridos where id_beca = ?", Integer.class, id));
        assertEquals(1, jdbc.queryForObject("select count(*) from requisitos_perfil where id_beca = ?", Integer.class, id));
    }

    @Test void duplicateRowsAndHeadersNeverCommit() {
        long before = becas.count();
        rejected(upload(HEADER + "\n" + row("CSV duplicada") + "\n" + row("CSV duplicada")), before);
        rejected(upload(HEADER + ",nombre\n" + row("CSV encabezado duplicado") + ",otro"), before);
        rejected(upload("beca,institucion,tipo_beca\nNombre,DUOC UC,Beca de Arancel"), before);
        rejected(upload(HEADER.replace("rsh_maximo", "rsh_typo") + "\n" + row("CSV encabezado con error")), before);
    }

    @Test void accentsBomAndWindowsFallbackRemainCorrectAndMojibakeIsRejected() throws Exception {
        assertEquals(1, upload("\uFEFF" + HEADER + "\n" + row("CSV educación Ñuble")).get("creadas"));
        assertEquals("Educación", jdbc.queryForObject("select descripcion_corta from becas where nombre = ?", String.class, "CSV educación Ñuble"));
        byte[] legacy = (HEADER + "\n" + row("CSV Viña del Mar")).getBytes(Charset.forName("windows-1252"));
        assertEquals(1, upload(legacy, adminToken()).get("creadas"));
        assertEquals(1, jdbc.queryForObject("select count(*) from becas where nombre = ?", Integer.class, "CSV Viña del Mar"));
        try (var connection = jdbc.getDataSource().getConnection()) {
            if (connection.getMetaData().getDatabaseProductName().equals("PostgreSQL")) {
                assertEquals(HexFormat.of().formatHex("CSV educación Ñuble".getBytes(StandardCharsets.UTF_8)),
                        jdbc.queryForObject("select encode(convert_to(nombre, 'UTF8'), 'hex') from becas where nombre = ?", String.class, "CSV educación Ñuble"));
                assertEquals(HexFormat.of().formatHex("CSV Viña del Mar".getBytes(StandardCharsets.UTF_8)),
                        jdbc.queryForObject("select encode(convert_to(nombre, 'UTF8'), 'hex') from becas where nombre = ?", String.class, "CSV Viña del Mar"));
            }
        }
        long before = becas.count();
        rejected(upload(HEADER + "\n" + row("CSV EducaciÃ³n")), before);
    }

    @Test void importsLargerThanOneFlushGroupAndRejectsEmptyFile() {
        StringBuilder csv = new StringBuilder(HEADER);
        for (int i = 0; i < 51; i++) csv.append('\n').append(row("CSV grupo " + i));
        assertEquals(51, upload(csv.toString()).get("creadas"));
        long before = becas.count();
        rejected(upload(""), before);
    }

    @Test void suppliedDocumentsRequireMarkersAndNames() {
        long before = becas.count();
        rejected(upload(HEADER + ",documentos_requeridos\n" + row("CSV documento inválido") + ",Sin marcador"), before);
        rejected(upload(HEADER + ",documentos_requeridos\n" + row("CSV documento vacío") + ",[OBLIGATORIO]"), before);
    }

    @Test void databaseFailureRollsBackPriorWritesAndTheNextImportCanSucceed() {
        long before = becas.count();
        jdbc.execute("alter table becas add constraint csv_test_failure check (nombre <> 'CSV fallo en BD')");
        try {
            rejected(upload(HEADER + "\n" + row("CSV anterior revertida") + "\n" + row("CSV fallo en BD")), before);
            assertEquals(0, jdbc.queryForObject("select count(*) from becas where nombre = ?", Integer.class, "CSV anterior revertida"));
        } finally {
            jdbc.execute("alter table becas drop constraint csv_test_failure");
        }
        assertEquals(1, upload(HEADER + "\n" + row("CSV fallo en BD")).get("creadas"));
    }

    @Test void authenticatedAdministratorIsRecordedAsCreator() {
        var created = post("/api/usuarios", adminToken(), Map.of("email", "csv.admin@example.com",
                "password", "secure-pass-123", "nombreCompleto", "Administrador CSV", "idRol", 1), Map.class);
        assertTrue(created.getStatusCode().is2xxSuccessful());
        String token = login("csv.admin@example.com", "secure-pass-123");
        assertNotNull(token);
        assertEquals(1, upload((HEADER + "\n" + row("CSV creador autenticado")).getBytes(StandardCharsets.UTF_8), token).get("creadas"));
        assertEquals("csv.admin@example.com", jdbc.queryForObject("select u.email from becas b join usuarios u on b.id_usuario_creador = u.id_usuario where b.nombre = ?", String.class, "CSV creador autenticado"));
    }

    @Test void oversizedFileReturnsStandardized413WithoutWrites() {
        long before = becas.count();
        var body = new LinkedMultiValueMap<String, Object>();
        body.add("file", new ByteArrayResource(new byte[10 * 1024 * 1024 + 1]) {
            @Override public String getFilename() { return "large.csv"; }
        });
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        headers.setBearerAuth(adminToken());
        var response = rest.postForEntity(url("/api/becas/importar-csv"), new HttpEntity<>(body, headers), Map.class);
        assertEquals(413, response.getStatusCode().value());
        assertEquals(413, response.getBody().get("status"));
        assertEquals(before, becas.count());
    }

    @Test void structuredCoveragePreservesPrecisionAndCanBeClearedWithoutChangingText() {
        String header = HEADER + ",cobertura_tipo,cobertura_importe,cobertura_moneda,cobertura_periodicidad,cobertura_porcentaje";
        String original = row("CSV cobertura precisa");
        assertEquals(0, upload(header + "\n" + original + ",MONETARIA,9999999999999999.99,CLP,ANUAL,").get("errores"));
        assertEquals(new java.math.BigDecimal("9999999999999999.99"), jdbc.queryForObject("select cobertura_importe from becas where nombre = ?", java.math.BigDecimal.class, "CSV cobertura precisa"));
        assertEquals(0, upload(HEADER + "\n" + original).get("errores"));
        assertEquals("MONETARIA", jdbc.queryForObject("select cobertura_tipo from becas where nombre = ?", String.class, "CSV cobertura precisa"));
        assertEquals(0, upload(header + "\n" + original + ",DESCONOCIDA,,,,").get("errores"));
        assertNull(jdbc.queryForObject("select cobertura_importe from becas where nombre = ?", java.math.BigDecimal.class, "CSV cobertura precisa"));
        assertEquals("100000", jdbc.queryForObject("select monto_cobertura from becas where nombre = ?", String.class, "CSV cobertura precisa"));
    }

    @Test void invalidStructuredCoverageRejectsAllRowsBeforePersistence() {
        String header = HEADER + ",cobertura_tipo,cobertura_importe,cobertura_moneda,cobertura_periodicidad,cobertura_porcentaje";
        long before = becas.count();
        for (String invalid : new String[] {"MONETARIA,12.123,CLP,ANUAL,", "MONETARIA,10,,ANUAL,", "PORCENTUAL,10,CLP,,75", "DESCONOCIDA,,,,101", "MONETARIA,10,UF,ANUAL,"}) {
            rejected(upload(header + "\n" + row("CSV cobertura válida") + ",MONETARIA,10,CLP,ANUAL,\n" + row("CSV cobertura inválida") + "," + invalid), before);
        }
        rejected(upload(HEADER + ",cobertura_importe\n" + row("CSV sin tipo") + ",10"), before);
    }

    @Test void missingDatesAndRequirementsStayUnknownAndCannotAppearCurrent() {
        String name = "CSV sin datos confirmados";
        String unknown = row(name).replace("2026-01-01,2026-12-31,60,5.0", ",,,");
        assertEquals(0, upload(HEADER + "\n" + unknown).get("errores"));
        Long id = jdbc.queryForObject("select id_beca from becas where nombre = ?", Long.class, name);
        assertNull(jdbc.queryForObject("select fecha_cierre_postulacion from becas where id_beca = ?", java.sql.Date.class, id));
        assertNull(jdbc.queryForObject("select fecha_inicio_postulacion from becas where id_beca = ?", java.sql.Date.class, id));
        assertNull(jdbc.queryForObject("select rsh_maximo_porcentaje from requisitos_perfil where id_beca = ?", Integer.class, id));
        var response = rest.getForEntity(url("/api/becas?size=100"), String.class);
        assertEquals(200, response.getStatusCode().value());
        assertFalse(response.getBody().contains(name));
    }
}
