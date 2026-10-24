package com.becasfind.api.controllers;

import com.becasfind.api.models.dtos.ApiResponse;
import com.becasfind.api.models.dtos.AuthResponse;
import com.becasfind.api.models.dtos.ForgotPasswordRequest;
import com.becasfind.api.models.dtos.LoginRequest;
import com.becasfind.api.models.dtos.RegisterRequest;
import com.becasfind.api.models.dtos.ResetPasswordRequest;
import com.becasfind.api.services.AuthService;
import com.becasfind.api.exceptions.EmailDeliveryException;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(AuthController.class);

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<AuthResponse>> login(@Valid @RequestBody LoginRequest request) {
        AuthResponse authResponse = authService.login(request);
        return ResponseEntity.ok(ApiResponse.success(authResponse, "Inicio de sesion exitoso"));
    }

    @PostMapping("/register")
    public ResponseEntity<ApiResponse<AuthResponse>> register(@Valid @RequestBody RegisterRequest request) {
        AuthResponse authResponse = authService.register(request);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.created(authResponse, "Registro exitoso"));
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<ApiResponse<Void>> forgotPassword(@Valid @RequestBody ForgotPasswordRequest request) {
        try {
            authService.forgotPassword(request.getEmail());
        } catch (EmailDeliveryException exception) {
            // La transacción ya se revirtió: conservar el enlace anterior sin revelar si existe la cuenta.
            log.warn("Fallo de entrega de recuperación; revisar configuración y disponibilidad del proveedor");
        }
        return ResponseEntity.ok(ApiResponse.success(null,
                "Si el correo está registrado, recibirás un enlace de recuperación"));
    }

    @PostMapping("/reset-password")
    public ResponseEntity<ApiResponse<Void>> resetPassword(@Valid @RequestBody ResetPasswordRequest request) {
        authService.resetPassword(request.getToken(), request.getNewPassword());
        return ResponseEntity.ok(ApiResponse.success(null, "Contraseña restablecida exitosamente"));
    }
}
