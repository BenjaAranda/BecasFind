package com.becasfind.api.tests;

import com.becasfind.api.repositories.BecaRepository;
import com.becasfind.api.services.BecaImportService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.test.annotation.DirtiesContext;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.concurrent.*;
import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class ScholarshipConcurrencyTest extends BaseTest {
    @Autowired BecaRepository becas;
    @Autowired BecaImportService importer;
    @Autowired PlatformTransactionManager transactions;
    @Autowired JdbcTemplate jdbc;

    @Test void staleAdminFormReceivesConflictAndPreservesFirstWrite() {
        String token = adminToken();
        var created = post("/api/becas", token, Map.of("nombre", "Conflicto administrativo", "idInstitucion", 1, "idTipoBeca", 1, "fechaCierrePostulacion", "2026-12-31", "estadoActiva", true), Map.class);
        Map<?, ?> data = (Map<?, ?>) created.getBody().get("data");
        long id = ((Number)data.get("idBeca")).longValue();
        var request = new java.util.HashMap<String, Object>();
        request.put("nombre", "Primera escritura conservada"); request.put("idInstitucion", 1); request.put("idTipoBeca", 1); request.put("estadoActiva", true); request.put("fechaCierrePostulacion", "2026-12-31"); request.put("version", data.get("version"));
        assertEquals(200, put("/api/becas/" + id, token, request, Map.class).getStatusCode().value());
        request.put("nombre", "Escritura obsoleta rechazada");
        var conflict = put("/api/becas/" + id, token, request, Map.class);
        assertEquals(409, conflict.getStatusCode().value());
        assertEquals(409, conflict.getBody().get("status"));
        assertEquals("Primera escritura conservada", jdbc.queryForObject("select nombre from becas where id_beca=?", String.class, id));
    }

    @Test void changingOnlyDocumentsAdvancesVersionAndRejectsStaleEditor() {
        String token = adminToken();
        var request = new java.util.HashMap<String,Object>();
        request.put("nombre", "Solo documentos"); request.put("idInstitucion",1); request.put("idTipoBeca",1); request.put("estadoActiva",true);
        Map<?,?> created = (Map<?,?>) post("/api/becas", token, request, Map.class).getBody().get("data");
        long id = ((Number)created.get("idBeca")).longValue();
        request.put("version",created.get("version"));
        request.put("documentosRequeridos", List.of(Map.of("nombreDocumento","Documento confirmado","esObligatorio",true)));
        var updated = put("/api/becas/" + id, token, request, Map.class);
        assertEquals(200, updated.getStatusCode().value());
        Number nextVersion = (Number)((Map<?,?>)updated.getBody().get("data")).get("version");
        assertTrue(nextVersion.longValue() > ((Number)created.get("version")).longValue());
        request.put("documentosRequeridos",List.of());
        assertEquals(409, put("/api/becas/" + id, token, request, Map.class).getStatusCode().value());
        assertEquals(1,jdbc.queryForObject("select count(*) from documentos_requeridos where id_beca=?",Integer.class,id));
    }

    @Test void simultaneousTransactionsCannotSilentlyOverwriteScholarship() throws Exception {
        CyclicBarrier barrier = new CyclicBarrier(2);
        ExecutorService pool = Executors.newFixedThreadPool(2);
        try {
            Callable<Boolean> write = () -> {
                try {
                    new TransactionTemplate(transactions).executeWithoutResult(status -> {
                        var beca = becas.findById(2L).orElseThrow();
                        try { barrier.await(10, TimeUnit.SECONDS); } catch (Exception ex) { throw new RuntimeException(ex); }
                        beca.setDescripcionCorta("Escritura " + Thread.currentThread().getName());
                        becas.flush();
                    });
                    return true;
                } catch (org.springframework.orm.ObjectOptimisticLockingFailureException ex) { return false; }
            };
            Future<Boolean> first = pool.submit(write), second = pool.submit(write);
            assertNotEquals(first.get(20, TimeUnit.SECONDS), second.get(20, TimeUnit.SECONDS));
        } finally { pool.shutdownNow(); }
    }

    @Test void simultaneousImportsReuseCatalogsAndUpsertWithoutDuplicates() throws Exception {
        ExecutorService pool = Executors.newFixedThreadPool(2);
        CyclicBarrier barrier = new CyclicBarrier(2);
        String csv = "nombre,institucion,tipo_beca,monto,fecha_inicio,fecha_cierre,rsh_maximo,nem_minimo,regiones,descripcion,descripcion_larga,url\nBeca simultánea,Universidad Concurrente,Tipo concurrente,Texto,,,,,RM,Educación,Enseñanza,https://example.com/becas\n";
        Callable<com.becasfind.api.models.dtos.ImportResultDTO> work = () -> {
            SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("admin@becasfind.cl", null, List.of()));
            try {
                barrier.await(10, TimeUnit.SECONDS);
                return importer.importarDesdeCsv(new MockMultipartFile("file", "concurrent.csv", "text/csv", csv.getBytes(StandardCharsets.UTF_8)));
            } finally { SecurityContextHolder.clearContext(); }
        };
        try {
            Future<com.becasfind.api.models.dtos.ImportResultDTO> first = pool.submit(work), second = pool.submit(work);
            var a = first.get(20, TimeUnit.SECONDS); var b = second.get(20, TimeUnit.SECONDS);
            assertEquals(0, a.getErrores(), a.getMensajesError().toString()); assertEquals(0, b.getErrores(), b.getMensajesError().toString());
            assertEquals(1, a.getCreadas() + b.getCreadas()); assertEquals(1, a.getActualizadas() + b.getActualizadas());
            assertEquals(1, jdbc.queryForObject("select count(*) from instituciones where nombre='Universidad Concurrente'", Integer.class));
            assertEquals(1, jdbc.queryForObject("select count(*) from tipos_beca where nombre='Tipo concurrente'", Integer.class));
            assertEquals(1, jdbc.queryForObject("select count(*) from becas where nombre='Beca simultánea'", Integer.class));
        } finally { pool.shutdownNow(); }
    }
}
