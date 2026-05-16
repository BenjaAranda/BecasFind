package com.becasfind.api.services;

import com.becasfind.api.models.dtos.AuthResponse;
import com.becasfind.api.models.dtos.LoginRequest;
import com.becasfind.api.models.dtos.RegisterRequest;

public interface AuthService {

    AuthResponse login(LoginRequest request);

    AuthResponse register(RegisterRequest request);

    void forgotPassword(String email);

    void resetPassword(String token, String newPassword);
}
