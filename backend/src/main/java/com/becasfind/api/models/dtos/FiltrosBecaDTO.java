package com.becasfind.api.models.dtos;

import java.util.List;

public record FiltrosBecaDTO(List<Opcion> regiones, List<Opcion> tiposBeca,
                           List<Opcion> instituciones, List<Opcion> categorias) {
    public record Opcion(Long id, String nombre) {}
}
