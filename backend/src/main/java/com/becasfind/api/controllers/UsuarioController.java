package com.becasfind.api.controllers;

import com.becasfind.api.models.dtos.ApiResponse;
import com.becasfind.api.models.dtos.UsuarioDTO;
import com.becasfind.api.models.dtos.UsuarioRequest;
import com.becasfind.api.models.dtos.UsuarioUpdateRequest;
import com.becasfind.api.services.CustomUserDetailsService;
import com.becasfind.api.services.UsuarioService;
import jakarta.validation.Valid;
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
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    private final UsuarioService usuarioService;
    private final CustomUserDetailsService customUserDetailsService;

    public UsuarioController(UsuarioService usuarioService, CustomUserDetailsService customUserDetailsService) {
        this.usuarioService = usuarioService;
        this.customUserDetailsService = customUserDetailsService;
    }

    @GetMapping("/me")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<UsuarioDTO>> me(Principal principal) {
        var userDetails = customUserDetailsService.loadUserByEmail(principal.getName());
        UsuarioDTO dto = UsuarioDTO.builder()
                .idUsuario(userDetails.getIdUsuario())
                .email(userDetails.getUsername())
                .nombreCompleto(userDetails.getNombreCompleto())
                .rol(userDetails.getRole())
                .activo(userDetails.isEnabled())
                .build();
        return ResponseEntity.ok(ApiResponse.success(dto, "Perfil recuperado exitosamente"));
    }

    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<List<UsuarioDTO>>> findAll() {
        List<UsuarioDTO> usuarios = usuarioService.findAll();
        return ResponseEntity.ok(ApiResponse.success(usuarios, "Usuarios recuperados exitosamente"));
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<UsuarioDTO>> findById(@PathVariable Long id) {
        UsuarioDTO usuario = usuarioService.findById(id);
        return ResponseEntity.ok(ApiResponse.success(usuario, "Usuario encontrado exitosamente"));
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<UsuarioDTO>> create(@Valid @RequestBody UsuarioRequest request) {
        UsuarioDTO usuario = usuarioService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(usuario, "Usuario creado exitosamente"));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<UsuarioDTO>> update(@PathVariable Long id, @Valid @RequestBody UsuarioUpdateRequest request) {
        UsuarioDTO usuario = usuarioService.update(id, request);
        return ResponseEntity.ok(ApiResponse.success(usuario, "Usuario actualizado exitosamente"));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Void>> deactivate(@PathVariable Long id) {
        usuarioService.deactivate(id);
        return ResponseEntity.ok(ApiResponse.success(null, "Usuario desactivado exitosamente"));
    }
}
