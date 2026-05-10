package com.becasfind.api.services;

import com.becasfind.api.models.dtos.AuthResponse;
import com.becasfind.api.models.dtos.LoginRequest;

public interface AuthService {

    AuthResponse login(LoginRequest request);

    void forgotPassword(String email);

    void resetPassword(String token, String newPassword);
}
