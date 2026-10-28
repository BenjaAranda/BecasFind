import type { BecaSummary } from '../types';
import { todayInChile } from './dates';

type Estado = 'ABIERTA' | 'CERRADA' | 'PROXIMA' | 'FECHAS_POR_CONFIRMAR' | 'EN_REVISION';
type Fechas = Pick<BecaSummary, 'estadoActiva' | 'fechaCierrePostulacion' | 'fechaInicioPostulacion' | 'estadoPostulacion'>;

export function estadoPostulacion(beca: Fechas): Estado {
  if (beca.estadoPostulacion) return beca.estadoPostulacion;
  const today = todayInChile();
  if (beca.fechaCierrePostulacion && beca.fechaCierrePostulacion < today) return 'CERRADA';
  if (beca.fechaInicioPostulacion && beca.fechaCierrePostulacion && beca.fechaInicioPostulacion > today) return 'PROXIMA';
  return beca.estadoActiva && beca.fechaCierrePostulacion ? 'ABIERTA' : 'FECHAS_POR_CONFIRMAR';
}
