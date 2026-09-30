package com.becasfind.api.services.impl;

import com.becasfind.api.models.dtos.BecaDTO;
import com.becasfind.api.models.dtos.CoberturaDTO;
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
import com.becasfind.api.repositories.PerfilEstudianteRepository;
import com.becasfind.api.repositories.RegionRepository;
import com.becasfind.api.repositories.TipoBecaRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.services.BecaService;
import com.becasfind.api.services.BecaSpecifications;
import jakarta.persistence.EntityNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
    private final PerfilEstudianteRepository perfilEstudianteRepository;
    private final jakarta.validation.Validator validator;

    public BecaServiceImpl(BecaRepository becaRepository,
                           InstitucionRepository institucionRepository,
                           TipoBecaRepository tipoBecaRepository,
                           RegionRepository regionRepository,
                           UsuarioRepository usuarioRepository,
                           DocumentoRequeridoRepository documentoRequeridoRepository,
                           PerfilEstudianteRepository perfilEstudianteRepository,
                           jakarta.validation.Validator validator) {
        this.becaRepository = becaRepository;
        this.institucionRepository = institucionRepository;
        this.tipoBecaRepository = tipoBecaRepository;
        this.regionRepository = regionRepository;
        this.usuarioRepository = usuarioRepository;
        this.documentoRequeridoRepository = documentoRequeridoRepository;
        this.perfilEstudianteRepository = perfilEstudianteRepository;
        this.validator = validator;
    }

    @Override
    @Transactional(readOnly = true)
    public Page<BecaDTO> buscarBecas(Integer rsh, Double nem, Long regionId,
                                     String query, Long idTipoBeca, Long idInstitucion,
                                     Long idTipoInstitucion, String sort, Pageable pageable) {
        validateSearch(rsh, nem, regionId, query, idTipoBeca, idInstitucion, idTipoInstitucion, pageable);
        Specification<Beca> spec = Specification
                .where(BecaSpecifications.isVigente())
                .and(BecaSpecifications.hasRshMax(rsh))
                .and(BecaSpecifications.hasNemMin(nem))
                .and(BecaSpecifications.hasRegionOrNational(regionId))
                .and(BecaSpecifications.hasTextQuery(query))
                .and(BecaSpecifications.hasTipoBeca(idTipoBeca))
                .and(BecaSpecifications.hasInstitucion(idInstitucion))
                .and(BecaSpecifications.hasTipoInstitucion(idTipoInstitucion));

        boolean monetary = "montoAsc".equals(sort) || "montoDesc".equals(sort);
        Pageable sorted = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(),
                monetary ? Sort.unsorted() : parseSort(sort));
        if (monetary) spec = spec.and(BecaSpecifications.orderByCoverage("montoDesc".equals(sort)));
        return becaRepository.findAll(spec, sorted).map(this::toBecaDTO);
    }

    private Sort parseSort(String sort) {
        Sort primary = switch (sort == null || sort.isBlank() ? "fechaAsc" : sort) {
            case "fechaAsc"  -> Sort.by("fechaCierrePostulacion").ascending();
            case "fechaDesc" -> Sort.by("fechaCierrePostulacion").descending();
            default          -> throw new IllegalArgumentException("Orden de búsqueda no válido");
        };
        return primary.and(Sort.by("idBeca").ascending());
    }

    @Override
    @Transactional(readOnly = true)
    public Page<BecaDTO> listarAdministracion(String query, Pageable pageable) {
        validateSearch(null, null, null, query, null, null, null, pageable);
        Pageable sorted = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), parseSort("fechaAsc"));
        return becaRepository.findAll(BecaSpecifications.hasTextQuery(query), sorted).map(this::toBecaDTO);
    }

    private void validateSearch(Integer rsh, Double nem, Long regionId, String query,
                                Long idTipoBeca, Long idInstitucion, Long idTipoInstitucion, Pageable pageable) {
        validatePage(pageable);
        if (rsh != null && (rsh < 0 || rsh > 100)) throw new IllegalArgumentException("El RSH debe estar entre 0 y 100");
        if (nem != null && (!Double.isFinite(nem) || nem < 1 || nem > 7)) {
            throw new IllegalArgumentException("El NEM debe estar entre 1,0 y 7,0");
        }
        if (query != null && query.length() > 200) throw new IllegalArgumentException("La búsqueda admite hasta 200 caracteres");
        for (Long id : java.util.Arrays.asList(regionId, idTipoBeca, idInstitucion, idTipoInstitucion)) {
            if (id != null && id <= 0) throw new IllegalArgumentException("Los identificadores de filtros deben ser positivos");
        }
    }

    private void validatePage(Pageable pageable) {
        if (pageable == null || pageable.isUnpaged() || pageable.getPageSize() > 100) {
            throw new IllegalArgumentException("Solicita una página de entre 1 y 100 resultados");
        }
    }

    @Override
    @Transactional(readOnly = true)
    public Page<BecaDTO> recomendarBecas(String email, Pageable pageable) {
        validatePage(pageable);
        var perfilOpt = perfilEstudianteRepository
                .findByUsuarioIdUsuario(usuarioRepository.findByEmailAndActivoTrue(email)
                        .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado"))
                        .getIdUsuario());

        if (perfilOpt.isEmpty()) {
            return Page.empty(pageable);
        }

        var perfil = perfilOpt.get();
        Integer rsh = perfil.getRshPorcentaje();
        Double nem = perfil.getNemPromedio() != null ? perfil.getNemPromedio().doubleValue() : null;
        Long regionId = perfil.getRegion() != null ? perfil.getRegion().getIdRegion() : null;
        return buscarBecas(rsh, nem, regionId, null, null, null, null, "fechaAsc", pageable);
    }

    @Override
    @Transactional(readOnly = true)
    public BecaDetailDTO findById(Long id) {
        Beca beca = becaRepository.findByIdWithDetails(id)
                .orElseThrow(() -> new EntityNotFoundException("Beca no encontrada con ID: " + id));
        return toBecaDetailDTO(beca);
    }

    @Override
    @Transactional(readOnly = true)
    public BecaDetailDTO findByPublicId(java.util.UUID id) {
        Beca beca = becaRepository.findByPublicId(id)
                .orElseThrow(() -> new EntityNotFoundException("Beca no encontrada"));
        return toBecaDetailDTO(beca);
    }

    @Override
    @Transactional
    public BecaDTO create(Long userId, BecaRequest request) {
        validateCoverage(request.getCobertura());
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
        applyCoverage(beca, request.getCobertura());
        beca.setFechaInicioPostulacion(request.getFechaInicioPostulacion());
        beca.setFechaCierrePostulacion(request.getFechaCierrePostulacion());
        beca.setUrlOficial(request.getUrlOficial());
        beca.setEstadoActiva(request.getEstadoActiva() != null ? request.getEstadoActiva() : true);
        beca.setInstitucion(institucion);
        beca.setTipoBeca(tipoBeca);
        beca.setUsuarioCreador(usuarioCreador);

        if (request.getRegionesIds() != null && !request.getRegionesIds().isEmpty()) {
            List<Region> regiones = resolveRegiones(request.getRegionesIds());
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
        validateCoverage(request.getCobertura());
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
        applyCoverage(beca, request.getCobertura());
        beca.setFechaInicioPostulacion(request.getFechaInicioPostulacion());
        beca.setFechaCierrePostulacion(request.getFechaCierrePostulacion());
        beca.setUrlOficial(request.getUrlOficial());
        beca.setEstadoActiva(request.getEstadoActiva() != null ? request.getEstadoActiva() : beca.getEstadoActiva());
        beca.setInstitucion(institucion);
        beca.setTipoBeca(tipoBeca);

        if (request.getRegionesIds() != null) {
            List<Region> regiones = resolveRegiones(request.getRegionesIds());
            beca.setRegiones(new java.util.HashSet<>(regiones));
        }

        if (beca.getRequisitoPerfil() == null) {
            RequisitoPerfil requisito = new RequisitoPerfil();
            requisito.setBeca(beca);
            beca.setRequisitoPerfil(requisito);
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

    private void applyCoverage(Beca beca, CoberturaDTO coverage) {
        if (coverage == null) return;
        beca.setCoberturaTipo(coverage.getTipo());
        beca.setCoberturaImporte(coverage.getImporte());
        beca.setCoberturaMoneda(coverage.getMoneda());
        beca.setCoberturaPeriodicidad(coverage.getPeriodicidad());
        beca.setCoberturaPorcentaje(coverage.getPorcentaje());
    }

    private void validateCoverage(CoberturaDTO coverage) {
        if (coverage != null && !validator.validate(coverage).isEmpty()) {
            throw new IllegalArgumentException("La cobertura estructurada no es válida");
        }
    }

    private CoberturaDTO toCoverage(Beca beca) {
        CoberturaDTO coverage = new CoberturaDTO();
        coverage.setTipo(beca.getCoberturaTipo());
        coverage.setImporte(beca.getCoberturaImporte());
        coverage.setMoneda(beca.getCoberturaMoneda());
        coverage.setPeriodicidad(beca.getCoberturaPeriodicidad());
        coverage.setPorcentaje(beca.getCoberturaPorcentaje());
        return coverage;
    }

    private List<Region> resolveRegiones(List<Long> ids) {
        List<Region> regiones = regionRepository.findAllById(ids);
        if (regiones.size() != new java.util.HashSet<>(ids).size()) {
            throw new EntityNotFoundException("Una o más regiones no existen");
        }
        return regiones;
    }

    private BecaDTO toBecaDTO(Beca beca) {
        return BecaDTO.builder()
                .idBeca(beca.getIdBeca())
                .publicId(beca.getPublicId())
                .nombre(beca.getNombre())
                .estadoActiva(beca.getEstadoActiva())
                .descripcionCorta(beca.getDescripcionCorta())
                .montoCobertura(beca.getMontoCobertura())
                .cobertura(toCoverage(beca))
                .fechaCierrePostulacion(beca.getFechaCierrePostulacion())
                .urlOficial(beca.getUrlOficial())
                .nombreInstitucion(beca.getInstitucion() != null ? beca.getInstitucion().getNombre() : null)
                .nombreTipoBeca(beca.getTipoBeca() != null ? beca.getTipoBeca().getNombre() : null)
                .nombreRegion(beca.getRegiones() != null && !beca.getRegiones().isEmpty()
                        ? beca.getRegiones().stream().map(Region::getNombre).sorted().collect(Collectors.joining(", "))
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
                .publicId(beca.getPublicId())
                .nombre(beca.getNombre())
                .descripcionCorta(beca.getDescripcionCorta())
                .descripcionLarga(beca.getDescripcionLarga())
                .montoCobertura(beca.getMontoCobertura())
                .cobertura(toCoverage(beca))
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
