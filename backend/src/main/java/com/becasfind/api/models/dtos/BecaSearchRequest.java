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
public class BecaSearchRequest {

    private Integer rsh;

    private Double nem;

    private Integer regionId;

    private String query;

    private Long idTipoBeca;

    private Long idInstitucion;

    private String sort;

    private Integer page = 0;

    private Integer size = 10;
}
