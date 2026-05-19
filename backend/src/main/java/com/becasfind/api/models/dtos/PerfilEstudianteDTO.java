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
public class PerfilEstudianteDTO {

    private Long idPerfil;

    private Integer rshPorcentaje;

    private BigDecimal nemPromedio;

    private RegionDTO region;

    private InstitucionDTO institucion;

    private String carreraInteres;

    private Boolean esPrimerAnio;

    private Boolean esCursoSuperior;
}
