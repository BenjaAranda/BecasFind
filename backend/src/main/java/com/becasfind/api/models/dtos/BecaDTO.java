package com.becasfind.api.models.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BecaDTO {

    private Long idBeca;

    private String nombre;

    private String descripcionCorta;

    private String montoCobertura;

    private LocalDate fechaCierrePostulacion;

    private String urlOficial;

    private String nombreInstitucion;

    private String nombreTipoBeca;

    private String nombreRegion;
}
