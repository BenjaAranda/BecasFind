package com.becasfind.api.services;

import com.becasfind.api.models.dtos.BecaDTO;

import java.util.List;

public interface FavoritoService {

    void guardar(String email, Long idBeca);

    void eliminar(String email, Long idBeca);

    List<BecaDTO> listar(String email);

    boolean isFavorito(String email, Long idBeca);
}
