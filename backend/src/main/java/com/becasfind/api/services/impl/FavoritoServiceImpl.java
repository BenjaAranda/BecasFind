package com.becasfind.api.services.impl;

import com.becasfind.api.models.dtos.BecaDTO;
import com.becasfind.api.models.entities.Beca;
import com.becasfind.api.models.entities.BecaFavorita;
import com.becasfind.api.models.entities.BecaFavoritaId;
import com.becasfind.api.models.entities.Usuario;
import com.becasfind.api.repositories.BecaFavoritaRepository;
import com.becasfind.api.repositories.BecaRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import com.becasfind.api.services.FavoritoService;
import jakarta.persistence.EntityNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class FavoritoServiceImpl implements FavoritoService {

    private static final Logger log = LoggerFactory.getLogger(FavoritoServiceImpl.class);

    private final BecaFavoritaRepository becaFavoritaRepository;
    private final BecaRepository becaRepository;
    private final UsuarioRepository usuarioRepository;

    public FavoritoServiceImpl(BecaFavoritaRepository becaFavoritaRepository,
                               BecaRepository becaRepository,
                               UsuarioRepository usuarioRepository) {
        this.becaFavoritaRepository = becaFavoritaRepository;
        this.becaRepository = becaRepository;
        this.usuarioRepository = usuarioRepository;
    }

    @Override
    @Transactional
    public void guardar(String email, Long idBeca) {
        Usuario usuario = usuarioRepository.findByEmailAndActivoTrue(email)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado"));

        if (becaFavoritaRepository.existsByUsuarioIdUsuarioAndBecaIdBeca(usuario.getIdUsuario(), idBeca)) {
            log.debug("La beca {} ya es favorita del usuario {}", idBeca, email);
            return;
        }

        BecaFavorita favorita = new BecaFavorita();
        favorita.setId(new BecaFavoritaId(usuario.getIdUsuario(), idBeca));
        favorita.setUsuario(usuarioRepository.getReferenceById(usuario.getIdUsuario()));
        favorita.setBeca(becaRepository.getReferenceById(idBeca));
        becaFavoritaRepository.save(favorita);

        log.info("Beca {} guardada como favorita para usuario {}", idBeca, email);
    }

    @Override
    @Transactional
    public void eliminar(String email, Long idBeca) {
        Usuario usuario = usuarioRepository.findByEmailAndActivoTrue(email)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado"));

        becaFavoritaRepository.deleteByUsuarioIdUsuarioAndBecaIdBeca(usuario.getIdUsuario(), idBeca);
    }

    @Override
    @Transactional(readOnly = true)
    public List<BecaDTO> listar(String email) {
        Usuario usuario = usuarioRepository.findByEmailAndActivoTrue(email)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado"));

        return becaFavoritaRepository.findByUsuarioIdUsuario(usuario.getIdUsuario())
                .stream()
                .map(fav -> {
                    Beca b = fav.getBeca();
                    return BecaDTO.builder()
                            .idBeca(b.getIdBeca())
                            .nombre(b.getNombre())
                            .descripcionCorta(b.getDescripcionCorta())
                            .montoCobertura(b.getMontoCobertura())
                            .fechaCierrePostulacion(b.getFechaCierrePostulacion())
                            .urlOficial(b.getUrlOficial())
                            .nombreInstitucion(b.getInstitucion() != null ? b.getInstitucion().getNombre() : null)
                            .nombreTipoBeca(b.getTipoBeca() != null ? b.getTipoBeca().getNombre() : null)
                            .nombreRegion(b.getRegiones() != null && !b.getRegiones().isEmpty()
                                    ? b.getRegiones().iterator().next().getNombre()
                                    : "Nacional")
                            .build();
                })
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isFavorito(String email, Long idBeca) {
        Usuario usuario = usuarioRepository.findByEmailAndActivoTrue(email)
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado"));

        return becaFavoritaRepository.existsByUsuarioIdUsuarioAndBecaIdBeca(usuario.getIdUsuario(), idBeca);
    }
}
