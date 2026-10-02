package com.becasfind.api.models.dtos;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LoginRequest {

    @NotBlank(message = "El email es obligatorio")
    @Email(message = "El correo debe tener un formato válido")
    @jakarta.validation.constraints.Size(max = 254, message = "El correo es demasiado largo")
    private String email;

    @NotBlank(message = "La contraseña es obligatoria")
    @jakarta.validation.constraints.Size(max = 72, message = "La contraseña no puede superar 72 caracteres")
    private String password;

    @com.fasterxml.jackson.annotation.JsonIgnore
    @jakarta.validation.constraints.AssertTrue(message = "La contraseña no puede superar 72 bytes UTF-8")
    public boolean isPasswordUtf8Valid() {
        return password == null || password.getBytes(java.nio.charset.StandardCharsets.UTF_8).length <= 72;
    }
}
