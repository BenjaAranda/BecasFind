import api from './api';
import type { ApiResponse, BecaSummary, BecaDetail, BecaSearchRequest, PageResponse, Region } from '../types';

export const becaService = {
  search(filters: BecaSearchRequest) {
    return api.post<ApiResponse<PageResponse<BecaSummary>>>('/becas/buscar', filters);
  },

  findAll(page: number = 0, size: number = 10) {
    return api.get<ApiResponse<PageResponse<BecaSummary>>>('/becas', {
      params: { page, size },
    });
  },

  findById(id: number) {
    return api.get<ApiResponse<BecaDetail>>(`/becas/${id}`);
  },
};

export const catalogoService = {
  getRegiones() {
    return api.get<ApiResponse<Region[]>>('/regiones');
  },
};
