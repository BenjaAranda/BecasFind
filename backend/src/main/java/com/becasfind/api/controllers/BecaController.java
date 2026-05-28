package com.becasfind.api.controllers;

import com.becasfind.api.models.dtos.ApiResponse;
import com.becasfind.api.models.dtos.BecaDTO;
import com.becasfind.api.models.dtos.BecaDetailDTO;
import com.becasfind.api.models.dtos.BecaRequest;
import com.becasfind.api.models.dtos.BecaSearchRequest;
import com.becasfind.api.models.dtos.ImportResultDTO;
import com.becasfind.api.services.BecaImportService;
import com.becasfind.api.services.BecaService;
import com.becasfind.api.services.CustomUserDetailsService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;

@RestController
@RequestMapping("/api/becas")
public class BecaController {

    private final BecaService becaService;
    private final BecaImportService becaImportService;
    private final CustomUserDetailsService customUserDetailsService;

    public BecaController(BecaService becaService,
                          BecaImportService becaImportService,
                          CustomUserDetailsService customUserDetailsService) {
        this.becaService = becaService;
        this.becaImportService = becaImportService;
        this.customUserDetailsService = customUserDetailsService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<BecaDTO>>> findAll(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        PageRequest pageable = PageRequest.of(page, size, Sort.by("fechaCierrePostulacion").ascending());
        Page<BecaDTO> becas = becaService.buscarBecas(null, null, null, null, null, null, null, null, pageable);
        return ResponseEntity.ok(ApiResponse.success(becas, "Becas recuperadas exitosamente"));
    }

    @GetMapping("/recomendadas")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<Page<BecaDTO>>> recomendar(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Principal principal) {
        PageRequest pageable = PageRequest.of(page, size, Sort.by("fechaCierrePostulacion").ascending());
        Page<BecaDTO> becas = becaService.recomendarBecas(principal.getName(), pageable);
        return ResponseEntity.ok(ApiResponse.success(becas, "Becas recomendadas para tu perfil"));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<BecaDetailDTO>> findById(@PathVariable Long id) {
        BecaDetailDTO beca = becaService.findById(id);
        return ResponseEntity.ok(ApiResponse.success(beca, "Beca encontrada exitosamente"));
    }

    @PostMapping("/buscar")
    public ResponseEntity<ApiResponse<Page<BecaDTO>>> buscar(@Valid @RequestBody BecaSearchRequest request) {
        PageRequest pageable = PageRequest.of(
                request.getPage() != null ? request.getPage() : 0,
                request.getSize() != null ? request.getSize() : 10
        );
        Page<BecaDTO> becas = becaService.buscarBecas(
                request.getRsh(),
                request.getNem(),
                request.getRegionId() != null ? request.getRegionId().longValue() : null,
                request.getQuery(),
                request.getIdTipoBeca(),
                request.getIdInstitucion(),
                request.getIdTipoInstitucion(),
                request.getSort(),
                pageable
        );
        return ResponseEntity.ok(ApiResponse.success(becas, "Busqueda completada exitosamente"));
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<BecaDTO>> create(@Valid @RequestBody BecaRequest request, Principal principal) {
        var userDetails = customUserDetailsService.loadUserByEmail(principal.getName());
        BecaDTO beca = becaService.create(userDetails.getIdUsuario(), request);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(beca, "Beca creada exitosamente"));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<BecaDTO>> update(@PathVariable Long id, @Valid @RequestBody BecaRequest request) {
        BecaDTO beca = becaService.update(id, request);
        return ResponseEntity.ok(ApiResponse.success(beca, "Beca actualizada exitosamente"));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable Long id) {
        becaService.delete(id);
        return ResponseEntity.ok(ApiResponse.success(null, "Beca eliminada exitosamente"));
    }

    @PostMapping("/importar-csv")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<ImportResultDTO>> importarCsv(@RequestParam("file") MultipartFile file) {
        ImportResultDTO result = becaImportService.importarDesdeCsv(file);
        return ResponseEntity.ok(ApiResponse.success(result,
                "Importacion completada: " + result.getCreadas() + " creadas, " +
                result.getActualizadas() + " actualizadas, " + result.getErrores() + " errores"));
    }
}
