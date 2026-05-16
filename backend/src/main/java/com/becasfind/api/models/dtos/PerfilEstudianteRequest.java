package com.becasfind.api.models.dtos;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Positive;
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

    @Min(0)
    @Max(100)
    private Integer rshPorcentaje;

    @Min(1)
    @Max(7)
    private BigDecimal nemPromedio;

    @Positive
    private Long idRegion;

    @Positive
    private Long idInstitucion;

    private String carreraInteres;

    private Boolean esPrimerAnio;

    private Boolean esCursoSuperior;
}
