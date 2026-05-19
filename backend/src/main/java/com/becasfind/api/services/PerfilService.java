package com.becasfind.api.services;

import com.becasfind.api.models.dtos.PerfilEstudianteDTO;
import com.becasfind.api.models.dtos.PerfilEstudianteRequest;

public interface PerfilService {

    PerfilEstudianteDTO getPerfil(String email);

    PerfilEstudianteDTO savePerfil(String email, PerfilEstudianteRequest request);
}
