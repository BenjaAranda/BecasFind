package com.becasfind.api.services;

import com.becasfind.api.models.dtos.BecaDTO;
import com.becasfind.api.models.dtos.BecaDetailDTO;
import com.becasfind.api.models.dtos.BecaRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface BecaService {

    Page<BecaDTO> buscarBecas(Integer rsh, Double nem, Long regionId,
                              String query, Long idTipoBeca, Long idInstitucion,
                              Long idTipoInstitucion, String sort, Pageable pageable);

    Page<BecaDTO> recomendarBecas(String email, Pageable pageable);

    BecaDetailDTO findById(Long id);

    BecaDTO create(Long userId, BecaRequest request);

    BecaDTO update(Long id, BecaRequest request);

    void delete(Long id);
}
