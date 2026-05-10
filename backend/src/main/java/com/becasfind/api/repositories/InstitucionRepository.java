package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.Institucion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InstitucionRepository extends JpaRepository<Institucion, Long> {
}
