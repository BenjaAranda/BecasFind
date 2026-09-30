package com.becasfind.api.services.impl;

import com.becasfind.api.config.UserDetailsImpl;
import com.becasfind.api.models.dtos.AuthResponse;
import com.becasfind.api.models.dtos.LoginRequest;
import com.becasfind.api.models.dtos.RegisterRequest;
import com.becasfind.api.models.entities.PasswordResetToken;
import com.becasfind.api.models.entities.Rol;
import com.becasfind.api.models.entities.Usuario;
import com.becasfind.api.repositories.PasswordResetTokenRepository;
import com.becasfind.api.repositories.RolRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.services.AuthService;
import com.becasfind.api.services.ResetEmailService;
import com.becasfind.api.utils.JwtUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;
import java.nio.charset.StandardCharsets;
import com.becasfind.api.exceptions.BusinessException;

@Service
public class AuthServiceImpl implements AuthService {

    private static final Logger log = LoggerFactory.getLogger(AuthServiceImpl.class);

    private final AuthenticationManager authenticationManager;
    private final UsuarioRepository usuarioRepository;
    private final RolRepository rolRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;
    private final ResetEmailService resetEmailService;

    public AuthServiceImpl(AuthenticationManager authenticationManager,
                           UsuarioRepository usuarioRepository,
                           RolRepository rolRepository,
                           PasswordResetTokenRepository passwordResetTokenRepository,
                           PasswordEncoder passwordEncoder,
                           JwtUtil jwtUtil, ResetEmailService resetEmailService) {
        this.authenticationManager = authenticationManager;
        this.usuarioRepository = usuarioRepository;
        this.rolRepository = rolRepository;
        this.passwordResetTokenRepository = passwordResetTokenRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtUtil = jwtUtil;
        this.resetEmailService = resetEmailService;
    }

    @Override
    public AuthResponse login(LoginRequest request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword())
        );

        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        String token = jwtUtil.generateToken(
                userDetails.getUsername(),
                userDetails.getRole(),
                userDetails.getNombreCompleto()
        );

        return AuthResponse.builder()
                .token(token)
                .tokenType("Bearer")
                .nombreRol(userDetails.getRole())
                .nombreCompleto(userDetails.getNombreCompleto())
                .email(userDetails.getUsername())
                .build();
    }

    @Override
    @Transactional
    public AuthResponse register(RegisterRequest request) {
        validatePasswordBytes(request.getPassword());
        if (usuarioRepository.existsByEmail(request.getEmail())) {
            throw new IllegalArgumentException("El email ya está registrado");
        }

        Rol rolStudent = rolRepository.findByNombreRol("STUDENT")
                .orElseThrow(() -> new IllegalStateException("Rol STUDENT no encontrado en la base de datos"));

        Usuario usuario = new Usuario();
        usuario.setEmail(request.getEmail());
        usuario.setPasswordHash(passwordEncoder.encode(request.getPassword()));
        usuario.setNombreCompleto(request.getNombreCompleto());
        usuario.setRol(rolStudent);
        usuario.setActivo(true);

        usuario = usuarioRepository.save(usuario);
        log.info("Nuevo usuario registrado: {}", usuario.getEmail());

        String token = jwtUtil.generateToken(
                usuario.getEmail(),
                rolStudent.getNombreRol(),
                usuario.getNombreCompleto()
        );

        return AuthResponse.builder()
                .token(token)
                .tokenType("Bearer")
                .nombreRol(rolStudent.getNombreRol())
                .nombreCompleto(usuario.getNombreCompleto())
                .email(usuario.getEmail())
                .build();
    }

    @Override
    @Transactional
    public void forgotPassword(String email) {
        resetEmailService.requireConfigured();
        Usuario usuario = usuarioRepository.findByEmailAndActivoTrue(email).orElse(null);
        if (usuario == null) {
            return;
        }

        passwordResetTokenRepository.deleteByUsuarioId(usuario.getIdUsuario());

        PasswordResetToken resetToken = new PasswordResetToken();
        resetToken.setToken(UUID.randomUUID().toString());
        resetToken.setUsuario(usuario);
        resetToken.setFechaExpiracion(LocalDateTime.now().plusMinutes(15));
        passwordResetTokenRepository.saveAndFlush(resetToken);
        resetEmailService.sendPasswordReset(usuario.getEmail(), resetToken.getToken());

    }

    @Override
    @Transactional(noRollbackFor = BadCredentialsException.class)
    public void resetPassword(String token, String newPassword) {
        validatePasswordBytes(newPassword);
        PasswordResetToken resetToken = passwordResetTokenRepository.findByToken(token)
                .orElseThrow(() -> new BadCredentialsException("Token de recuperación inválido"));

        if (!resetToken.getFechaExpiracion().isAfter(LocalDateTime.now())) {
            passwordResetTokenRepository.delete(resetToken);
            throw new BadCredentialsException("El token de recuperación ha expirado");
        }

        Usuario usuario = usuarioRepository.findById(resetToken.getUsuario().getIdUsuario()).orElse(null);
        if (usuario == null || !Boolean.TRUE.equals(usuario.getActivo())) {
            passwordResetTokenRepository.delete(resetToken);
            throw new BadCredentialsException("Token de recuperación inválido");
        }
        usuario.setPasswordHash(passwordEncoder.encode(newPassword));
        usuarioRepository.save(usuario);

        passwordResetTokenRepository.delete(resetToken);

        log.info("Contraseña restablecida exitosamente");
    }

    private static void validatePasswordBytes(String password) {
        if (password.getBytes(StandardCharsets.UTF_8).length > 72) {
            throw new BusinessException("La contraseña es demasiado larga. Usa como máximo 72 bytes UTF-8.");
        }
    }
}
