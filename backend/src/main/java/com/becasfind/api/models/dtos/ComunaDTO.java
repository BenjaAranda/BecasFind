package com.becasfind.api.models.dtos;

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
public class ComunaDTO {

    private Long idComuna;

    private String nombre;

    private Long idRegion;

    private String nombreRegion;
}
