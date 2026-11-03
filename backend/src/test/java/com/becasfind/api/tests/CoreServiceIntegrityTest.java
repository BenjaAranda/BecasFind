package com.becasfind.api.tests;

import com.becasfind.api.models.dtos.BecaRequest;
import com.becasfind.api.models.dtos.PerfilEstudianteRequest;
import com.becasfind.api.services.BecaService;
import com.becasfind.api.services.FavoritoService;
import com.becasfind.api.services.PerfilService;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.annotation.DirtiesContext;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.concurrent.*;

import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class CoreServiceIntegrityTest extends BaseTest {
    private static final String EMAIL = "estudiante@duoc.cl";
    @Autowired private BecaService becas;
    @Autowired private FavoritoService favoritos;
    @Autowired private PerfilService perfiles;
    @Autowired private JdbcTemplate jdbc;

    private BecaRequest request() {
        BecaRequest request = new BecaRequest();
        request.setNombre("Beca de integridad");
        request.setIdInstitucion(1L);
        request.setIdTipoBeca(1L);
        request.setFechaCierrePostulacion(LocalDate.of(2027, 12, 31));
        return request;
    }

    @Test void unknownRegionsRejectCreationAndRollBackUpdates() {
        BecaRequest request = request();
        request.setRegionesIds(List.of(1L, 999999L));
        Long count = jdbc.queryForObject("select count(*) from becas", Long.class);
        assertThrows(EntityNotFoundException.class, () -> becas.create(1L, request));
        assertEquals(count, jdbc.queryForObject("select count(*) from becas", Long.class));
        String name = becas.findById(1L).getNombre();
        assertThrows(EntityNotFoundException.class, () -> becas.update(1L, request));
        assertEquals(name, becas.findById(1L).getNombre());
    }

    @Test void missingScholarshipCannotBecomeFavorite() {
        assertThrows(EntityNotFoundException.class, () -> favoritos.guardar(EMAIL, 999999L));
        assertFalse(favoritos.isFavorito(EMAIL, 999999L));
    }

    @Test void simultaneousFavoriteSavesAndDeletesAreIdempotent() throws Exception {
        favoritos.eliminar(EMAIL, 1L);
        simultaneously(() -> favoritos.guardar(EMAIL, 1L));
        assertEquals(1, jdbc.queryForObject(
                "select count(*) from becas_favoritas where id_usuario=2 and id_beca=1", Integer.class));
        simultaneously(() -> favoritos.eliminar(EMAIL, 1L));
        assertFalse(favoritos.isFavorito(EMAIL, 1L));
    }

    @Test void simultaneousInitialProfileSavesCreateOneRow() throws Exception {
        jdbc.update("delete from perfiles_estudiante where id_usuario=2");
        PerfilEstudianteRequest request = PerfilEstudianteRequest.builder()
                .rshPorcentaje(60).nemPromedio(new BigDecimal("5.5")).build();
        simultaneously(() -> perfiles.savePerfil(EMAIL, request));
        assertEquals(1, jdbc.queryForObject(
                "select count(*) from perfiles_estudiante where id_usuario=2", Integer.class));
        assertEquals(60, perfiles.getPerfil(EMAIL).getRshPorcentaje());
    }

    @Test void updatingScholarshipWithoutRequirementsCreatesThem() {
        Long id = becas.create(1L, request()).getIdBeca();
        jdbc.update("delete from requisitos_perfil where id_beca=?", id);
        BecaRequest request = request();
        request.setRshMaximoPorcentaje(60);
        request.setNemMinimo(new BigDecimal("5.5"));
        becas.update(id, request);
        assertEquals(60, becas.findById(id).getRequisitoPerfil().getRshMaximoPorcentaje());
        becas.delete(id);
    }

    @Test void deletingScholarshipRemovesDependentFavoritesAndRequirements() {
        BecaRequest request = request();
        request.setRegionesIds(List.of(1L));
        Long id = becas.create(1L, request).getIdBeca();
        favoritos.guardar(EMAIL, id);
        becas.delete(id);
        assertFalse(favoritos.isFavorito(EMAIL, id));
        for (String table : List.of("becas_regiones", "requisitos_perfil", "documentos_requeridos")) {
            assertEquals(0, jdbc.queryForObject("select count(*) from " + table + " where id_beca=?", Integer.class, id));
        }
        assertThrows(EntityNotFoundException.class, () -> becas.findById(id));
    }

    private void simultaneously(Runnable action) throws Exception {
        ExecutorService workers = Executors.newFixedThreadPool(2);
        CountDownLatch ready = new CountDownLatch(2);
        CountDownLatch start = new CountDownLatch(1);
        Callable<Void> task = () -> {
            ready.countDown();
            assertTrue(start.await(5, TimeUnit.SECONDS));
            action.run();
            return null;
        };
        try {
            Future<Void> first = workers.submit(task);
            Future<Void> second = workers.submit(task);
            assertTrue(ready.await(5, TimeUnit.SECONDS));
            start.countDown();
            first.get(15, TimeUnit.SECONDS);
            second.get(15, TimeUnit.SECONDS);
        } finally {
            start.countDown();
            workers.shutdownNow();
            assertTrue(workers.awaitTermination(5, TimeUnit.SECONDS));
        }
    }
}
