package com.becasfind.api.models.dtos;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public record PublicBecaDetailDTO(UUID idBeca, String nombre, String descripcionCorta,
        String descripcionLarga, String montoCobertura, CoberturaDTO cobertura,
        LocalDate fechaInicioPostulacion, LocalDate fechaCierrePostulacion, String urlOficial,
        Boolean estadoActiva, InstitucionDTO institucion, TipoBecaDTO tipoBeca,
        List<RegionDTO> regiones, RequisitoPerfilDTO requisitoPerfil, List<DocumentoRequeridoDTO> documentosRequeridos) {
    public static PublicBecaDetailDTO from(BecaDetailDTO b) {
        var requirements = b.getRequisitoPerfil();
        var publicRequirements = requirements == null ? null : RequisitoPerfilDTO.builder()
                .rshMaximoPorcentaje(requirements.getRshMaximoPorcentaje()).nemMinimo(requirements.getNemMinimo())
                .paesMinimo(requirements.getPaesMinimo()).esParaPrimerAnio(requirements.getEsParaPrimerAnio())
                .esParaCursoSuperior(requirements.getEsParaCursoSuperior()).build();
        var documents = b.getDocumentosRequeridos().stream().map(d -> DocumentoRequeridoDTO.builder()
                .nombreDocumento(d.getNombreDocumento()).esObligatorio(d.getEsObligatorio()).build()).toList();
        return new PublicBecaDetailDTO(b.getPublicId(), b.getNombre(), b.getDescripcionCorta(), b.getDescripcionLarga(),
                b.getMontoCobertura(), b.getCobertura(), b.getFechaInicioPostulacion(), b.getFechaCierrePostulacion(),
                b.getUrlOficial(), b.getEstadoActiva(), b.getInstitucion(), b.getTipoBeca(), b.getRegiones(), publicRequirements, documents);
    }
}
