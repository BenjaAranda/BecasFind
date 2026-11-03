package com.becasfind.api.tests;

import com.becasfind.api.models.dtos.BecaDTO;
import com.becasfind.api.models.entities.Beca;
import com.becasfind.api.models.entities.PerfilEstudiante;
import com.becasfind.api.models.entities.RequisitoPerfil;
import com.becasfind.api.repositories.BecaRepository;
import com.becasfind.api.repositories.InstitucionRepository;
import com.becasfind.api.repositories.PerfilEstudianteRepository;
import com.becasfind.api.repositories.RegionRepository;
import com.becasfind.api.repositories.TipoBecaRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.services.BecaService;
import com.becasfind.api.services.BecaSpecifications;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.Clock;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

@Transactional
class BecaCoreRulesTest extends BaseTest {
    @Autowired BecaService service;
    @Autowired BecaRepository becas;
    @Autowired InstitucionRepository institutions;
    @Autowired UsuarioRepository users;
    @Autowired TipoBecaRepository types;
    @Autowired RegionRepository regions;
    @Autowired PerfilEstudianteRepository profiles;
    @Autowired JdbcTemplate jdbc;
    private final LocalDate today = LocalDate.now(ZoneId.of("America/Santiago"));

    @BeforeEach
    void isolateFixtures() {
        jdbc.update("UPDATE becas SET estado_activa = false");
        jdbc.update("DELETE FROM perfiles_estudiante");
    }

    private Beca create(String name, LocalDate close, boolean active, Integer rsh, String nem, long institution, Long... regionIds) {
        Beca beca = new Beca();
        beca.setNombre(name);
        beca.setDescripcionCorta("Descripción de prueba");
        beca.setFechaCierrePostulacion(close);
        beca.setEstadoActiva(active);
        beca.setInstitucion(institutions.findById(institution).orElseThrow());
        beca.setTipoBeca(types.findById(1L).orElseThrow());
        beca.setUsuarioCreador(users.findByEmail("admin@becasfind.cl").orElseThrow());
        beca.setRegiones(Arrays.stream(regionIds).map(id -> regions.findById(id).orElseThrow()).collect(Collectors.toSet()));
        RequisitoPerfil requirement = new RequisitoPerfil();
        requirement.setBeca(beca);
        requirement.setRshMaximoPorcentaje(rsh);
        requirement.setNemMinimo(nem == null ? null : new BigDecimal(nem));
        beca.setRequisitoPerfil(requirement);
        return becas.saveAndFlush(beca);
    }

    private Page<BecaDTO> search(Integer rsh, Double nem, Long region, String text, String sort, int page, int size) {
        return service.buscarBecas(rsh, nem, region, text, null, null, null, sort, PageRequest.of(page, size));
    }

    private Set<String> names(Page<BecaDTO> page) {
        return page.stream().map(BecaDTO::getNombre).collect(Collectors.toSet());
    }

    @Test
    void closingDayIsInclusiveAndExpiredInactiveAreExcluded() {
        create("Ayer", today.minusDays(1), true, 60, "5.0", 1);
        create("Hoy", today, true, 60, "5.0", 1);
        create("Mañana", today.plusDays(1), true, 60, "5.0", 1);
        create("Inactiva", today.plusDays(2), false, 60, "5.0", 1);
        assertEquals(List.of("Hoy", "Mañana"), search(null, null, null, null, null, 0, 100)
                .stream().map(BecaDTO::getNombre).toList());
    }

    @Test
    void rshUpperAndNemLowerLimitsAreInclusiveAndUnknownDoesNotAssertMatch() {
        create("Coincide", today, true, 60, "5.5", 1);
        create("Flexible", today, true, 100, "4.0", 1);
        create("RSH insuficiente", today, true, 40, "5.0", 1);
        create("NEM insuficiente", today, true, 80, "6.0", 1);
        create("RSH desconocido", today, true, null, "5.0", 1);
        create("NEM desconocido", today, true, 80, null, 1);
        assertEquals(Set.of("Coincide", "Flexible"), names(search(60, 5.5, null, null, null, 0, 100)));
        assertEquals(6, search(null, null, null, null, null, 0, 100).getTotalElements());
    }

    @Test
    void regionIncludesNationalAndMultipleRegionsWithoutDuplicatingResults() {
        create("Nacional", today, true, 60, "5.0", 1);
        create("Dos regiones", today, true, 60, "5.0", 1, 1L, 2L);
        create("Otra región", today, true, 60, "5.0", 1, 3L);
        var result = search(null, null, 2L, null, null, 0, 100);
        assertEquals(2, result.getTotalElements());
        assertEquals(Set.of("Nacional", "Dos regiones"), names(result));
        assertTrue(result.stream().filter(b -> b.getNombre().equals("Dos regiones")).findFirst().orElseThrow()
                .getNombreRegion().contains(", "));
    }

    @Test
    void textMatchesNameDescriptionAndTreatsWildcardCharactersLiterally() {
        create("Cobertura 100%_!", today, true, 60, "5.0", 1);
        Beca description = create("Nombre distinto", today, true, 60, "5.0", 1);
        description.setDescripcionCorta("Beneficio especial 100%_!");
        becas.saveAndFlush(description);
        create("No corresponde", today, true, 60, "5.0", 1);
        assertEquals(Set.of("Cobertura 100%_!", "Nombre distinto"), names(search(null, null, null, " 100%_! ", null, 0, 100)));
        assertEquals(Set.of("Nombre distinto"), names(search(null, null, null, "BENEFICIO ESPECIAL", null, 0, 100)));
    }

    @Test
    void recommendationsReuseSearchWithoutInstitutionTypeIds() {
        create("Otra institución compatible", today, true, 80, "5.0", 2, 1L);
        create("Nacional compatible", today, true, 60, "5.5", 3);
        create("Fuera de región", today, true, 80, "5.0", 1, 2L);
        create("NEM no compatible", today, true, 80, "6.0", 1);
        var profile = new PerfilEstudiante();
        profile.setUsuario(users.findByEmail("estudiante@duoc.cl").orElseThrow());
        profile.setRshPorcentaje(60);
        profile.setNemPromedio(new BigDecimal("5.5"));
        profile.setRegion(regions.findById(1L).orElseThrow());
        profile.setInstitucion(institutions.findById(1L).orElseThrow());
        profiles.saveAndFlush(profile);
        var recommended = service.recomendarBecas("estudiante@duoc.cl", PageRequest.of(0, 100));
        assertEquals(Set.of("Otra institución compatible", "Nacional compatible"), names(recommended));
        assertEquals(names(search(60, 5.5, 1L, null, "fechaAsc", 0, 100)), names(recommended));
    }

    @Test
    void identicalDatesHaveStablePagesAndDescendingDatesStillWork() {
        Beca first = create("Primera", today, true, 60, "5.0", 1);
        Beca second = create("Segunda", today, true, 60, "5.0", 1);
        Beca later = create("Posterior", today.plusDays(1), true, 60, "5.0", 1);
        assertEquals(first.getIdBeca(), search(null, null, null, null, "fechaAsc", 0, 1).getContent().get(0).getIdBeca());
        assertEquals(second.getIdBeca(), search(null, null, null, null, "fechaAsc", 1, 1).getContent().get(0).getIdBeca());
        assertEquals(later.getIdBeca(), search(null, null, null, null, "fechaDesc", 0, 1).getContent().get(0).getIdBeca());
    }

    @Test
    void chileDateDoesNotExpireScholarshipWhenUtcHasEnteredTomorrow() {
        create("Cierre Chile", LocalDate.of(2030, 1, 1), true, 60, "5.0", 1);
        Instant instant = Instant.parse("2030-01-02T01:00:00Z");
        Clock chile = Clock.fixed(instant, ZoneId.of("America/Santiago"));
        assertEquals(1, becas.count(BecaSpecifications.isVigente(chile)));
        assertEquals(0, becas.count(BecaSpecifications.isVigente(Clock.fixed(instant, ZoneOffset.UTC))));
    }

    @Test
    void invalidFiltersAndOversizedPagesAreRejectedBeforeQuery() {
        assertThrows(IllegalArgumentException.class, () -> search(101, null, null, null, null, 0, 10));
        assertThrows(IllegalArgumentException.class, () -> search(-1, null, null, null, null, 0, 10));
        for (double value : new double[]{0.9, 7.1, Double.NaN, Double.POSITIVE_INFINITY}) {
            assertThrows(IllegalArgumentException.class, () -> search(null, value, null, null, null, 0, 10));
        }
        assertThrows(IllegalArgumentException.class, () -> search(null, null, 0L, null, null, 0, 10));
        assertThrows(IllegalArgumentException.class, () -> search(null, null, null, "x".repeat(201), null, 0, 10));
        assertThrows(IllegalArgumentException.class, () -> search(null, null, null, null, "desconocido", 0, 10));
        assertThrows(IllegalArgumentException.class, () -> search(null, null, null, null, null, 0, 101));
        assertThrows(IllegalArgumentException.class, () -> service.recomendarBecas("estudiante@duoc.cl", PageRequest.of(0, 101)));
    }
}
