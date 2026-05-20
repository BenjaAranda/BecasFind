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

import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
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

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8))) {
            reader.mark(1);
            if (reader.read() != '\uFEFF') {
                reader.reset();
            }

            CsvToBean<CsvBecaRow> csvToBean = new CsvToBeanBuilder<CsvBecaRow>(reader)
                    .withType(CsvBecaRow.class)
                    .withIgnoreLeadingWhiteSpace(true)
                    .withThrowExceptions(false)
                    .build();

            List<CsvBecaRow> rows = csvToBean.parse();

            log.info("CSV parseado: {} filas detectadas", rows.size());
            if (rows.isEmpty()) {
                log.warn("CSV sin filas: verifique que los encabezados del archivo coincidan con los nombres de columna esperados (nombre, institucion, tipo_beca, monto, fecha_inicio, fecha_cierre, rsh_maximo, nem_minimo, regiones, descripcion, url)");
                result.getMensajesError().add("No se detectaron filas: verifique que los nombres de columna del CSV coincidan exactamente con los esperados");
                result.setErrores(result.getErrores() + 1);
            }

            for (CsvBecaRow row : rows) {
                try {
                    validarCamposRequeridos(row);
                    processRow(row, result);
                } catch (Exception e) {
                    String nombreFila = row.getNombre() != null ? row.getNombre() : "(nombre nulo)";
                    log.warn("Fila ignorada [{}]: {}", nombreFila, e.getMessage());
                    result.getMensajesError().add("Fila '" + nombreFila + "': " + e.getMessage());
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

    private void validarCamposRequeridos(CsvBecaRow row) {
        List<String> faltantes = new ArrayList<>();
        if (row.getNombre() == null || row.getNombre().isBlank()) faltantes.add("nombre");
        if (row.getInstitucion() == null || row.getInstitucion().isBlank()) faltantes.add("institucion");
        if (row.getTipoBeca() == null || row.getTipoBeca().isBlank()) faltantes.add("tipo_beca");
        if (!faltantes.isEmpty()) {
            throw new IllegalArgumentException("Campos requeridos ausentes/vacíos: " + String.join(", ", faltantes)
                    + " — verificar coincidencia exacta de nombres de columna en el CSV");
        }
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
                String abrevTrimmed = abrev.trim();
                var regionOpt = regionRepository.findByAbreviaturaIgnoreCase(abrevTrimmed);
                if (regionOpt.isPresent()) {
                    regionesSet.add(regionOpt.get());
                } else {
                    log.warn("Fila [{}]: región no encontrada en BD - abreviatura='{}'",
                            row.getNombre(), abrevTrimmed);
                    result.getMensajesError().add("Fila '" + row.getNombre() + "': región no encontrada - '" + abrevTrimmed + "'");
                }
            }
        }

        LocalDate fechaCierre = parseDate(row.getFechaCierre(), "fecha_cierre", row.getNombre());
        if (fechaCierre == null) {
            fechaCierre = LocalDate.of(LocalDate.now().getYear(), 12, 31);
            log.warn("Fila [{}]: fecha_cierre nula/vacía — asignado default 31-12-{}", row.getNombre(), LocalDate.now().getYear());
        }
        LocalDate fechaInicio = row.getFechaInicio() != null && !row.getFechaInicio().isBlank()
                ? parseDate(row.getFechaInicio(), "fecha_inicio", row.getNombre()) : null;
        if (fechaInicio == null) {
            fechaInicio = LocalDate.of(LocalDate.now().getYear(), 1, 1);
            log.warn("Fila [{}]: fecha_inicio nula/vacía — asignado default 01-01-{}", row.getNombre(), LocalDate.now().getYear());
        }

        Integer rsh = parseOptionalInt(row.getRshMaximo(), "rsh_maximo", row.getNombre(), result);
        BigDecimal nem = parseOptionalBigDecimal(row.getNemMinimo(), "nem_minimo", row.getNombre(), result);

        var becaExistente = becaRepository.findByNombreAndInstitucionIdInstitucion(
                row.getNombre().trim(), institucion.getIdInstitucion());

        if (becaExistente.isPresent()) {
            Beca beca = becaExistente.get();
            beca.setMontoCobertura(row.getMonto());
            beca.setFechaInicioPostulacion(fechaInicio);
            beca.setFechaCierrePostulacion(fechaCierre);
            beca.setUrlOficial(row.getUrl());
            beca.setDescripcionCorta(row.getDescripcion());
            beca.setEstadoActiva(fechaCierre == null || fechaCierre.isAfter(LocalDate.now()));
            if (!regionesSet.isEmpty()) beca.setRegiones(regionesSet);

            if (beca.getRequisitoPerfil() != null) {
                RequisitoPerfil rp = beca.getRequisitoPerfil();
                rp.setRshMaximoPorcentaje(rsh);
                rp.setNemMinimo(nem);
            }

            becaRepository.save(beca);
            becaRepository.flush();
            result.setActualizadas(result.getActualizadas() + 1);
        } else {
            Beca beca = new Beca();
            beca.setNombre(row.getNombre().trim());
            beca.setDescripcionCorta(row.getDescripcion());
            beca.setMontoCobertura(row.getMonto());
            beca.setFechaInicioPostulacion(fechaInicio);
            beca.setFechaCierrePostulacion(fechaCierre);
            beca.setUrlOficial(row.getUrl());
            beca.setEstadoActiva(fechaCierre == null || fechaCierre.isAfter(LocalDate.now()));
            beca.setInstitucion(institucion);
            beca.setTipoBeca(tipoBeca);
            beca.setUsuarioCreador(admin);
            beca.setRegiones(regionesSet);

            RequisitoPerfil rp = new RequisitoPerfil();
            rp.setBeca(beca);
            rp.setRshMaximoPorcentaje(rsh);
            rp.setNemMinimo(nem);
            beca.setRequisitoPerfil(rp);

            becaRepository.save(beca);
            becaRepository.flush();
            result.setCreadas(result.getCreadas() + 1);
        }
    }

    private LocalDate parseDate(String value, String fieldName, String rowName) {
        if (value == null || value.isBlank()) return null;
        for (String fmt : Arrays.asList("yyyy-MM-dd", "dd/MM/yyyy", "dd-MM-yyyy")) {
            try {
                return LocalDate.parse(value.trim(), DateTimeFormatter.ofPattern(fmt));
            } catch (DateTimeParseException ignored) {}
        }
        String msg = String.format("Formato de fecha no reconocido en '%s': '%s'", fieldName, value);
        log.warn("Fila [{}]: {}", rowName, msg);
        throw new IllegalArgumentException(msg);
    }

    private Integer parseOptionalInt(String value, String fieldName, String rowName, ImportResultDTO result) {
        if (value == null || value.isBlank()) return null;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            String msg = String.format("Valor no numérico en '%s': '%s' — se asignará null", fieldName, value);
            log.warn("Fila [{}]: {}", rowName, msg);
            result.getMensajesError().add("Fila '" + rowName + "': " + msg);
            return null;
        }
    }

    private BigDecimal parseOptionalBigDecimal(String value, String fieldName, String rowName, ImportResultDTO result) {
        if (value == null || value.isBlank()) return null;
        try {
            return new BigDecimal(value.trim());
        } catch (NumberFormatException e) {
            String msg = String.format("Valor no numérico en '%s': '%s' — se asignará null", fieldName, value);
            log.warn("Fila [{}]: {}", rowName, msg);
            result.getMensajesError().add("Fila '" + rowName + "': " + msg);
            return null;
        }
    }
}
