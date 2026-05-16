import api from './api';
import type { ApiResponse, PerfilEstudiante } from '../types';

export const perfilService = {
  getPerfil() {
    return api.get<ApiResponse<PerfilEstudiante>>('/perfil');
  },

  savePerfil(data: Record<string, unknown>) {
    return api.put<ApiResponse<PerfilEstudiante>>('/perfil', data);
  },
};
