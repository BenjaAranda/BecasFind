export interface User {
  idUsuario: number;
  email: string;
  nombreCompleto: string;
  rol: string;
  activo: boolean;
  creadoEn?: string;
}

export type UsuarioDTO = User;

export interface LoginRequest {
  email: string;
  password: string;
}

export interface AuthResponse {
  token: string;
  tokenType: string;
  nombreRol: string;
  nombreCompleto: string;
  email: string;
}

export interface ApiResponse<T> {
  timestamp: string;
  status: number;
  message: string;
  data: T;
}

export interface Region {
  idRegion: number;
  nombre: string;
  abreviatura: string;
}

export interface TipoBeca {
  idTipoBeca: number;
  nombre: string;
}

export interface TipoInstitucion {
  idTipoInst: number;
  nombre: string;
}

export interface Institucion {
  idInstitucion: number;
  rut: string;
  nombre: string;
  sitioWeb: string;
  contactoEmail: string;
  tipoInstitucion: TipoInstitucion | null;
}

export interface RequisitoPerfil {
  idRequisito: number;
  rshMaximoPorcentaje: number | null;
  nemMinimo: number | null;
  paesMinimo: number | null;
  esParaPrimerAnio: boolean;
  esParaCursoSuperior: boolean;
}

export interface DocumentoRequerido {
  idDocumento: number;
  nombreDocumento: string;
  esObligatorio: boolean;
}

export interface BecaSummary {
  idBeca: number;
  nombre: string;
  descripcionCorta: string;
  montoCobertura: string;
  fechaCierrePostulacion: string;
  urlOficial: string;
  nombreInstitucion: string;
  nombreTipoBeca: string;
  nombreRegion: string;
}

export interface BecaDetail {
  idBeca: number;
  nombre: string;
  descripcionCorta: string;
  descripcionLarga: string;
  montoCobertura: string;
  fechaInicioPostulacion: string;
  fechaCierrePostulacion: string;
  urlOficial: string;
  estadoActiva: boolean;
  institucion: Institucion | null;
  tipoBeca: TipoBeca | null;
  regiones: Region[];
  requisitoPerfil: RequisitoPerfil | null;
  documentosRequeridos: DocumentoRequerido[];
}

export interface BecaSearchRequest {
  rsh?: number | null;
  nem?: number | null;
  regionId?: number | null;
  page?: number;
  size?: number;
}

export interface PageResponse<T> {
  content: T[];
  totalElements: number;
  totalPages: number;
  number: number;
  size: number;
  first: boolean;
  last: boolean;
}

export interface AuthContextType {
  user: User | null;
  token: string | null;
  loading: boolean;
  login: (email: string, password: string) => Promise<void>;
  register: (nombreCompleto: string, email: string, password: string) => Promise<void>;
  logout: () => void;
  isAuthenticated: boolean;
  isAdmin: boolean;
}

export interface PerfilEstudiante {
  idPerfil: number;
  rshPorcentaje: number | null;
  nemPromedio: number | null;
  region: Region | null;
  institucion: Institucion | null;
  carreraInteres: string | null;
  esPrimerAnio: boolean;
  esCursoSuperior: boolean;
}
