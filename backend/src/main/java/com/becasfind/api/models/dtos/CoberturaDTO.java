package com.becasfind.api.models.dtos;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;
import java.util.Currency;
import java.util.Set;

@Getter
@Setter
public class CoberturaDTO {
    @NotNull
    @Pattern(regexp = "MONETARIA|PORCENTUAL|NO_MONETARIA|DESCONOCIDA")
    private String tipo;
    @DecimalMin("0")
    @Digits(integer = 16, fraction = 2)
    @com.fasterxml.jackson.annotation.JsonFormat(shape = com.fasterxml.jackson.annotation.JsonFormat.Shape.STRING)
    private BigDecimal importe;
    @Pattern(regexp = "[A-Z]{3}")
    private String moneda;
    @Pattern(regexp = "UNICA|MENSUAL|SEMESTRAL|ANUAL|DESCONOCIDA")
    private String periodicidad;
    @DecimalMin("0")
    @DecimalMax("100")
    @Digits(integer = 3, fraction = 2)
    @com.fasterxml.jackson.annotation.JsonFormat(shape = com.fasterxml.jackson.annotation.JsonFormat.Shape.STRING)
    private BigDecimal porcentaje;

    @JsonIgnore
    @AssertTrue(message = "La cobertura debe tener campos coherentes con su tipo y una moneda válida")
    public boolean isCoherente() {
        if (tipo == null) return false;
        if (moneda != null) {
            try { Currency.getInstance(moneda); } catch (IllegalArgumentException ex) { return false; }
        }
        if ("MONETARIA".equals(tipo)) return porcentaje == null && (importe == null || moneda != null);
        if ("PORCENTUAL".equals(tipo)) return importe == null && moneda == null && periodicidad == null;
        return Set.of("NO_MONETARIA", "DESCONOCIDA").contains(tipo)
                && importe == null && moneda == null && periodicidad == null && porcentaje == null;
    }
}
