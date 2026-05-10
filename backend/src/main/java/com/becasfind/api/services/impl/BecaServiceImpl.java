package com.becasfind.api.services.impl;

import com.becasfind.api.models.dtos.BecaDTO;
import com.becasfind.api.models.dtos.BecaDetailDTO;
import com.becasfind.api.models.dtos.BecaRequest;
import com.becasfind.api.models.dtos.DocumentoRequeridoDTO;
import com.becasfind.api.models.dtos.InstitucionDTO;
import com.becasfind.api.models.dtos.RegionDTO;
import com.becasfind.api.models.dtos.RequisitoPerfilDTO;
import com.becasfind.api.models.dtos.TipoBecaDTO;
import com.becasfind.api.models.dtos.TipoInstitucionDTO;
import com.becasfind.api.models.entities.Beca;
import com.becasfind.api.models.entities.DocumentoRequerido;
import com.becasfind.api.models.entities.Institucion;
import com.becasfind.api.models.entities.RequisitoPerfil;
import com.becasfind.api.models.entities.Region;
import com.becasfind.api.models.entities.TipoBeca;
import com.becasfind.api.models.entities.TipoInstitucion;
import com.becasfind.api.models.entities.Usuario;
import com.becasfind.api.repositories.BecaRepository;
import com.becasfind.api.repositories.DocumentoRequeridoRepository;
import com.becasfind.api.repositories.InstitucionRepository;
import com.becasfind.api.repositories.RegionRepository;
import com.becasfind.api.repositories.TipoBecaRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.services.BecaService;
import com.becasfind.api.services.BecaSpecifications;
import jakarta.persistence.EntityNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BecaServiceImpl implements BecaService {

    private static final Logger log = LoggerFactory.getLogger(BecaServiceImpl.class);

    private final BecaRepository becaRepository;
    private final InstitucionRepository institucionRepository;
    private final TipoBecaRepository tipoBecaRepository;
    private final RegionRepository regionRepository;
    private final UsuarioRepository usuarioRepository;
    private final DocumentoRequeridoRepository documentoRequeridoRepository;

    public BecaServiceImpl(BecaRepository becaRepository,
                           InstitucionRepository institucionRepository,
                           TipoBecaRepository tipoBecaRepository,
                           RegionRepository regionRepository,
                           UsuarioRepository usuarioRepository,
                           DocumentoRequeridoRepository documentoRequeridoRepository) {
        this.becaRepository = becaRepository;
        this.institucionRepository = institucionRepository;
        this.tipoBecaRepository = tipoBecaRepository;
        this.regionRepository = regionRepository;
        this.usuarioRepository = usuarioRepository;
        this.documentoRequeridoRepository = documentoRequeridoRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public Page<BecaDTO> buscarBecas(Integer rsh, Double nem, Long regionId, Pageable pageable) {
        Specification<Beca> spec = Specification
                .where(BecaSpecifications.isVigente())
                .and(BecaSpecifications.hasRshMax(rsh))
                .and(BecaSpecifications.hasNemMin(nem))
                .and(BecaSpecifications.hasRegionOrNational(regionId));

        return becaRepository.findAll(spec, pageable)
                .map(this::toBecaDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public BecaDetailDTO findById(Long id) {
        Beca beca = becaRepository.findByIdWithDetails(id)
                .orElseThrow(() -> new EntityNotFoundException("Beca no encontrada con ID: " + id));
        return toBecaDetailDTO(beca);
    }

    @Override
    @Transactional
    public BecaDTO create(Long userId, BecaRequest request) {
        Usuario usuarioCreador = usuarioRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con ID: " + userId));

        Institucion institucion = institucionRepository.findById(request.getIdInstitucion())
                .orElseThrow(() -> new EntityNotFoundException("Institucion no encontrada"));

        TipoBeca tipoBeca = tipoBecaRepository.findById(request.getIdTipoBeca())
                .orElseThrow(() -> new EntityNotFoundException("Tipo de beca no encontrado"));

        Beca beca = new Beca();
        beca.setNombre(request.getNombre());
        beca.setDescripcionCorta(request.getDescripcionCorta());
        beca.setDescripcionLarga(request.getDescripcionLarga());
        beca.setMontoCobertura(request.getMontoCobertura());
        beca.setFechaInicioPostulacion(request.getFechaInicioPostulacion());
        beca.setFechaCierrePostulacion(request.getFechaCierrePostulacion());
        beca.setUrlOficial(request.getUrlOficial());
        beca.setEstadoActiva(request.getEstadoActiva() != null ? request.getEstadoActiva() : true);
        beca.setInstitucion(institucion);
        beca.setTipoBeca(tipoBeca);
        beca.setUsuarioCreador(usuarioCreador);

        if (request.getRegionesIds() != null && !request.getRegionesIds().isEmpty()) {
            List<Region> regiones = regionRepository.findAllById(request.getRegionesIds());
            beca.setRegiones(new java.util.HashSet<>(regiones));
        }

        RequisitoPerfil requisito = new RequisitoPerfil();
        requisito.setBeca(beca);
        requisito.setRshMaximoPorcentaje(request.getRshMaximoPorcentaje());
        requisito.setNemMinimo(request.getNemMinimo());
        requisito.setPaesMinimo(request.getPaesMinimo());
        requisito.setEsParaPrimerAnio(request.getEsParaPrimerAnio() != null ? request.getEsParaPrimerAnio() : false);
        requisito.setEsParaCursoSuperior(request.getEsParaCursoSuperior() != null ? request.getEsParaCursoSuperior() : false);
        beca.setRequisitoPerfil(requisito);

        beca = becaRepository.save(beca);

        if (request.getDocumentosRequeridos() != null && !request.getDocumentosRequeridos().isEmpty()) {
            for (DocumentoRequeridoDTO docDto : request.getDocumentosRequeridos()) {
                DocumentoRequerido doc = new DocumentoRequerido();
                doc.setBeca(beca);
                doc.setNombreDocumento(docDto.getNombreDocumento());
                doc.setEsObligatorio(docDto.getEsObligatorio() != null ? docDto.getEsObligatorio() : true);
                documentoRequeridoRepository.save(doc);
            }
        }

        log.info("Beca creada: {} (ID: {}) por usuario {}", beca.getNombre(), beca.getIdBeca(), userId);
        return toBecaDTO(beca);
    }

    @Override
    @Transactional
    public BecaDTO update(Long id, BecaRequest request) {
        Beca beca = becaRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Beca no encontrada con ID: " + id));

        Institucion institucion = institucionRepository.findById(request.getIdInstitucion())
                .orElseThrow(() -> new EntityNotFoundException("Institucion no encontrada"));

        TipoBeca tipoBeca = tipoBecaRepository.findById(request.getIdTipoBeca())
                .orElseThrow(() -> new EntityNotFoundException("Tipo de beca no encontrado"));

        beca.setNombre(request.getNombre());
        beca.setDescripcionCorta(request.getDescripcionCorta());
        beca.setDescripcionLarga(request.getDescripcionLarga());
        beca.setMontoCobertura(request.getMontoCobertura());
        beca.setFechaInicioPostulacion(request.getFechaInicioPostulacion());
        beca.setFechaCierrePostulacion(request.getFechaCierrePostulacion());
        beca.setUrlOficial(request.getUrlOficial());
        beca.setEstadoActiva(request.getEstadoActiva() != null ? request.getEstadoActiva() : beca.getEstadoActiva());
        beca.setInstitucion(institucion);
        beca.setTipoBeca(tipoBeca);

        if (request.getRegionesIds() != null) {
            List<Region> regiones = regionRepository.findAllById(request.getRegionesIds());
            beca.setRegiones(new java.util.HashSet<>(regiones));
        }

        if (beca.getRequisitoPerfil() != null) {
            RequisitoPerfil requisito = beca.getRequisitoPerfil();
            requisito.setRshMaximoPorcentaje(request.getRshMaximoPorcentaje());
            requisito.setNemMinimo(request.getNemMinimo());
            requisito.setPaesMinimo(request.getPaesMinimo());
            if (request.getEsParaPrimerAnio() != null) {
                requisito.setEsParaPrimerAnio(request.getEsParaPrimerAnio());
            }
            if (request.getEsParaCursoSuperior() != null) {
                requisito.setEsParaCursoSuperior(request.getEsParaCursoSuperior());
            }
        }

        beca = becaRepository.save(beca);

        if (request.getDocumentosRequeridos() != null) {
            documentoRequeridoRepository.deleteByBecaIdBeca(beca.getIdBeca());
            for (DocumentoRequeridoDTO docDto : request.getDocumentosRequeridos()) {
                DocumentoRequerido doc = new DocumentoRequerido();
                doc.setBeca(beca);
                doc.setNombreDocumento(docDto.getNombreDocumento());
                doc.setEsObligatorio(docDto.getEsObligatorio() != null ? docDto.getEsObligatorio() : true);
                documentoRequeridoRepository.save(doc);
            }
        }

        log.info("Beca actualizada: {} (ID: {})", beca.getNombre(), beca.getIdBeca());
        return toBecaDTO(beca);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        Beca beca = becaRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Beca no encontrada con ID: " + id));
        becaRepository.delete(beca);
        log.info("Beca eliminada: {} (ID: {})", beca.getNombre(), id);
    }

    private BecaDTO toBecaDTO(Beca beca) {
        return BecaDTO.builder()
                .idBeca(beca.getIdBeca())
                .nombre(beca.getNombre())
                .descripcionCorta(beca.getDescripcionCorta())
                .montoCobertura(beca.getMontoCobertura())
                .fechaCierrePostulacion(beca.getFechaCierrePostulacion())
                .urlOficial(beca.getUrlOficial())
                .nombreInstitucion(beca.getInstitucion() != null ? beca.getInstitucion().getNombre() : null)
                .nombreTipoBeca(beca.getTipoBeca() != null ? beca.getTipoBeca().getNombre() : null)
                .nombreRegion(beca.getRegiones() != null && !beca.getRegiones().isEmpty()
                        ? beca.getRegiones().iterator().next().getNombre()
                        : "Nacional")
                .build();
    }

    private BecaDetailDTO toBecaDetailDTO(Beca beca) {
        List<RegionDTO> regionesDTO = beca.getRegiones() != null
                ? beca.getRegiones().stream()
                        .map(r -> RegionDTO.builder()
                                .idRegion(r.getIdRegion())
                                .nombre(r.getNombre())
                                .abreviatura(r.getAbreviatura())
                                .build())
                        .collect(Collectors.toList())
                : Collections.emptyList();

        InstitucionDTO institucionDTO = null;
        if (beca.getInstitucion() != null) {
            Institucion inst = beca.getInstitucion();
            TipoInstitucionDTO tipoDTO = null;
            if (inst.getTipoInstitucion() != null) {
                tipoDTO = TipoInstitucionDTO.builder()
                        .idTipoInst(inst.getTipoInstitucion().getIdTipoInst())
                        .nombre(inst.getTipoInstitucion().getNombre())
                        .build();
            }
            institucionDTO = InstitucionDTO.builder()
                    .idInstitucion(inst.getIdInstitucion())
                    .rut(inst.getRut())
                    .nombre(inst.getNombre())
                    .sitioWeb(inst.getSitioWeb())
                    .contactoEmail(inst.getContactoEmail())
                    .tipoInstitucion(tipoDTO)
                    .build();
        }

        TipoBecaDTO tipoBecaDTO = null;
        if (beca.getTipoBeca() != null) {
            tipoBecaDTO = TipoBecaDTO.builder()
                    .idTipoBeca(beca.getTipoBeca().getIdTipoBeca())
                    .nombre(beca.getTipoBeca().getNombre())
                    .build();
        }

        RequisitoPerfilDTO requisitoDTO = null;
        if (beca.getRequisitoPerfil() != null) {
            RequisitoPerfil rp = beca.getRequisitoPerfil();
            requisitoDTO = RequisitoPerfilDTO.builder()
                    .idRequisito(rp.getIdRequisito())
                    .rshMaximoPorcentaje(rp.getRshMaximoPorcentaje())
                    .nemMinimo(rp.getNemMinimo())
                    .paesMinimo(rp.getPaesMinimo())
                    .esParaPrimerAnio(rp.getEsParaPrimerAnio())
                    .esParaCursoSuperior(rp.getEsParaCursoSuperior())
                    .build();
        }

        List<DocumentoRequeridoDTO> documentosDTO = beca.getDocumentosRequeridos() != null
                ? beca.getDocumentosRequeridos().stream()
                        .map(d -> DocumentoRequeridoDTO.builder()
                                .idDocumento(d.getIdDocumento())
                                .nombreDocumento(d.getNombreDocumento())
                                .esObligatorio(d.getEsObligatorio())
                                .build())
                        .collect(Collectors.toList())
                : Collections.emptyList();

        return BecaDetailDTO.builder()
                .idBeca(beca.getIdBeca())
                .nombre(beca.getNombre())
                .descripcionCorta(beca.getDescripcionCorta())
                .descripcionLarga(beca.getDescripcionLarga())
                .montoCobertura(beca.getMontoCobertura())
                .fechaInicioPostulacion(beca.getFechaInicioPostulacion())
                .fechaCierrePostulacion(beca.getFechaCierrePostulacion())
                .urlOficial(beca.getUrlOficial())
                .estadoActiva(beca.getEstadoActiva())
                .institucion(institucionDTO)
                .tipoBeca(tipoBecaDTO)
                .regiones(regionesDTO)
                .requisitoPerfil(requisitoDTO)
                .documentosRequeridos(documentosDTO)
                .build();
    }
}
