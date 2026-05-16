package com.becasfind.api.services;

import com.becasfind.api.models.dtos.ImportResultDTO;
import org.springframework.web.multipart.MultipartFile;

public interface BecaImportService {

    ImportResultDTO importarDesdeCsv(MultipartFile file);
}
