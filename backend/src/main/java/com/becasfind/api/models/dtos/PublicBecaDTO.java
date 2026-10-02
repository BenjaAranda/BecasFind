package com.becasfind.api.models.dtos;

import java.time.LocalDate;
import java.util.UUID;

public record PublicBecaDTO(UUID idBeca, String nombre, String descripcionCorta,
        String montoCobertura, CoberturaDTO cobertura, LocalDate fechaCierrePostulacion,
        String urlOficial, String nombreInstitucion, String nombreTipoBeca,
        String nombreRegion, Boolean estadoActiva) {
    public static PublicBecaDTO from(BecaDTO b) {
        return new PublicBecaDTO(b.getPublicId(), b.getNombre(), b.getDescripcionCorta(),
                b.getMontoCobertura(), b.getCobertura(), b.getFechaCierrePostulacion(), b.getUrlOficial(),
                b.getNombreInstitucion(), b.getNombreTipoBeca(), b.getNombreRegion(), b.getEstadoActiva());
    }
}
