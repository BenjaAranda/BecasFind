package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    Optional<Usuario> findByEmailAndActivoTrue(String email);

    boolean existsByEmail(String email);

    Optional<Usuario> findByEmail(String email);
}
