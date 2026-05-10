package com.becasfind.api.config;

import com.becasfind.api.models.entities.Usuario;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;

public class UserDetailsImpl implements UserDetails {

    private final Long idUsuario;
    private final String email;
    private final String password;
    private final String nombreCompleto;
    private final boolean activo;
    private final Collection<? extends GrantedAuthority> authorities;

    public UserDetailsImpl(Long idUsuario, String email, String password,
                           String nombreCompleto, boolean activo,
                           Collection<? extends GrantedAuthority> authorities) {
        this.idUsuario = idUsuario;
        this.email = email;
        this.password = password;
        this.nombreCompleto = nombreCompleto;
        this.activo = activo;
        this.authorities = authorities;
    }

    public static UserDetailsImpl fromUsuario(Usuario usuario) {
        String roleName = usuario.getRol().getNombreRol();
        Collection<GrantedAuthority> authorities = Collections.singletonList(
                new SimpleGrantedAuthority("ROLE_" + roleName)
        );

        return new UserDetailsImpl(
                usuario.getIdUsuario(),
                usuario.getEmail(),
                usuario.getPasswordHash(),
                usuario.getNombreCompleto(),
                usuario.getActivo(),
                authorities
        );
    }

    public Long getIdUsuario() {
        return idUsuario;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public String getRole() {
        if (authorities != null && !authorities.isEmpty()) {
            return authorities.iterator().next().getAuthority().replace("ROLE_", "");
        }
        return null;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return activo;
    }

    @Override
    public boolean isAccountNonLocked() {
        return activo;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return activo;
    }

    @Override
    public boolean isEnabled() {
        return activo;
    }
}
