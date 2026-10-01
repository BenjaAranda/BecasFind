package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.Institucion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface InstitucionRepository extends JpaRepository<Institucion, Long> {
    Optional<Institucion> findByNombreIgnoreCase(String nombre);

    @org.springframework.data.jpa.repository.Query("select i from Institucion i where i.rut not like 'IMP-%' "
            + "or exists (select b.idBeca from Beca b where b.institucion = i and b.estadoActiva = true "
            + "and b.fechaCierrePostulacion is not null)")
    java.util.List<Institucion> findPublicCatalog();
}
