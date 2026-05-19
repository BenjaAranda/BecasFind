package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.Beca;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BecaRepository extends JpaRepository<Beca, Long>, JpaSpecificationExecutor<Beca> {

    @Query("SELECT DISTINCT b FROM Beca b " +
            "LEFT JOIN FETCH b.institucion i " +
            "LEFT JOIN FETCH b.tipoBeca tb " +
            "WHERE b.estadoActiva = true " +
            "AND b.fechaCierrePostulacion >= CURRENT_DATE")
    Page<Beca> findBecasVigentes(Pageable pageable);

    @Query("SELECT DISTINCT b FROM Beca b " +
            "LEFT JOIN FETCH b.institucion i " +
            "LEFT JOIN FETCH i.tipoInstitucion ti " +
            "LEFT JOIN FETCH b.tipoBeca tb " +
            "LEFT JOIN FETCH b.regiones r " +
            "WHERE b.idBeca = :idBeca")
    java.util.Optional<Beca> findByIdWithDetails(@Param("idBeca") Long idBeca);

    Page<Beca> findByEstadoActivaTrueAndFechaCierrePostulacionAfter(java.time.LocalDate fecha, Pageable pageable);

    java.util.Optional<Beca> findByNombreAndInstitucionIdInstitucion(String nombre, Long idInstitucion);
}
