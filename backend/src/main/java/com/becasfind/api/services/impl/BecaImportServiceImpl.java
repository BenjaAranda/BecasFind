package com.becasfind.api.services.impl;

import com.becasfind.api.models.dtos.CsvBecaRow;
import com.becasfind.api.models.dtos.CoberturaDTO;
import jakarta.validation.Validator;
import com.becasfind.api.models.dtos.ImportResultDTO;
import com.becasfind.api.models.entities.Beca;
import com.becasfind.api.models.entities.DocumentoRequerido;
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
import com.opencsv.CSVReader;
import com.opencsv.bean.CsvToBean;
import com.opencsv.bean.CsvToBeanBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.multipart.MultipartFile;

import java.io.StringReader;
import java.nio.ByteBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.CodingErrorAction;
import java.net.URI;

import java.math.BigDecimal;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.format.ResolverStyle;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Locale;
import java.util.Map;
import java.util.HashMap;
import org.springframework.jdbc.core.JdbcTemplate;

@Service
public class BecaImportServiceImpl implements BecaImportService {

    private static final Logger log = LoggerFactory.getLogger(BecaImportServiceImpl.class);
    private static final Set<String> CSV_COLUMNS = Set.of("nombre", "institucion", "tipo_beca", "monto",
            "fecha_inicio", "fecha_cierre", "rsh_maximo", "nem_minimo", "regiones", "descripcion", "descripcion_larga", "url");

    private static final Set<String> OPTIONAL_COLUMNS = Set.of("documentos_requeridos", "cobertura_tipo", "cobertura_importe", "cobertura_moneda", "cobertura_periodicidad", "cobertura_porcentaje", "estado_activa", "solo_crear");
    private final Validator validator;
    private final JdbcTemplate jdbc;
    @jakarta.persistence.PersistenceContext
    private jakarta.persistence.EntityManager entityManager;

    private final BecaRepository becaRepository;
    private final InstitucionRepository institucionRepository;
    private final TipoBecaRepository tipoBecaRepository;
    private final TipoInstitucionRepository tipoInstitucionRepository;
    private final RegionRepository regionRepository;
    private final UsuarioRepository usuarioRepository;
    private final TransactionTemplate importTransaction;

    public BecaImportServiceImpl(BecaRepository becaRepository,
                                  InstitucionRepository institucionRepository,
                                  TipoBecaRepository tipoBecaRepository,
                                  TipoInstitucionRepository tipoInstitucionRepository,
                                  RegionRepository regionRepository,
                                  UsuarioRepository usuarioRepository,
                                  PlatformTransactionManager transactionManager, Validator validator, JdbcTemplate jdbc) {
        this.validator = validator;
        this.jdbc = jdbc;
        this.becaRepository = becaRepository;
        this.institucionRepository = institucionRepository;
        this.tipoBecaRepository = tipoBecaRepository;
        this.tipoInstitucionRepository = tipoInstitucionRepository;
        this.regionRepository = regionRepository;
        this.usuarioRepository = usuarioRepository;
        this.importTransaction = new TransactionTemplate(transactionManager);
        this.importTransaction.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
    }

    @Override
    public ImportResultDTO importarDesdeCsv(MultipartFile file) {
        ImportResultDTO result = new ImportResultDTO();
        List<CsvBecaRow> rows;
        boolean replaceDocuments;
        boolean replaceCoverage;
        try {
            if (file.isEmpty() || file.getSize() > 10 * 1024 * 1024) {
                throw new IllegalArgumentException("El CSV debe contener datos y no superar 10 MB.");
            }
            byte[] bytes = file.getBytes();
            Charset charset = detectCharset(bytes);
            String content = charset.newDecoder().onMalformedInput(CodingErrorAction.REPORT)
                    .onUnmappableCharacter(CodingErrorAction.REPORT).decode(ByteBuffer.wrap(bytes)).toString();
            if (content.startsWith("\uFEFF")) content = content.substring(1);
            if (content.indexOf('\u0000') >= 0) throw new IllegalArgumentException("El CSV contiene bytes nulos. Usa UTF-8, no UTF-16.");
            if (content.matches("(?s).*([ÃÂ][\u0080-\u00BF\u2018-\u201F]|\uFFFD).*")) {
                throw new IllegalArgumentException("El CSV contiene texto con doble codificación. Corrige el archivo antes de importar.");
            }
            Set<String> headers = new HashSet<>();
            try (CSVReader headerReader = new CSVReader(new StringReader(content))) {
                String[] header = headerReader.readNext();
                if (header == null) throw new IllegalArgumentException("El CSV no contiene encabezados.");
                for (String field : header) {
                    if (!headers.add(field.trim().toLowerCase(Locale.ROOT))) {
                        throw new IllegalArgumentException("El CSV contiene encabezados duplicados.");
                    }
                }
            }
            if (!headers.containsAll(CSV_COLUMNS)) {
                throw new IllegalArgumentException("Faltan encabezados del formato CSV: nombre, institucion, tipo_beca, monto, fecha_inicio, fecha_cierre, rsh_maximo, nem_minimo, regiones, descripcion, descripcion_larga y url.");
            }
            if (headers.stream().anyMatch(header -> !CSV_COLUMNS.contains(header) && !OPTIONAL_COLUMNS.contains(header))) {
                throw new IllegalArgumentException("El CSV contiene columnas desconocidas. Revisa los encabezados.");
            }
            replaceDocuments = headers.contains("documentos_requeridos");
            replaceCoverage = headers.stream().anyMatch(header -> header.startsWith("cobertura_"));
            if (replaceCoverage && !headers.contains("cobertura_tipo")) throw new IllegalArgumentException("Los metadatos requieren cobertura_tipo.");
            try (StringReader reader = new StringReader(content)) {
                CsvToBean<CsvBecaRow> parser = new CsvToBeanBuilder<CsvBecaRow>(reader)
                        .withType(CsvBecaRow.class).withIgnoreLeadingWhiteSpace(true)
                        .withThrowExceptions(false).build();
                rows = parser.parse();
                for (var error : parser.getCapturedExceptions()) {
                    addError(result, "Línea " + error.getLineNumber() + ": campos obligatorios ausentes o columnas mal formadas.");
                }
            }
            if (rows.isEmpty()) addError(result, "No se detectaron filas válidas en el CSV.");
            if (rows.size() > 5000) throw new IllegalArgumentException("El CSV no puede superar 5000 filas por importación.");
            Set<String> keys = new HashSet<>();
            for (CsvBecaRow row : rows) {
                try {
                    validarCamposRequeridos(row);
                    if (replaceCoverage) coverage(row);
                    String key = row.getInstitucion().trim().toLowerCase(Locale.ROOT) + "\u0000" + row.getNombre().trim();
                    if (!keys.add(key)) throw new IllegalArgumentException("Beca e institución repetidas en el mismo archivo.");
                } catch (IllegalArgumentException e) {
                    addError(result, "Fila '" + row.getNombre() + "': " + e.getMessage());
                }
            }
        } catch (IllegalArgumentException e) {
            addError(result, e.getMessage());
            return result;
        } catch (Exception e) {
            addError(result, "No se pudo leer el CSV. Revisa las comillas, columnas y codificación del archivo.");
            return result;
        }
        if (result.getErrores() > 0) return result;

        try {
            // Counters are returned only after the complete transaction commits.
            return importTransaction.execute(status -> {
                // A database lock serializes catalog resolution across application instances.
                jdbc.queryForObject("select id_rol from roles where nombre_rol = 'ADMIN' for update", Long.class);
                ImportResultDTO committed = new ImportResultDTO();
                var authentication = SecurityContextHolder.getContext().getAuthentication();
                if (authentication == null) throw new IllegalArgumentException("La importación requiere un administrador autenticado.");
                Usuario admin = usuarioRepository.findByEmailAndActivoTrue(authentication.getName())
                        .orElseThrow(() -> new IllegalArgumentException("El administrador de la importación no está activo."));
                Map<String, Institucion> institutions = new HashMap<>();
                Map<String, TipoBeca> types = new HashMap<>();
                // Complete catalog writes before queueing scholarship inserts.
                for (CsvBecaRow row : rows) {
                    resolveInstitution(row.getInstitucion().trim(), institutions);
                    resolveType(row.getTipoBeca().trim(), types);
                }
                Map<String, Region> regions = new HashMap<>();
                regionRepository.findAll().forEach(region -> regions.put(region.getAbreviatura().toLowerCase(Locale.ROOT), region));
                Map<String, Beca> existing = new HashMap<>();
                becaRepository.findByNombreIn(rows.stream().map(row -> row.getNombre().trim()).toList()).forEach(beca -> existing.put(beca.getInstitucion().getIdInstitucion() + "\u0000" + beca.getNombre(), beca));
                for (int i = 0; i < rows.size(); i++) {
                    processRow(rows.get(i), committed, replaceDocuments, replaceCoverage, admin, institutions, types, regions, existing);
                    if ((i + 1) % 50 == 0) becaRepository.flush();
                }
                becaRepository.flush();
                return committed;
            });
        } catch (IllegalArgumentException e) {
            addError(result, e.getMessage());
        } catch (RuntimeException e) {
            log.warn("Importación CSV revertida por un error de persistencia ({})", e.getClass().getSimpleName());
            addError(result, "No se guardó ninguna fila. Error de persistencia; revisa el archivo o reintenta la importación.");
        }
        return result;
    }

    private void addError(ImportResultDTO result, String message) {
        result.setErrores(result.getErrores() + 1);
        result.getMensajesError().add(message);
    }

    private Charset detectCharset(byte[] bytes) {
        try {
            StandardCharsets.UTF_8.newDecoder().onMalformedInput(CodingErrorAction.REPORT)
                    .onUnmappableCharacter(CodingErrorAction.REPORT).decode(ByteBuffer.wrap(bytes));
            return StandardCharsets.UTF_8;
        } catch (CharacterCodingException e) {
            log.warn("CSV no es UTF-8 válido; se usa el fallback Windows-1252");
            return Charset.forName("Windows-1252");
        }
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
        validateLength(row.getNombre(), 255, "nombre");
        validateLength(row.getInstitucion(), 255, "institucion");
        validateLength(row.getTipoBeca(), 100, "tipo_beca");
        validateLength(row.getMonto(), 255, "monto");
        validateLength(row.getUrl(), 500, "url");
        if ((row.getUrl() == null || row.getUrl().isBlank()) && activeState(row.getEstadoActiva())) {
            throw new IllegalArgumentException("La URL oficial específica es obligatoria para una beca activa.");
        }
        activeState(row.getEstadoActiva());
        createOnly(row.getSoloCrear());
        Integer rsh = parseOptionalInt(row.getRshMaximo(), "rsh_maximo");
        if (rsh != null && (rsh < 0 || rsh > 100)) throw new IllegalArgumentException("rsh_maximo debe estar entre 0 y 100.");
        BigDecimal nem = parseOptionalBigDecimal(row.getNemMinimo(), "nem_minimo");
        if (nem != null && (nem.compareTo(BigDecimal.ONE) < 0 || nem.compareTo(BigDecimal.valueOf(7)) > 0
                || nem.stripTrailingZeros().scale() > 1)) {
            throw new IllegalArgumentException("nem_minimo debe estar entre 1 y 7 y admitir como máximo un decimal en el esquema actual.");
        }
        LocalDate cierre = parseDate(row.getFechaCierre(), "fecha_cierre", row.getNombre());
        LocalDate inicio = parseDate(row.getFechaInicio(), "fecha_inicio", row.getNombre());
        if (inicio != null && cierre != null && inicio.isAfter(cierre)) throw new IllegalArgumentException("fecha_inicio no puede ser posterior a fecha_cierre.");
        if (row.getUrl() != null && !row.getUrl().isBlank()) {
            URI uri;
            try { uri = URI.create(row.getUrl().trim()); }
            catch (IllegalArgumentException e) { throw new IllegalArgumentException("URL oficial inválida."); }
            if (!("https".equalsIgnoreCase(uri.getScheme()) || "http".equalsIgnoreCase(uri.getScheme()))
                    || uri.getHost() == null || uri.getUserInfo() != null
                    || ((uri.getPath() == null || uri.getPath().isBlank() || "/".equals(uri.getPath()))
                        && !hasPageIdentifier(uri))) {
                throw new IllegalArgumentException("La URL debe ser HTTP/HTTPS y apuntar a la subpágina específica de la beca.");
            }
        }
        if (row.getDocumentosRequeridos() != null && !row.getDocumentosRequeridos().isBlank()) {
            for (String item : row.getDocumentosRequeridos().split(";")) {
                String name = item.replaceAll("(?i)\\[(OBLIGATORIO|OPCIONAL)\\]", "").trim();
                if (!item.trim().matches("(?is)^\\[(OBLIGATORIO|OPCIONAL)\\].+") || name.isBlank()) {
                    throw new IllegalArgumentException("Cada documento debe incluir [OBLIGATORIO] o [OPCIONAL] y su nombre.");
                }
                validateLength(name, 255, "documentos_requeridos");
            }
        }
    }

    private boolean hasPageIdentifier(URI uri) {
        String query = uri.getRawQuery();
        if (query == null) return false;
        boolean found = false;
        for (String parameter : query.split("&")) {
            if (parameter.equals("page_id") || parameter.startsWith("page_id=")) {
                if (found || !parameter.matches("page_id=[1-9][0-9]*")) return false;
                found = true;
            }
        }
        return found;
    }

    private void validateLength(String value, int max, String field) {
        if (value != null && value.trim().length() > max) throw new IllegalArgumentException("El campo '" + field + "' supera " + max + " caracteres.");
    }

    private void processRow(CsvBecaRow row, ImportResultDTO result, boolean replaceDocuments, boolean replaceCoverage, Usuario admin, Map<String, Institucion> institutions, Map<String, TipoBeca> types, Map<String, Region> regions, Map<String, Beca> existing) {
        Institucion institucion = institutions.get(row.getInstitucion().trim().toLowerCase(Locale.ROOT));
        TipoBeca tipoBeca = types.get(row.getTipoBeca().trim().toLowerCase(Locale.ROOT));

        Set<Region> regionesSet = new HashSet<>();
        if (row.getRegiones() != null && !row.getRegiones().isBlank()) {
            for (String abrev : row.getRegiones().split(",")) {
                String abrevTrimmed = abrev.trim();
                var regionOpt = java.util.Optional.ofNullable(regions.get(abrevTrimmed.toLowerCase(Locale.ROOT)));
                if (regionOpt.isPresent()) {
                    regionesSet.add(regionOpt.get());
                } else {
                    throw new IllegalArgumentException("Fila '" + row.getNombre() + "': región no encontrada - '" + abrevTrimmed + "'. No se importó ninguna fila.");
                }
            }
        }

        LocalDate fechaCierre = parseDate(row.getFechaCierre(), "fecha_cierre", row.getNombre());
        LocalDate fechaInicio = parseDate(row.getFechaInicio(), "fecha_inicio", row.getNombre());

        Integer rsh = parseOptionalInt(row.getRshMaximo(), "rsh_maximo");
        BigDecimal nem = parseOptionalBigDecimal(row.getNemMinimo(), "nem_minimo");

        var becaExistente = java.util.Optional.ofNullable(existing.get(institucion.getIdInstitucion() + "\u0000" + row.getNombre().trim()));

        if (becaExistente.isPresent()) {
            if (createOnly(row.getSoloCrear())) {
                result.setOmitidas(result.getOmitidas() + 1);
                return;
            }
            Beca beca = becaExistente.get();
            entityManager.lock(beca, jakarta.persistence.LockModeType.PESSIMISTIC_FORCE_INCREMENT);
            beca.setNombre(row.getNombre().trim());
            if (row.getEstadoActiva() != null && !row.getEstadoActiva().isBlank()) {
                beca.setEstadoActiva(activeState(row.getEstadoActiva()));
            }
            beca.setMontoCobertura(row.getMonto());
            if (replaceCoverage) applyCoverage(beca, coverage(row));
            beca.setFechaInicioPostulacion(fechaInicio);
            beca.setFechaCierrePostulacion(fechaCierre);
            beca.setUrlOficial(row.getUrl());
            beca.setDescripcionCorta(row.getDescripcion());
            beca.setDescripcionLarga(row.getDescripcionLarga());
            beca.setRegiones(regionesSet);
            beca.setTipoBeca(tipoBeca);

            if (beca.getRequisitoPerfil() == null) {
                RequisitoPerfil rp = new RequisitoPerfil();
                rp.setBeca(beca);
                beca.setRequisitoPerfil(rp);
            }
            RequisitoPerfil rp = beca.getRequisitoPerfil();
            rp.setRshMaximoPorcentaje(rsh);
            rp.setNemMinimo(nem);

            becaRepository.save(beca);
            importDocumentos(beca, row, replaceDocuments);
            result.setActualizadas(result.getActualizadas() + 1);
        } else {
            Beca beca = new Beca();
            beca.setNombre(row.getNombre().trim());
            beca.setDescripcionCorta(row.getDescripcion());
            beca.setDescripcionLarga(row.getDescripcionLarga());
            beca.setMontoCobertura(row.getMonto());
            if (replaceCoverage) applyCoverage(beca, coverage(row));
            beca.setFechaInicioPostulacion(fechaInicio);
            beca.setFechaCierrePostulacion(fechaCierre);
            beca.setUrlOficial(row.getUrl());
            beca.setEstadoActiva(activeState(row.getEstadoActiva()));
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
            importDocumentos(beca, row, replaceDocuments);
            result.setCreadas(result.getCreadas() + 1);
        }
    }

    private Institucion resolveInstitution(String name, Map<String, Institucion> cache) {
        return cache.computeIfAbsent(name.toLowerCase(Locale.ROOT), ignored -> institucionRepository.findByNombreIgnoreCase(name).orElseGet(() -> {
            Institucion institution = new Institucion();
            institution.setNombre(name);
            institution.setRut("IMP-" + java.util.UUID.randomUUID().toString().substring(0, 8));
            institution.setTipoInstitucion(clasificarTipoInstitucion(name));
            return institucionRepository.save(institution);
        }));
    }

    private boolean activeState(String value) {
        if (value == null || value.isBlank() || "true".equalsIgnoreCase(value.trim())) return true;
        if ("false".equalsIgnoreCase(value.trim())) return false;
        throw new IllegalArgumentException("estado_activa debe ser true o false.");
    }

    private boolean createOnly(String value) {
        if (value == null || value.isBlank() || "false".equalsIgnoreCase(value.trim())) return false;
        if ("true".equalsIgnoreCase(value.trim())) return true;
        throw new IllegalArgumentException("solo_crear debe ser true o false.");
    }

    private TipoBeca resolveType(String name, Map<String, TipoBeca> cache) {
        return cache.computeIfAbsent(name.toLowerCase(Locale.ROOT), ignored -> tipoBecaRepository.findByNombreIgnoreCase(name).orElseGet(() -> {
            TipoBeca type = new TipoBeca();
            type.setNombre(name);
            return tipoBecaRepository.save(type);
        }));
    }

    private String optionalText(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    private CoberturaDTO coverage(CsvBecaRow row) {
        CoberturaDTO dto = new CoberturaDTO();
        String tipo = optionalText(row.getCoberturaTipo());
        dto.setTipo(tipo == null ? "DESCONOCIDA" : tipo);
        dto.setImporte(parseOptionalBigDecimal(row.getCoberturaImporte(), "cobertura_importe"));
        dto.setMoneda(optionalText(row.getCoberturaMoneda()));
        dto.setPeriodicidad(optionalText(row.getCoberturaPeriodicidad()));
        dto.setPorcentaje(parseOptionalBigDecimal(row.getCoberturaPorcentaje(), "cobertura_porcentaje"));
        if (!validator.validate(dto).isEmpty()) throw new IllegalArgumentException("Metadatos de cobertura inválidos: revisa tipo, precisión, moneda y campos incompatibles.");
        return dto;
    }

    private void applyCoverage(Beca beca, CoberturaDTO dto) {
        beca.setCoberturaTipo(dto.getTipo());
        beca.setCoberturaImporte(dto.getImporte());
        beca.setCoberturaMoneda(dto.getMoneda());
        beca.setCoberturaPeriodicidad(dto.getPeriodicidad());
        beca.setCoberturaPorcentaje(dto.getPorcentaje());
    }

    private void importDocumentos(Beca beca, CsvBecaRow row, boolean replaceDocuments) {
        if (!replaceDocuments) return;
        beca.getDocumentosRequeridos().clear();
        if (row.getDocumentosRequeridos() == null || row.getDocumentosRequeridos().isBlank()) return;
        String[] items = row.getDocumentosRequeridos().split(";");
        for (String item : items) {
            item = item.trim();
            if (item.isEmpty()) continue;
            boolean obligatorio = item.toUpperCase(Locale.ROOT).contains("[OBLIGATORIO]");
            String nombre = item.replaceAll("(?i)\\[(OBLIGATORIO|OPCIONAL)\\]", "").trim();
            if (nombre.isEmpty()) continue;
            DocumentoRequerido doc = new DocumentoRequerido();
            doc.setBeca(beca);
            doc.setNombreDocumento(nombre);
            doc.setEsObligatorio(obligatorio);
            beca.getDocumentosRequeridos().add(doc);
        }
    }

    private LocalDate parseDate(String value, String fieldName, String rowName) {
        if (value == null || value.isBlank()) return null;
        for (String fmt : Arrays.asList("uuuu-MM-dd", "dd/MM/uuuu", "dd-MM-uuuu")) {
            try {
                return LocalDate.parse(value.trim(), DateTimeFormatter.ofPattern(fmt).withResolverStyle(ResolverStyle.STRICT));
            } catch (DateTimeParseException ignored) {}
        }
        String msg = String.format("Formato de fecha no reconocido en '%s': '%s'", fieldName, value);
        log.warn("Fila [{}]: {}", rowName, msg);
        throw new IllegalArgumentException(msg);
    }

    private Integer parseOptionalInt(String value, String fieldName) {
        if (value == null || value.isBlank()) return null;
        try { return Integer.parseInt(value.trim()); }
        catch (NumberFormatException e) { throw new IllegalArgumentException("Valor no numérico en '" + fieldName + "'."); }
    }

    private BigDecimal parseOptionalBigDecimal(String value, String fieldName) {
        if (value == null || value.isBlank()) return null;
        try { return new BigDecimal(value.trim()); }
        catch (NumberFormatException e) { throw new IllegalArgumentException("Valor no numérico en '" + fieldName + "'."); }
    }

    private TipoInstitucion clasificarTipoInstitucion(String nombreInstitucion) {
        String tipoStr = "Universidad";
        String nombreUpper = nombreInstitucion.toUpperCase(Locale.ROOT);

        if (nombreUpper.contains("MUNICIPALIDAD")) {
            tipoStr = "Municipal";
        } else if (nombreUpper.contains("MINEDUC") || nombreUpper.contains("JUNAEB") || nombreUpper.contains("MINISTERIO")) {
            tipoStr = "Organismo Gubernamental";
        } else if (nombreUpper.contains("DUOC") || nombreUpper.contains("AIEP") || nombreUpper.contains("IP ") || nombreUpper.contains("INSTITUTO PROFESIONAL") || nombreUpper.contains("SANTO TOM") || nombreUpper.contains("INACAP")) {
            tipoStr = "Instituto Profesional";
        } else if (nombreUpper.contains("CFT") || nombreUpper.contains("ENAC") || nombreUpper.contains("CENTRO DE FORMACI")) {
            tipoStr = "Centro de Formación Técnica";
        }

        final String finalTipoStr = tipoStr;
        return tipoInstitucionRepository.findByNombreIgnoreCase(tipoStr)
                .orElseGet(() -> {
                    TipoInstitucion nuevo = new TipoInstitucion();
                    nuevo.setNombre(finalTipoStr);
                    return tipoInstitucionRepository.save(nuevo);
                });
    }
}
