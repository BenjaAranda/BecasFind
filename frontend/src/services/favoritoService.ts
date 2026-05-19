import api from './api';
import type { ApiResponse, BecaSummary } from '../types';

export const favoritoService = {
  listar() {
    return api.get<ApiResponse<BecaSummary[]>>('/favoritos');
  },

  guardar(idBeca: number) {
    return api.post<ApiResponse<void>>(`/favoritos/${idBeca}`);
  },

  eliminar(idBeca: number) {
    return api.delete<ApiResponse<void>>(`/favoritos/${idBeca}`);
  },

  check(idBeca: number) {
    return api.get<ApiResponse<{ favorito: boolean }>>(`/favoritos/${idBeca}/check`);
  },
};
