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
import com.becasfind.api.utils.JwtUtil;
import jakarta.persistence.EntityNotFoundException;
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

@Service
public class AuthServiceImpl implements AuthService {

    private static final Logger log = LoggerFactory.getLogger(AuthServiceImpl.class);

    private final AuthenticationManager authenticationManager;
    private final UsuarioRepository usuarioRepository;
    private final RolRepository rolRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    public AuthServiceImpl(AuthenticationManager authenticationManager,
                           UsuarioRepository usuarioRepository,
                           RolRepository rolRepository,
                           PasswordResetTokenRepository passwordResetTokenRepository,
                           PasswordEncoder passwordEncoder,
                           JwtUtil jwtUtil) {
        this.authenticationManager = authenticationManager;
        this.usuarioRepository = usuarioRepository;
        this.rolRepository = rolRepository;
        this.passwordResetTokenRepository = passwordResetTokenRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtUtil = jwtUtil;
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
        if (usuarioRepository.existsByEmail(request.getEmail())) {
            throw new IllegalArgumentException("El email ya esta registrado: " + request.getEmail());
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
        Usuario usuario = usuarioRepository.findByEmailAndActivoTrue(email)
                .orElseThrow(() -> new EntityNotFoundException("No se encontro un usuario activo con el email: " + email));

        passwordResetTokenRepository.deleteByUsuarioId(usuario.getIdUsuario());

        PasswordResetToken resetToken = new PasswordResetToken();
        resetToken.setToken(UUID.randomUUID().toString());
        resetToken.setUsuario(usuario);
        resetToken.setFechaExpiracion(LocalDateTime.now().plusMinutes(15));
        passwordResetTokenRepository.save(resetToken);

        log.info("Token de recuperacion generado para el usuario: {}. Token: {}", email, resetToken.getToken());
    }

    @Override
    @Transactional
    public void resetPassword(String token, String newPassword) {
        PasswordResetToken resetToken = passwordResetTokenRepository.findByToken(token)
                .orElseThrow(() -> new BadCredentialsException("Token de recuperacion invalido"));

        if (resetToken.getFechaExpiracion().isBefore(LocalDateTime.now())) {
            passwordResetTokenRepository.delete(resetToken);
            throw new BadCredentialsException("El token de recuperacion ha expirado");
        }

        Usuario usuario = resetToken.getUsuario();
        usuario.setPasswordHash(passwordEncoder.encode(newPassword));
        usuarioRepository.save(usuario);

        passwordResetTokenRepository.delete(resetToken);

        log.info("Contrasenia restablecida exitosamente para el usuario: {}", usuario.getEmail());
    }
}
