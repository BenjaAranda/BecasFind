import type { BecaSummary } from '../../types';
import { estadoPostulacion } from '../../utils/estadoPostulacion';

type Fechas = Pick<BecaSummary, 'estadoActiva' | 'fechaCierrePostulacion' | 'fechaInicioPostulacion' | 'estadoPostulacion'>;

export default function EstadoPostulacion({ beca }: { beca: Fechas }) {
  const state = estadoPostulacion(beca);
  const labels = { ABIERTA: 'Postulación abierta', CERRADA: 'Convocatoria cerrada', PROXIMA: 'Próxima convocatoria', FECHAS_POR_CONFIRMAR: 'Fechas por confirmar', EN_REVISION: 'Información en revisión' };
  return <span className={`inline-block text-xs font-medium px-3 py-1 rounded-sm ${state === 'ABIERTA' ? 'bg-green-50 text-green-800' : state === 'CERRADA' ? 'bg-slate-100 text-slate-700' : 'bg-amber-50 text-amber-900'}`}>{labels[state]}</span>;
}
