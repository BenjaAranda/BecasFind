package com.becasfind.api.services;

import com.becasfind.api.models.dtos.ComunaDTO;
import com.becasfind.api.models.dtos.RegionDTO;
import com.becasfind.api.models.dtos.TipoBecaDTO;
import com.becasfind.api.models.dtos.TipoInstitucionDTO;
import com.becasfind.api.models.dtos.InstitucionDTO;

import java.util.List;

public interface CatalogoService {

    List<RegionDTO> findAllRegiones();

    List<ComunaDTO> findComunasByRegion(Long regionId);

    List<TipoBecaDTO> findAllTiposBeca();

    List<TipoInstitucionDTO> findAllTiposInstitucion();

    List<InstitucionDTO> findAllInstituciones();
}
