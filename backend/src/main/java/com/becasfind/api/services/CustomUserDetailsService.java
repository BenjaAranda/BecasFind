package com.becasfind.api.services;

import com.becasfind.api.config.UserDetailsImpl;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface CustomUserDetailsService extends UserDetailsService {

    UserDetailsImpl loadUserByEmail(String email);
}
