package com.becasfind.api.services;

import com.becasfind.api.models.dtos.UsuarioDTO;
import com.becasfind.api.models.dtos.UsuarioRequest;
import com.becasfind.api.models.dtos.UsuarioUpdateRequest;

import java.util.List;

public interface UsuarioService {

    List<UsuarioDTO> findAll();

    UsuarioDTO findById(Long id);

    UsuarioDTO create(UsuarioRequest request);

    UsuarioDTO update(Long id, UsuarioUpdateRequest request);

    void deactivate(Long id);
}
