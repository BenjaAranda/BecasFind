package com.becasfind.api.controllers;

import com.becasfind.api.models.dtos.ApiResponse;
import com.becasfind.api.models.dtos.BecaDTO;
import com.becasfind.api.services.FavoritoService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/api/favoritos")
public class FavoritoController {

    private final FavoritoService favoritoService;

    public FavoritoController(FavoritoService favoritoService) {
        this.favoritoService = favoritoService;
    }

    @GetMapping
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<List<BecaDTO>>> listar(Principal principal) {
        List<BecaDTO> favoritos = favoritoService.listar(principal.getName());
        return ResponseEntity.ok(ApiResponse.success(favoritos, "Favoritos recuperados exitosamente"));
    }

    @PostMapping("/{idBeca}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<Void>> guardar(@PathVariable Long idBeca, Principal principal) {
        favoritoService.guardar(principal.getName(), idBeca);
        return ResponseEntity.ok(ApiResponse.success(null, "Beca guardada en favoritos"));
    }

    @DeleteMapping("/{idBeca}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<Void>> eliminar(@PathVariable Long idBeca, Principal principal) {
        favoritoService.eliminar(principal.getName(), idBeca);
        return ResponseEntity.ok(ApiResponse.success(null, "Beca eliminada de favoritos"));
    }

    @GetMapping("/{idBeca}/check")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<java.util.Map<String, Boolean>>> check(@PathVariable Long idBeca, Principal principal) {
        boolean esFavorito = favoritoService.isFavorito(principal.getName(), idBeca);
        return ResponseEntity.ok(ApiResponse.success(
                java.util.Map.of("favorito", esFavorito),
                "Estado de favorito consultado"
        ));
    }
}
