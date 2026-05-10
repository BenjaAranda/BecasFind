package com.becasfind.api.controllers;

import com.becasfind.api.models.dtos.ApiResponse;
import com.becasfind.api.models.dtos.ComunaDTO;
import com.becasfind.api.models.dtos.InstitucionDTO;
import com.becasfind.api.models.dtos.RegionDTO;
import com.becasfind.api.models.dtos.TipoBecaDTO;
import com.becasfind.api.models.dtos.TipoInstitucionDTO;
import com.becasfind.api.services.CatalogoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class CatalogoController {

    private final CatalogoService catalogoService;

    public CatalogoController(CatalogoService catalogoService) {
        this.catalogoService = catalogoService;
    }

    @GetMapping("/regiones")
    public ResponseEntity<ApiResponse<List<RegionDTO>>> findAllRegiones() {
        List<RegionDTO> regiones = catalogoService.findAllRegiones();
        return ResponseEntity.ok(ApiResponse.success(regiones, "Regiones recuperadas exitosamente"));
    }

    @GetMapping("/comunas/region/{regionId}")
    public ResponseEntity<ApiResponse<List<ComunaDTO>>> findComunasByRegion(@PathVariable Long regionId) {
        List<ComunaDTO> comunas = catalogoService.findComunasByRegion(regionId);
        return ResponseEntity.ok(ApiResponse.success(comunas, "Comunas recuperadas exitosamente"));
    }

    @GetMapping("/tipos-beca")
    public ResponseEntity<ApiResponse<List<TipoBecaDTO>>> findAllTiposBeca() {
        List<TipoBecaDTO> tipos = catalogoService.findAllTiposBeca();
        return ResponseEntity.ok(ApiResponse.success(tipos, "Tipos de beca recuperados exitosamente"));
    }

    @GetMapping("/tipos-institucion")
    public ResponseEntity<ApiResponse<List<TipoInstitucionDTO>>> findAllTiposInstitucion() {
        List<TipoInstitucionDTO> tipos = catalogoService.findAllTiposInstitucion();
        return ResponseEntity.ok(ApiResponse.success(tipos, "Tipos de institucion recuperados exitosamente"));
    }

    @GetMapping("/instituciones")
    public ResponseEntity<ApiResponse<List<InstitucionDTO>>> findAllInstituciones() {
        List<InstitucionDTO> instituciones = catalogoService.findAllInstituciones();
        return ResponseEntity.ok(ApiResponse.success(instituciones, "Instituciones recuperadas exitosamente"));
    }
}
