package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.RequisitoPerfil;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RequisitoPerfilRepository extends JpaRepository<RequisitoPerfil, Long> {

    Optional<RequisitoPerfil> findByBecaIdBeca(Long idBeca);
}
