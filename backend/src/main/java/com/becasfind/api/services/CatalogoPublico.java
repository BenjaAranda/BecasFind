package com.becasfind.api.services;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class CatalogoPublico {
    private final Set<UUID> publicIds;
    private final Set<UUID> enRevision;

    public CatalogoPublico() throws IOException {
        try (var input = new ClassPathResource("catalogo-publico-uuid.txt").getInputStream()) {
            publicIds = new String(input.readAllBytes(), StandardCharsets.UTF_8).lines()
                    .filter(line -> !line.isBlank()).map(UUID::fromString).collect(Collectors.toUnmodifiableSet());
        }
        try (var input = new ClassPathResource("catalogo-en-revision-uuid.txt").getInputStream()) {
            enRevision = new String(input.readAllBytes(), StandardCharsets.UTF_8).lines()
                    .filter(line -> !line.isBlank()).map(UUID::fromString).collect(Collectors.toUnmodifiableSet());
        }
        if (!publicIds.containsAll(enRevision)) throw new IllegalStateException("La revisión debe pertenecer al catálogo público");
    }

    public com.becasfind.api.models.dtos.EstadoPostulacion estado(com.becasfind.api.models.entities.Beca beca) {
        if (enRevision.contains(beca.getPublicId())) return com.becasfind.api.models.dtos.EstadoPostulacion.EN_REVISION;
        return com.becasfind.api.models.dtos.EstadoPostulacion.calcular(beca.getEstadoActiva(), beca.getFechaInicioPostulacion(), beca.getFechaCierrePostulacion());
    }

    public Set<UUID> getPublicIds() {
        return publicIds;
    }
}
