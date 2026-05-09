package com.becasfind.api.models.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
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
public class BecaRequest {

    @NotNull(message = "El ID de la institucion es obligatorio")
    private Long idInstitucion;

    @NotNull(message = "El ID del tipo de beca es obligatorio")
    private Long idTipoBeca;

    @NotBlank(message = "El nombre de la beca es obligatorio")
    private String nombre;

    private String descripcionCorta;

    private String descripcionLarga;

    private String montoCobertura;

    private LocalDate fechaInicioPostulacion;

    @NotNull(message = "La fecha de cierre es obligatoria")
    private LocalDate fechaCierrePostulacion;

    private String urlOficial;

    private Boolean estadoActiva = true;

    private List<Long> regionesIds;

    private Integer rshMaximoPorcentaje;

    private BigDecimal nemMinimo;

    private Integer paesMinimo;

    private Boolean esParaPrimerAnio;

    private Boolean esParaCursoSuperior;

    private List<DocumentoRequeridoDTO> documentosRequeridos;
}
