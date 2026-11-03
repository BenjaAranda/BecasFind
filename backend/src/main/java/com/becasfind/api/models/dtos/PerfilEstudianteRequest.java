package com.becasfind.api.models.dtos;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.Digits;
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

    @Min(value = 0, message = "El RSH no puede ser negativo")
    @Max(value = 100, message = "El RSH no puede superar 100")
    private Integer rshPorcentaje;

    @DecimalMin(value = "1.0", message = "El NEM debe ser al menos 1")
    @DecimalMax(value = "7.0", message = "El NEM no puede superar 7")
    @Digits(integer = 1, fraction = 1, message = "El NEM admite un máximo de un decimal")
    private BigDecimal nemPromedio;

    @Positive(message = "El identificador debe ser positivo")
    private Long idRegion;

    @Positive(message = "El identificador debe ser positivo")
    private Long idInstitucion;

    @Size(max = 255, message = "La carrera no puede superar 255 caracteres")
    private String carreraInteres;

    private Boolean esPrimerAnio;

    private Boolean esCursoSuperior;
}
