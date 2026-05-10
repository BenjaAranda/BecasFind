package com.becasfind.api.services.impl;

import com.becasfind.api.config.UserDetailsImpl;
import com.becasfind.api.models.entities.Usuario;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.services.CustomUserDetailsService;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CustomUserDetailsServiceImpl implements CustomUserDetailsService {

    private final UsuarioRepository usuarioRepository;

    public CustomUserDetailsServiceImpl(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByEmailAndActivoTrue(email)
                .orElseThrow(() -> new UsernameNotFoundException(
                        "Usuario no encontrado con email: " + email));

        return UserDetailsImpl.fromUsuario(usuario);
    }

    @Override
    @Transactional(readOnly = true)
    public UserDetailsImpl loadUserByEmail(String email) {
        Usuario usuario = usuarioRepository.findByEmailAndActivoTrue(email)
                .orElseThrow(() -> new UsernameNotFoundException(
                        "Usuario no encontrado con email: " + email));

        return UserDetailsImpl.fromUsuario(usuario);
    }
}
