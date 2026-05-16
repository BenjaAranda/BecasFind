package com.becasfind.api.services;

import com.becasfind.api.models.entities.Beca;
import org.springframework.data.jpa.domain.Specification;

import jakarta.persistence.criteria.JoinType;
import jakarta.persistence.criteria.SetJoin;
import java.math.BigDecimal;
import java.time.LocalDate;

public final class BecaSpecifications {

    private BecaSpecifications() {
    }

    /**
     * BR-VIGENCIA: Solo becas activas con fecha de cierre no expirada.
     */
    public static Specification<Beca> isVigente() {
        return (root, query, cb) -> cb.and(
                cb.isTrue(root.get("estadoActiva")),
                cb.greaterThanOrEqualTo(root.get("fechaCierrePostulacion"), LocalDate.now())
        );
    }

    /**
     * BR-RSH (LIMITE SUPERIOR): rp.rsh_maximo_porcentaje >= parametroRsh.
     * Estudiante con RSH 60% ve becas de 60%+, no ve becas de 40%.
     */
    public static Specification<Beca> hasRshMax(Integer rsh) {
        if (rsh == null) return null;

        return (root, query, cb) -> {
            var requisitoJoin = root.join("requisitoPerfil", JoinType.LEFT);
            return cb.or(
                    cb.isNull(requisitoJoin.get("rshMaximoPorcentaje")),
                    cb.greaterThanOrEqualTo(requisitoJoin.get("rshMaximoPorcentaje"), rsh)
            );
        };
    }

    /**
     * BR-NEM (LIMITE INFERIOR): rp.nem_minimo <= parametroNem.
     * Estudiante con NEM 5.5 ve becas de 5.5-, no ve becas de 6.0+.
     */
    public static Specification<Beca> hasNemMin(Double nem) {
        if (nem == null) return null;

        return (root, query, cb) -> {
            var requisitoJoin = root.join("requisitoPerfil", JoinType.LEFT);
            return cb.or(
                    cb.isNull(requisitoJoin.get("nemMinimo")),
                    cb.lessThanOrEqualTo(requisitoJoin.get("nemMinimo"), BigDecimal.valueOf(nem))
            );
        };
    }

    /**
     * BR-REGION: Becas con regionId en BecaRegion O becas sin regiones (nacionales).
     */
    public static Specification<Beca> hasRegionOrNational(Long regionId) {
        if (regionId == null) return null;

        return (root, query, cb) -> {
            SetJoin<Beca, ?> regionJoin = root.joinSet("regiones", JoinType.LEFT);
            return cb.or(
                    cb.equal(regionJoin.get("idRegion"), regionId),
                    cb.isNull(regionJoin.get("idRegion"))
            );
        };
    }

    /**
     * BR-TEXT: Búsqueda por texto libre en nombre o descripción corta.
     */
    public static Specification<Beca> hasTextQuery(String queryText) {
        if (queryText == null || queryText.isBlank()) return null;
        String pattern = "%" + queryText.toLowerCase().trim() + "%";

        return (root, cq, cb) -> cb.or(
                cb.like(cb.lower(root.get("nombre")), pattern),
                cb.like(cb.lower(root.get("descripcionCorta")), pattern)
        );
    }

    /**
     * Filtro por Tipo de Beca.
     */
    public static Specification<Beca> hasTipoBeca(Long idTipoBeca) {
        if (idTipoBeca == null) return null;
        return (root, cq, cb) -> cb.equal(root.get("tipoBeca").get("idTipoBeca"), idTipoBeca);
    }

    /**
     * Filtro por Institución.
     */
    public static Specification<Beca> hasInstitucion(Long idInstitucion) {
        if (idInstitucion == null) return null;
        return (root, cq, cb) -> cb.equal(root.get("institucion").get("idInstitucion"), idInstitucion);
    }
}
