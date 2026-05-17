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
public class PerfilEstudianteRequest {

    private Integer rshPorcentaje;

    private BigDecimal nemPromedio;

    private Long idRegion;

    private Long idInstitucion;

    private String carreraInteres;

    private Boolean esPrimerAnio;

    private Boolean esCursoSuperior;
}
