package com.becasfind.api.services;

public interface ResetEmailService {
    void requireConfigured();
    void sendPasswordReset(String email, String token);
}
