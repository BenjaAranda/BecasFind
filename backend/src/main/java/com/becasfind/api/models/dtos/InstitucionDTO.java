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
public class InstitucionDTO {

    private Long idInstitucion;

    private String rut;

    private String nombre;

    private String sitioWeb;

    private String contactoEmail;

    private TipoInstitucionDTO tipoInstitucion;
}
