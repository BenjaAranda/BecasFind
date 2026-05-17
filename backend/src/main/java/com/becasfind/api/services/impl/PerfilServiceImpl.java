package com.becasfind.api.services.impl;

import com.becasfind.api.models.dtos.InstitucionDTO;
import com.becasfind.api.models.dtos.PerfilEstudianteDTO;
import com.becasfind.api.models.dtos.PerfilEstudianteRequest;
import com.becasfind.api.models.dtos.RegionDTO;
import com.becasfind.api.models.dtos.TipoInstitucionDTO;
import com.becasfind.api.models.entities.PerfilEstudiante;
import com.becasfind.api.models.entities.Usuario;
import com.becasfind.api.repositories.InstitucionRepository;
import com.becasfind.api.repositories.PerfilEstudianteRepository;
import com.becasfind.api.repositories.RegionRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.services.PerfilService;
import jakarta.persistence.EntityNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PerfilServiceImpl implements PerfilService {

    private static final Logger log = LoggerFactory.getLogger(PerfilServiceImpl.class);

    private final PerfilEstudianteRepository perfilEstudianteRepository;
    private final UsuarioRepository usuarioRepository;
    private final RegionRepository regionRepository;
    private final InstitucionRepository institucionRepository;

    public PerfilServiceImpl(PerfilEstudianteRepository perfilEstudianteRepository,
                             UsuarioRepository usuarioRepository,
                             RegionRepository regionRepository,
                             InstitucionRepository institucionRepository) {
        this.perfilEstudianteRepository = perfilEstudianteRepository;
        this.usuarioRepository = usuarioRepository;
        this.regionRepository = regionRepository;
        this.institucionRepository = institucionRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public PerfilEstudianteDTO getPerfil(String email) {
        Usuario usuario = usuarioRepository.findByEmailAndActivoTrue(email)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado"));

        return perfilEstudianteRepository.findByUsuarioIdUsuario(usuario.getIdUsuario())
                .map(this::toDto)
                .orElse(null);
    }

    @Override
    @Transactional
    public PerfilEstudianteDTO savePerfil(String email, PerfilEstudianteRequest request) {
        log.info("Guardando perfil para usuario: {}", email);

        Usuario usuario = usuarioRepository.findByEmailAndActivoTrue(email)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con email: " + email));

        PerfilEstudiante perfil = perfilEstudianteRepository
                .findByUsuarioIdUsuario(usuario.getIdUsuario())
                .orElse(new PerfilEstudiante());

        perfil.setUsuario(usuario);
        perfil.setRshPorcentaje(request.getRshPorcentaje());
        perfil.setNemPromedio(request.getNemPromedio());
        perfil.setCarreraInteres(request.getCarreraInteres());
        perfil.setEsPrimerAnio(request.getEsPrimerAnio() != null ? request.getEsPrimerAnio() : false);
        perfil.setEsCursoSuperior(request.getEsCursoSuperior() != null ? request.getEsCursoSuperior() : false);

        if (request.getIdRegion() != null) {
            perfil.setRegion(regionRepository.findById(request.getIdRegion())
                    .orElseThrow(() -> new EntityNotFoundException("Region no encontrada con ID: " + request.getIdRegion())));
        } else {
            perfil.setRegion(null);
        }

        if (request.getIdInstitucion() != null) {
            perfil.setInstitucion(institucionRepository.findById(request.getIdInstitucion())
                    .orElseThrow(() -> new EntityNotFoundException("Institucion no encontrada con ID: " + request.getIdInstitucion())));
        } else {
            perfil.setInstitucion(null);
        }

        try {
            perfil = perfilEstudianteRepository.save(perfil);
            log.info("Perfil guardado exitosamente para: {}", email);
            return toDto(perfil);
        } catch (Exception e) {
            log.error("Error al guardar perfil para usuario {}: {}", email, e.getMessage(), e);
            throw e;
        }
    }

    private PerfilEstudianteDTO toDto(PerfilEstudiante p) {
        PerfilEstudianteDTO dto = PerfilEstudianteDTO.builder()
                .idPerfil(p.getIdPerfil())
                .rshPorcentaje(p.getRshPorcentaje())
                .nemPromedio(p.getNemPromedio())
                .carreraInteres(p.getCarreraInteres())
                .esPrimerAnio(p.getEsPrimerAnio())
                .esCursoSuperior(p.getEsCursoSuperior())
                .build();

        if (p.getRegion() != null) {
            dto.setRegion(RegionDTO.builder()
                    .idRegion(p.getRegion().getIdRegion())
                    .nombre(p.getRegion().getNombre())
                    .abreviatura(p.getRegion().getAbreviatura())
                    .build());
        }

        if (p.getInstitucion() != null) {
            var inst = p.getInstitucion();
            var tipoDto = inst.getTipoInstitucion() != null
                    ? TipoInstitucionDTO.builder().idTipoInst(inst.getTipoInstitucion().getIdTipoInst()).nombre(inst.getTipoInstitucion().getNombre()).build()
                    : null;
            dto.setInstitucion(InstitucionDTO.builder()
                    .idInstitucion(inst.getIdInstitucion())
                    .rut(inst.getRut())
                    .nombre(inst.getNombre())
                    .sitioWeb(inst.getSitioWeb())
                    .contactoEmail(inst.getContactoEmail())
                    .tipoInstitucion(tipoDto)
                    .build());
        }

        return dto;
    }
}
