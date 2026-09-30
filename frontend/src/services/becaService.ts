import api from './api';
import type { ApiResponse, BecaSummary, BecaDetail, BecaSearchRequest, PageResponse, Region } from '../types';

export const becaService = {
  search(filters: BecaSearchRequest, signal?: AbortSignal) {
    return api.post<ApiResponse<PageResponse<BecaSummary>>>('/becas/buscar', filters, { signal });
  },

  findAll(page: number = 0, size: number = 10) {
    return api.get<ApiResponse<PageResponse<BecaSummary>>>('/becas', {
      params: { page, size },
    });
  },

  recomendar(page: number = 0, size: number = 10, signal?: AbortSignal) {
    return api.get<ApiResponse<PageResponse<BecaSummary>>>('/becas/recomendadas', {
      params: { page, size },
      signal,
    });
  },

  findById(id: number, signal?: AbortSignal) {
    return api.get<ApiResponse<BecaDetail>>(`/becas/${id}`, { signal });
  },
};

export const catalogoService = {
  getRegiones() {
    return api.get<ApiResponse<Region[]>>('/regiones');
  },
};
