package com.becasfind.api.models.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DocumentoRequeridoDTO {

    private Long idDocumento;

    @NotBlank(message = "El nombre del documento es obligatorio")
    @Size(max = 255, message = "El documento no puede superar 255 caracteres")
    private String nombreDocumento;

    @NotNull(message = "Debe indicarse si el documento es obligatorio")
    private Boolean esObligatorio;
}
