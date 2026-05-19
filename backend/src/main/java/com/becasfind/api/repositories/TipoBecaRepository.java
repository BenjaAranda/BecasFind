package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.TipoBeca;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TipoBecaRepository extends JpaRepository<TipoBeca, Long> {
    Optional<TipoBeca> findByNombreIgnoreCase(String nombre);
}
