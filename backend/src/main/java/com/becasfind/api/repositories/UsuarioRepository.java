package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.List;
import java.time.LocalDateTime;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    Optional<Usuario> findByEmailAndActivoTrue(String email);

    boolean existsByEmail(String email);

    Optional<Usuario> findByEmail(String email);

    // Administrative projection intentionally includes inactive accounts without exposing hashes.
    @Query(value = """
            SELECT u.id_usuario AS "idUsuario", u.email AS "email",
                   u.nombre_completo AS "nombreCompleto", r.nombre_rol AS "rol",
                   u.activo AS "activo", u.creado_en AS "creadoEn"
            FROM usuarios u JOIN roles r ON r.id_rol = u.id_rol
            ORDER BY u.id_usuario
            """, nativeQuery = true)
    List<AdministrativeUser> findAllForAdministration();

    interface AdministrativeUser {
        Long getIdUsuario();
        String getEmail();
        String getNombreCompleto();
        String getRol();
        Boolean getActivo();
        LocalDateTime getCreadoEn();
    }
}
