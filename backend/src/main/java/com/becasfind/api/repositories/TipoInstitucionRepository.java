package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.TipoInstitucion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TipoInstitucionRepository extends JpaRepository<TipoInstitucion, Long> {
    Optional<TipoInstitucion> findByNombreIgnoreCase(String nombre);
}
