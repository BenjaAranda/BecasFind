package com.becasfind.api.services;

import com.becasfind.api.models.dtos.BecaDTO;
import com.becasfind.api.models.dtos.BecaDetailDTO;
import com.becasfind.api.models.dtos.BecaRequest;
import com.becasfind.api.models.dtos.BecaSearchRequest;
import com.becasfind.api.models.dtos.FiltrosBecaDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface BecaService {

    Page<BecaDTO> buscarPublicas(BecaSearchRequest request, boolean abiertas, Pageable pageable);

    FiltrosBecaDTO filtrosPublicos(boolean abiertas, boolean estatales);

    Page<BecaDTO> buscarBecas(Integer rsh, Double nem, Long regionId,
                              String query, Long idTipoBeca, Long idInstitucion,
                              Long idTipoInstitucion, String sort, Pageable pageable);

    Page<BecaDTO> recomendarBecas(String email, Pageable pageable);

    Page<BecaDTO> listarAdministracion(String query, Pageable pageable);

    BecaDetailDTO findById(Long id);

    BecaDetailDTO findByPublicId(java.util.UUID id);

    BecaDetailDTO findCatalogoByPublicId(java.util.UUID id);

    Page<BecaDTO> buscarCatalogo(Integer rsh, Double nem, Long regionId,
                              String query, Long idTipoBeca, Long idInstitucion,
                              Long idTipoInstitucion, String sort, Pageable pageable);

    BecaDTO create(Long userId, BecaRequest request);

    BecaDTO update(Long id, BecaRequest request);

    void delete(Long id);
}
