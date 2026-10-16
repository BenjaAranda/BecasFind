import api from './api';
import type { ApiResponse, BecaSummary } from '../types';

export const favoritoService = {
  listar(signal?: AbortSignal) {
    return api.get<ApiResponse<BecaSummary[]>>('/favoritos', { signal });
  },

  guardar(idBeca: string) {
    return api.post<ApiResponse<void>>(`/favoritos/${idBeca}`);
  },

  eliminar(idBeca: string) {
    return api.delete<ApiResponse<void>>(`/favoritos/${idBeca}`);
  },

  check(idBeca: string) {
    return api.get<ApiResponse<{ favorito: boolean }>>(`/favoritos/${idBeca}/check`);
  },
};
