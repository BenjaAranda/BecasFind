package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.PerfilEstudiante;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PerfilEstudianteRepository extends JpaRepository<PerfilEstudiante, Long> {

    Optional<PerfilEstudiante> findByUsuarioIdUsuario(Long idUsuario);
}
