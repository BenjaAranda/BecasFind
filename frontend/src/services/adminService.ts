import api from './api';
import type { ApiResponse, BecaSummary, BecaDetail, UsuarioDTO, PageResponse, Region, TipoBeca, TipoInstitucion, Institucion, ImportResult } from '../types';

export const adminService = {
  getBecas(page: number = 0, size: number = 20) {
    return api.get<ApiResponse<PageResponse<BecaSummary>>>('/becas', { params: { page, size } });
  },

  getBeca(id: number) {
    return api.get<ApiResponse<BecaDetail>>(`/becas/${id}`);
  },

  createBeca(data: Record<string, unknown>) {
    return api.post<ApiResponse<BecaSummary>>('/becas', data);
  },

  updateBeca(id: number, data: Record<string, unknown>) {
    return api.put<ApiResponse<BecaSummary>>(`/becas/${id}`, data);
  },

  deleteBeca(id: number) {
    return api.delete<ApiResponse<void>>(`/becas/${id}`);
  },

  getUsuarios() {
    return api.get<ApiResponse<UsuarioDTO[]>>('/usuarios');
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
