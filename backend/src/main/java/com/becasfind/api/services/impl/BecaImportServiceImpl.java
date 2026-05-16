package com.becasfind.api.services.impl;

import com.becasfind.api.models.dtos.CsvBecaRow;
import com.becasfind.api.models.dtos.ImportResultDTO;
import com.becasfind.api.models.entities.Beca;
import com.becasfind.api.models.entities.Institucion;
import com.becasfind.api.models.entities.Region;
import com.becasfind.api.models.entities.RequisitoPerfil;
import com.becasfind.api.models.entities.TipoBeca;
import com.becasfind.api.models.entities.TipoInstitucion;
import com.becasfind.api.models.entities.Usuario;
import com.becasfind.api.repositories.BecaRepository;
import com.becasfind.api.repositories.InstitucionRepository;
import com.becasfind.api.repositories.RegionRepository;
import com.becasfind.api.repositories.TipoBecaRepository;
import com.becasfind.api.repositories.TipoInstitucionRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.services.BecaImportService;
import com.opencsv.bean.CsvToBean;
import com.opencsv.bean.CsvToBeanBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.Reader;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class BecaImportServiceImpl implements BecaImportService {

    private static final Logger log = LoggerFactory.getLogger(BecaImportServiceImpl.class);

    private final BecaRepository becaRepository;
    private final InstitucionRepository institucionRepository;
    private final TipoBecaRepository tipoBecaRepository;
    private final TipoInstitucionRepository tipoInstitucionRepository;
    private final RegionRepository regionRepository;
    private final UsuarioRepository usuarioRepository;

    public BecaImportServiceImpl(BecaRepository becaRepository,
                                  InstitucionRepository institucionRepository,
                                  TipoBecaRepository tipoBecaRepository,
                                  TipoInstitucionRepository tipoInstitucionRepository,
                                  RegionRepository regionRepository,
                                  UsuarioRepository usuarioRepository) {
        this.becaRepository = becaRepository;
        this.institucionRepository = institucionRepository;
        this.tipoBecaRepository = tipoBecaRepository;
        this.tipoInstitucionRepository = tipoInstitucionRepository;
        this.regionRepository = regionRepository;
        this.usuarioRepository = usuarioRepository;
    }

    @Override
    @Transactional
    public ImportResultDTO importarDesdeCsv(MultipartFile file) {
        ImportResultDTO result = new ImportResultDTO();

        try (Reader reader = new BufferedReader(new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8))) {
            CsvToBean<CsvBecaRow> csvToBean = new CsvToBeanBuilder<CsvBecaRow>(reader)
                    .withType(CsvBecaRow.class)
                    .withIgnoreLeadingWhiteSpace(true)
                    .withThrowExceptions(false)
                    .build();

            List<CsvBecaRow> rows = csvToBean.parse();
            for (CsvBecaRow row : rows) {
                try {
                    processRow(row, result);
                } catch (Exception e) {
                    result.getMensajesError().add("Fila '" + row.getNombre() + "': " + e.getMessage());
                    result.setErrores(result.getErrores() + 1);
                }
            }
        } catch (Exception e) {
            log.error("Error al leer el archivo CSV", e);
            result.getMensajesError().add("Error al leer el archivo: " + e.getMessage());
            result.setErrores(result.getErrores() + 1);
        }

        log.info("Importacion completada: {} creadas, {} actualizadas, {} errores",
                result.getCreadas(), result.getActualizadas(), result.getErrores());
        return result;
    }

    private void processRow(CsvBecaRow row, ImportResultDTO result) {
        TipoInstitucion tipoInst = tipoInstitucionRepository
                .findByNombreIgnoreCase("Universidad")
                .orElseGet(() -> {
                    TipoInstitucion nuevo = new TipoInstitucion();
                    nuevo.setNombre("Universidad");
                    return tipoInstitucionRepository.save(nuevo);
                });

        String nombreInst = row.getInstitucion().trim();
        Institucion institucion = institucionRepository
                .findByNombreIgnoreCase(nombreInst)
                .orElseGet(() -> {
                    Institucion nueva = new Institucion();
                    nueva.setNombre(nombreInst);
                    nueva.setRut("0-0");
                    nueva.setTipoInstitucion(tipoInst);
                    return institucionRepository.save(nueva);
                });

        String nombreTipoBeca = row.getTipoBeca().trim();
        TipoBeca tipoBeca = tipoBecaRepository
                .findByNombreIgnoreCase(nombreTipoBeca)
                .orElseGet(() -> {
                    TipoBeca nuevo = new TipoBeca();
                    nuevo.setNombre(nombreTipoBeca);
                    return tipoBecaRepository.save(nuevo);
                });

        Usuario admin = usuarioRepository.findByEmail("admin@becasfind.cl").orElse(null);

        Set<Region> regionesSet = new HashSet<>();
        if (row.getRegiones() != null && !row.getRegiones().isBlank()) {
            for (String abrev : row.getRegiones().split(",")) {
                regionRepository.findByAbreviaturaIgnoreCase(abrev.trim())
                        .ifPresent(regionesSet::add);
            }
        }

        LocalDate fechaCierre = parseDate(row.getFechaCierre());
        LocalDate fechaInicio = row.getFechaInicio() != null && !row.getFechaInicio().isBlank()
                ? parseDate(row.getFechaInicio()) : null;

        var becaExistente = becaRepository.findByNombreAndInstitucionIdInstitucion(
                row.getNombre().trim(), institucion.getIdInstitucion());

        if (becaExistente.isPresent()) {
            Beca beca = becaExistente.get();
            beca.setMontoCobertura(row.getMonto());
            beca.setFechaInicioPostulacion(fechaInicio);
            beca.setFechaCierrePostulacion(fechaCierre);
            beca.setUrlOficial(row.getUrl());
            beca.setDescripcionCorta(row.getDescripcion());
            beca.setEstadoActiva(fechaCierre != null && fechaCierre.isAfter(LocalDate.now()));
            if (!regionesSet.isEmpty()) beca.setRegiones(regionesSet);

            if (beca.getRequisitoPerfil() != null) {
                RequisitoPerfil rp = beca.getRequisitoPerfil();
                rp.setRshMaximoPorcentaje(parseInt(row.getRshMaximo()));
                rp.setNemMinimo(parseBigDecimal(row.getNemMinimo()));
            }

            becaRepository.save(beca);
            result.setActualizadas(result.getActualizadas() + 1);
        } else {
            Beca beca = new Beca();
            beca.setNombre(row.getNombre().trim());
            beca.setDescripcionCorta(row.getDescripcion());
            beca.setMontoCobertura(row.getMonto());
            beca.setFechaInicioPostulacion(fechaInicio);
            beca.setFechaCierrePostulacion(fechaCierre);
            beca.setUrlOficial(row.getUrl());
            beca.setEstadoActiva(fechaCierre != null && fechaCierre.isAfter(LocalDate.now()));
            beca.setInstitucion(institucion);
            beca.setTipoBeca(tipoBeca);
            beca.setUsuarioCreador(admin);
            beca.setRegiones(regionesSet);

            RequisitoPerfil rp = new RequisitoPerfil();
            rp.setBeca(beca);
            rp.setRshMaximoPorcentaje(parseInt(row.getRshMaximo()));
            rp.setNemMinimo(parseBigDecimal(row.getNemMinimo()));
            beca.setRequisitoPerfil(rp);

            becaRepository.save(beca);
            result.setCreadas(result.getCreadas() + 1);
        }
    }

    private LocalDate parseDate(String value) {
        if (value == null || value.isBlank()) return null;
        for (String fmt : Arrays.asList("yyyy-MM-dd", "dd/MM/yyyy", "dd-MM-yyyy")) {
            try {
                return LocalDate.parse(value.trim(), DateTimeFormatter.ofPattern(fmt));
            } catch (DateTimeParseException ignored) {}
        }
        throw new IllegalArgumentException("Formato de fecha no reconocido: " + value);
    }

    private Integer parseInt(String value) {
        if (value == null || value.isBlank()) return null;
        try { return Integer.parseInt(value.trim()); } catch (NumberFormatException e) { return null; }
    }

    private BigDecimal parseBigDecimal(String value) {
        if (value == null || value.isBlank()) return null;
        try { return new BigDecimal(value.trim()); } catch (NumberFormatException e) { return null; }
    }
}
