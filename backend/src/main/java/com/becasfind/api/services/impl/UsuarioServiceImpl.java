package com.becasfind.api.services.impl;

import com.becasfind.api.models.dtos.UsuarioDTO;
import com.becasfind.api.models.dtos.UsuarioRequest;
import com.becasfind.api.models.dtos.UsuarioUpdateRequest;
import com.becasfind.api.models.entities.Rol;
import com.becasfind.api.models.entities.Usuario;
import com.becasfind.api.repositories.RolRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.services.UsuarioService;
import jakarta.persistence.EntityNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    private static final Logger log = LoggerFactory.getLogger(UsuarioServiceImpl.class);

    private final UsuarioRepository usuarioRepository;
    private final RolRepository rolRepository;
    private final PasswordEncoder passwordEncoder;

    public UsuarioServiceImpl(UsuarioRepository usuarioRepository,
                              RolRepository rolRepository,
                              PasswordEncoder passwordEncoder) {
        this.usuarioRepository = usuarioRepository;
        this.rolRepository = rolRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional(readOnly = true)
    public List<UsuarioDTO> findAll() {
        return usuarioRepository.findAll().stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public UsuarioDTO findById(Long id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con ID: " + id));
        return toDTO(usuario);
    }

    @Override
    @Transactional
    public UsuarioDTO create(UsuarioRequest request) {
        if (usuarioRepository.existsByEmail(request.getEmail())) {
            throw new IllegalArgumentException("El email ya esta registrado: " + request.getEmail());
        }

        Rol rol = rolRepository.findById(request.getIdRol())
                .orElseThrow(() -> new EntityNotFoundException("Rol no encontrado con ID: " + request.getIdRol()));

        Usuario usuario = new Usuario();
        usuario.setEmail(request.getEmail());
        usuario.setPasswordHash(passwordEncoder.encode(request.getPassword()));
        usuario.setNombreCompleto(request.getNombreCompleto());
        usuario.setRol(rol);
        usuario.setActivo(true);

        usuario = usuarioRepository.save(usuario);
        log.info("Usuario creado: {} con rol {}", usuario.getEmail(), rol.getNombreRol());
        return toDTO(usuario);
    }

    @Override
    @Transactional
    public UsuarioDTO update(Long id, UsuarioUpdateRequest request) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con ID: " + id));

        if (!usuario.getEmail().equals(request.getEmail()) && usuarioRepository.existsByEmail(request.getEmail())) {
            throw new IllegalArgumentException("El email ya esta en uso: " + request.getEmail());
        }

        usuario.setEmail(request.getEmail());
        usuario.setNombreCompleto(request.getNombreCompleto());

        usuario = usuarioRepository.save(usuario);
        log.info("Usuario actualizado: {}", usuario.getEmail());
        return toDTO(usuario);
    }

    @Override
    @Transactional
    public void deactivate(Long id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con ID: " + id));

        usuario.setActivo(false);
        usuarioRepository.save(usuario);
        log.info("Usuario desactivado: {}", usuario.getEmail());
    }

    private UsuarioDTO toDTO(Usuario usuario) {
        return UsuarioDTO.builder()
                .idUsuario(usuario.getIdUsuario())
                .email(usuario.getEmail())
                .nombreCompleto(usuario.getNombreCompleto())
                .rol(usuario.getRol() != null ? usuario.getRol().getNombreRol() : null)
                .activo(usuario.getActivo())
                .creadoEn(usuario.getCreadoEn())
                .build();
    }
}
