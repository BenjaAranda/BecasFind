import api from './api';
import type { ApiResponse, BecaSummary, BecaDetail, BecaSearchRequest, PageResponse, Region } from '../types';

type FilterOption = { id: number; nombre: string };
export type SearchFilterOptions = Record<'regiones' | 'tiposBeca' | 'instituciones' | 'categorias', FilterOption[]>;

export const becaService = {
  searchFilters(vista: string, signal: AbortSignal) {
    return api.get<ApiResponse<SearchFilterOptions>>('/becas/catalogo/filtros', {
      params: { abiertas: vista === 'abiertas', estatales: vista === 'estatales' }, signal,
    });
  },
  searchCatalogo(filters: BecaSearchRequest, signal?: AbortSignal) {
    return api.post<ApiResponse<PageResponse<BecaSummary>>>('/becas/catalogo/buscar', filters, { signal });
  },

  detalleCatalogo(id: string, signal?: AbortSignal) {
    return api.get<ApiResponse<BecaDetail>>(`/becas/catalogo/${id}`, { signal });
  },
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

  findById(id: string, signal?: AbortSignal) {
    return api.get<ApiResponse<BecaDetail>>(`/becas/${id}`, { signal });
  },
};

export const catalogoService = {
  getRegiones() {
    return api.get<ApiResponse<Region[]>>('/regiones');
  },
};
