package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.BecaFavorita;
import com.becasfind.api.models.entities.BecaFavoritaId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BecaFavoritaRepository extends JpaRepository<BecaFavorita, BecaFavoritaId> {

    List<BecaFavorita> findByUsuarioIdUsuario(Long idUsuario);

    boolean existsByUsuarioIdUsuarioAndBecaIdBeca(Long idUsuario, Long idBeca);

    void deleteByUsuarioIdUsuarioAndBecaIdBeca(Long idUsuario, Long idBeca);
}
