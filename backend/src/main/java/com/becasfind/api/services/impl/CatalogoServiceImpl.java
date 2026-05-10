package com.becasfind.api.services.impl;

import com.becasfind.api.models.dtos.ComunaDTO;
import com.becasfind.api.models.dtos.InstitucionDTO;
import com.becasfind.api.models.dtos.RegionDTO;
import com.becasfind.api.models.dtos.TipoBecaDTO;
import com.becasfind.api.models.dtos.TipoInstitucionDTO;
import com.becasfind.api.models.entities.Institucion;
import com.becasfind.api.repositories.ComunaRepository;
import com.becasfind.api.repositories.InstitucionRepository;
import com.becasfind.api.repositories.RegionRepository;
import com.becasfind.api.repositories.TipoBecaRepository;
import com.becasfind.api.repositories.TipoInstitucionRepository;
import com.becasfind.api.services.CatalogoService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CatalogoServiceImpl implements CatalogoService {

    private final RegionRepository regionRepository;
    private final ComunaRepository comunaRepository;
    private final TipoBecaRepository tipoBecaRepository;
    private final TipoInstitucionRepository tipoInstitucionRepository;
    private final InstitucionRepository institucionRepository;

    public CatalogoServiceImpl(RegionRepository regionRepository,
                               ComunaRepository comunaRepository,
                               TipoBecaRepository tipoBecaRepository,
                               TipoInstitucionRepository tipoInstitucionRepository,
                               InstitucionRepository institucionRepository) {
        this.regionRepository = regionRepository;
        this.comunaRepository = comunaRepository;
        this.tipoBecaRepository = tipoBecaRepository;
        this.tipoInstitucionRepository = tipoInstitucionRepository;
        this.institucionRepository = institucionRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<RegionDTO> findAllRegiones() {
        return regionRepository.findAll().stream()
                .map(r -> RegionDTO.builder()
                        .idRegion(r.getIdRegion())
                        .nombre(r.getNombre())
                        .abreviatura(r.getAbreviatura())
                        .build())
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<ComunaDTO> findComunasByRegion(Long regionId) {
        return comunaRepository.findByRegionIdRegion(regionId).stream()
                .map(c -> ComunaDTO.builder()
                        .idComuna(c.getIdComuna())
                        .nombre(c.getNombre())
                        .idRegion(c.getRegion().getIdRegion())
                        .nombreRegion(c.getRegion().getNombre())
                        .build())
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<TipoBecaDTO> findAllTiposBeca() {
        return tipoBecaRepository.findAll().stream()
                .map(t -> TipoBecaDTO.builder()
                        .idTipoBeca(t.getIdTipoBeca())
                        .nombre(t.getNombre())
                        .build())
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<TipoInstitucionDTO> findAllTiposInstitucion() {
        return tipoInstitucionRepository.findAll().stream()
                .map(t -> TipoInstitucionDTO.builder()
                        .idTipoInst(t.getIdTipoInst())
                        .nombre(t.getNombre())
                        .build())
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<InstitucionDTO> findAllInstituciones() {
        return institucionRepository.findAll().stream()
                .map(this::toInstitucionDTO)
                .collect(Collectors.toList());
    }

    private InstitucionDTO toInstitucionDTO(Institucion inst) {
        TipoInstitucionDTO tipoDTO = null;
        if (inst.getTipoInstitucion() != null) {
            tipoDTO = TipoInstitucionDTO.builder()
                    .idTipoInst(inst.getTipoInstitucion().getIdTipoInst())
                    .nombre(inst.getTipoInstitucion().getNombre())
                    .build();
        }

        return InstitucionDTO.builder()
                .idInstitucion(inst.getIdInstitucion())
                .rut(inst.getRut())
                .nombre(inst.getNombre())
                .sitioWeb(inst.getSitioWeb())
                .contactoEmail(inst.getContactoEmail())
                .tipoInstitucion(tipoDTO)
                .build();
    }
}
