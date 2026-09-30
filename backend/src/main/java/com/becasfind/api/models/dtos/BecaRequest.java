package com.becasfind.api.models.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.Digits;
import jakarta.validation.Valid;
import jakarta.validation.constraints.AssertTrue;
import com.fasterxml.jackson.annotation.JsonIgnore;
import java.net.URI;
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

    @NotNull(message = "El ID de la institución es obligatorio")
    @Positive(message = "El identificador debe ser positivo")
    private Long idInstitucion;

    @NotNull(message = "El ID del tipo de beca es obligatorio")
    @Positive(message = "El identificador debe ser positivo")
    private Long idTipoBeca;

    @NotBlank(message = "El nombre de la beca es obligatorio")
    @Size(max = 255, message = "El nombre no puede superar 255 caracteres")
    private String nombre;

    private String descripcionCorta;

    private String descripcionLarga;

    @Size(max = 255, message = "La cobertura no puede superar 255 caracteres")
    private String montoCobertura;

    @Valid
    private CoberturaDTO cobertura;

    private LocalDate fechaInicioPostulacion;

    private LocalDate fechaCierrePostulacion;

    @Size(max = 500, message = "La URL no puede superar 500 caracteres")
    private String urlOficial;

    @NotNull(message = "El estado activo no puede ser nulo")
    private Boolean estadoActiva = true;

    @Valid
    private List<@NotNull(message = "La región no puede ser nula") @Positive(message = "La región debe tener un identificador positivo") Long> regionesIds;

    @Min(value = 0, message = "El RSH no puede ser negativo")
    @Max(value = 100, message = "El RSH no puede superar 100")
    private Integer rshMaximoPorcentaje;

    @DecimalMin(value = "1.0", message = "El NEM debe ser al menos 1")
    @DecimalMax(value = "7.0", message = "El NEM no puede superar 7")
    @Digits(integer = 1, fraction = 1, message = "El NEM admite un máximo de un decimal")
    private BigDecimal nemMinimo;

    @Min(value = 0, message = "El puntaje PAES no puede ser negativo")
    @Max(value = 1000, message = "El puntaje PAES no puede superar 1000")
    private Integer paesMinimo;

    private Boolean esParaPrimerAnio;

    private Boolean esParaCursoSuperior;

    @Valid
    private List<@NotNull(message = "El documento no puede ser nulo") DocumentoRequeridoDTO> documentosRequeridos;

    @JsonIgnore
    @AssertTrue(message = "La fecha de inicio no puede ser posterior al cierre")
    public boolean isFechasValidas() {
        return fechaInicioPostulacion == null || fechaCierrePostulacion == null
                || !fechaInicioPostulacion.isAfter(fechaCierrePostulacion);
    }

    @JsonIgnore
    @AssertTrue(message = "La URL debe ser HTTP o HTTPS y tener un servidor válido")
    public boolean isUrlValida() {
        if (urlOficial == null || urlOficial.isEmpty()) return true;
        try {
            URI uri = URI.create(urlOficial);
            return ("https".equalsIgnoreCase(uri.getScheme()) || "http".equalsIgnoreCase(uri.getScheme()))
                    && uri.getHost() != null && uri.getUserInfo() == null;
        } catch (IllegalArgumentException ex) {
            return false;
        }
    }
}
