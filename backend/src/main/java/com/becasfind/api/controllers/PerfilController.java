package com.becasfind.api.controllers;

import com.becasfind.api.models.dtos.ApiResponse;
import com.becasfind.api.models.dtos.PerfilEstudianteDTO;
import com.becasfind.api.models.dtos.PerfilEstudianteRequest;
import com.becasfind.api.services.PerfilService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
@RequestMapping("/api/perfil")
public class PerfilController {

    private final PerfilService perfilService;

    public PerfilController(PerfilService perfilService) {
        this.perfilService = perfilService;
    }

    @GetMapping
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<PerfilEstudianteDTO>> getPerfil(Principal principal) {
        PerfilEstudianteDTO perfil = perfilService.getPerfil(principal.getName());
        if (perfil == null) {
            return ResponseEntity.ok(ApiResponse.success(null, "Perfil no configurado aun"));
        }
        return ResponseEntity.ok(ApiResponse.success(perfil, "Perfil recuperado exitosamente"));
    }

    @PutMapping
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<PerfilEstudianteDTO>> savePerfil(@Valid @RequestBody PerfilEstudianteRequest request, Principal principal) {
        PerfilEstudianteDTO perfil = perfilService.savePerfil(principal.getName(), request);
        return ResponseEntity.ok(ApiResponse.success(perfil, "Perfil guardado exitosamente"));
    }
}
