package com.becasfind.api.tests;

import com.becasfind.api.repositories.UsuarioRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.annotation.DirtiesContext;
import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;
import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class AdminUserProjectionTest extends BaseTest {
    @Autowired private UsuarioRepository users;
    @Autowired private JdbcTemplate jdbc;

    @Test void administrationIncludesInactiveAccountsWithoutChangingAuthenticationQueries() {
        jdbc.update("update usuarios set activo=false where id_usuario=2");
        var rows = users.findAllForAdministration();
        var inactive = rows.stream().filter(row -> row.getIdUsuario().equals(2L)).findFirst().orElseThrow();
        assertEquals("estudiante@duoc.cl", inactive.getEmail());
        assertEquals("STUDENT", inactive.getRol());
        assertEquals(false, inactive.getActivo());
        assertNotNull(inactive.getNombreCompleto());
        assertNotNull(inactive.getCreadoEn());
        assertTrue(rows.stream().anyMatch(row -> row.getIdUsuario().equals(1L) && row.getActivo()));
        assertEquals(rows.stream().map(UsuarioRepository.AdministrativeUser::getIdUsuario).sorted().toList(),
                rows.stream().map(UsuarioRepository.AdministrativeUser::getIdUsuario).toList());
        assertTrue(users.findByEmailAndActivoTrue("estudiante@duoc.cl").isEmpty());
        assertTrue(users.findByEmail("estudiante@duoc.cl").isEmpty());
        assertTrue(users.findById(2L).isEmpty());
        assertEquals(1, jdbc.queryForObject("select count(*) from usuarios where id_usuario=2 and activo=false", Integer.class));
        var adminList = get("/api/usuarios", adminToken(), java.util.Map.class);
        assertEquals(200, adminList.getStatusCode().value());
        var returned = (java.util.List<?>) adminList.getBody().get("data");
        var dto = returned.stream().map(row -> (java.util.Map<?, ?>) row)
                .filter(row -> Integer.valueOf(2).equals(row.get("idUsuario"))).findFirst().orElseThrow();
        assertEquals(false, dto.get("activo"));
        assertEquals("STUDENT", dto.get("rol"));
        assertFalse(dto.containsKey("passwordHash"));
        assertFalse(dto.containsKey("password"));
        assertNotNull(dto.get("creadoEn"));
        assertEquals(Set.of("getIdUsuario", "getEmail", "getNombreCompleto", "getRol", "getActivo", "getCreadoEn"),
                Arrays.stream(UsuarioRepository.AdministrativeUser.class.getDeclaredMethods())
                        .map(java.lang.reflect.Method::getName).collect(Collectors.toSet()));
    }
}
