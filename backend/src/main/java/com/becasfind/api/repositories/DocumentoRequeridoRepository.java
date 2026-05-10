package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.DocumentoRequerido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DocumentoRequeridoRepository extends JpaRepository<DocumentoRequerido, Long> {

    List<DocumentoRequerido> findByBecaIdBeca(Long idBeca);

    void deleteByBecaIdBeca(Long idBeca);
}
