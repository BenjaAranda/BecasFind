package com.becasfind.api.models.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BecaDetailDTO {

    private Long idBeca;

    private String nombre;

    private String descripcionCorta;

    private String descripcionLarga;

    private String montoCobertura;

    private LocalDate fechaInicioPostulacion;

    private LocalDate fechaCierrePostulacion;

    private String urlOficial;

    private Boolean estadoActiva;

    private InstitucionDTO institucion;

    private TipoBecaDTO tipoBeca;

    private List<RegionDTO> regiones;

    private RequisitoPerfilDTO requisitoPerfil;

    private List<DocumentoRequeridoDTO> documentosRequeridos;
}
