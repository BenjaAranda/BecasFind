package com.becasfind.api.models.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RequisitoPerfilDTO {

    private Long idRequisito;

    private Integer rshMaximoPorcentaje;

    private BigDecimal nemMinimo;

    private Integer paesMinimo;

    private Boolean esParaPrimerAnio;

    private Boolean esParaCursoSuperior;
}
