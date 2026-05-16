package com.becasfind.api.models.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ImportResultDTO {

    private int creadas;

    private int actualizadas;

    private int errores;

    @Builder.Default
    private List<String> mensajesError = new ArrayList<>();
}
