import api from './api';
import type { ApiResponse, AdminBecaSummary, AdminBecaDetail, UsuarioDTO, PageResponse, Region, TipoBeca, TipoInstitucion, Institucion, ImportResult } from '../types';

export const adminService = {
  getBecas(page: number = 0, size: number = 20, query?: string, signal?: AbortSignal) {
    return api.get<ApiResponse<PageResponse<AdminBecaSummary>>>('/becas/administracion', { params: { page, size, query }, signal });
  },

  getBeca(id: number) {
    return api.get<ApiResponse<AdminBecaDetail>>(`/becas/administracion/${id}`);
  },

  createBeca(data: Record<string, unknown>) {
    return api.post<ApiResponse<AdminBecaSummary>>('/becas', data);
  },

  updateBeca(id: number, data: Record<string, unknown>) {
    return api.put<ApiResponse<AdminBecaSummary>>(`/becas/${id}`, data);
  },

  deleteBeca(id: number) {
    return api.delete<ApiResponse<void>>(`/becas/${id}`);
  },

  getUsuarios(signal?: AbortSignal) {
    return api.get<ApiResponse<UsuarioDTO[]>>('/usuarios', { signal });
  },

  createUsuario(data: Record<string, unknown>) {
    return api.post<ApiResponse<UsuarioDTO>>('/usuarios', data);
  },

  updateUsuario(id: number, data: Record<string, unknown>) {
    return api.put<ApiResponse<UsuarioDTO>>(`/usuarios/${id}`, data);
  },

  deactivateUsuario(id: number) {
    return api.delete<ApiResponse<void>>(`/usuarios/${id}`);
  },

  getRegiones() {
    return api.get<ApiResponse<Region[]>>('/regiones');
  },

  getTiposBeca() {
    return api.get<ApiResponse<TipoBeca[]>>('/tipos-beca');
  },

  getTiposInstitucion() {
    return api.get<ApiResponse<TipoInstitucion[]>>('/tipos-institucion');
  },

  getInstituciones() {
    return api.get<ApiResponse<Institucion[]>>('/instituciones');
  },

  importCsv(file: File) {
    const formData = new FormData();
    formData.append('file', file);
    return api.post<ApiResponse<ImportResult>>('/becas/importar-csv', formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
  },
};
