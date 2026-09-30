import { useState, useEffect, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import PublicNavbar from '../components/layout/PublicNavbar';
import { becaService } from '../services/becaService';
import type { BecaDetail } from '../types';
import { formatCalendarDate, isClosingDateExpired } from '../utils/dates';
import {
  ArrowLeft,
  Calendar,
  Building2,
  Tag,
  Globe,
  FileCheck,
  AlertCircle,
  Clock,
} from 'lucide-react';

export default function BecaDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [beca, setBeca] = useState<BecaDetail | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [retry, setRetry] = useState(0);

  useEffect(() => {
    let active = true;
    const controller = new AbortController();
    const numericId = Number(id);
    const request = Number.isSafeInteger(numericId) && numericId > 0
      ? becaService.findById(numericId, controller.signal)
      : Promise.reject(new Error('Identificador inválido'));
    request.then(({ data }) => { if (active) { setBeca(data.data); setError(''); } })
      .catch(() => { if (active) { setBeca(null); setError('No pudimos abrir esta beca. El enlace puede no estar disponible o hubo un problema de conexión.'); } })
      .finally(() => { if (active) setLoading(false); });
    return () => { active = false; controller.abort(); };
  }, [id, retry]);

  const goBack = useCallback(() => {
    if (window.history.state?.idx > 0) {
      navigate(-1);
    } else {
      navigate('/explorar');
    }
  }, [navigate]);

  const formatDate = formatCalendarDate;

  if (loading) {
    return (
      <div className="min-h-screen bg-[#f5f3ed] flex items-center justify-center">
        <p role="status" className="text-[#123f48]">Cargando la beca…</p>
      </div>
    );
  }

  if (!beca) return <div className="min-h-screen bg-[#f5f3ed]"><PublicNavbar /><main className="max-w-2xl mx-auto px-6 py-16"><h1 className="font-serif text-4xl text-[#123f48] mb-6">No pudimos abrir esta beca</h1><p role="alert" className="text-slate-600 mb-6">{error}</p><div className="flex flex-wrap gap-4"><button onClick={() => { setLoading(true); setRetry(value => value + 1); }} className="min-h-12 px-5 bg-[#123f48] text-white focus-visible:outline-2 focus-visible:outline-offset-4">Reintentar</button><button onClick={() => navigate('/explorar')} className="min-h-12 px-5 text-[#123f48] underline focus-visible:outline-2 focus-visible:outline-offset-4">Volver al buscador</button></div></main></div>;

  const isExpired = isClosingDateExpired(beca.fechaCierrePostulacion);

  return (
    <div className="min-h-screen bg-[#f5f3ed]">
      <PublicNavbar />

      <main className="max-w-4xl mx-auto px-4 sm:px-6 py-8 space-y-6">
        <button onClick={goBack} className="inline-flex items-center gap-2 min-h-11 text-sm text-[#123f48] underline underline-offset-4 focus-visible:outline-2 focus-visible:outline-offset-2"><ArrowLeft size={16} aria-hidden="true" />Volver</button>
        <div className="bg-white rounded-sm shadow-none border border-[#dce3df] p-6">
          <div className="flex flex-wrap items-start justify-between gap-3 mb-4">
            <h1 className="font-serif text-3xl sm:text-5xl leading-tight break-words text-[#123f48]">{beca.nombre}</h1>
            <span className={`text-xs font-semibold px-3 py-1 rounded-full ${isExpired ? 'bg-red-50 text-red-700' : 'bg-green-50 text-green-700'}`}>
              {!beca.estadoActiva ? 'Inactiva' : isExpired ? 'Vencida' : 'Vigente'}
            </span>
          </div>

          {beca.descripcionCorta && (
            <p className="text-slate-600 mb-4">{beca.descripcionCorta}</p>
          )}

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-6">
            <div className="flex items-center gap-2 flex-wrap text-sm text-slate-600">
              <Building2 className="w-4 h-4 text-slate-500 shrink-0" />
              <span className="font-medium">Institución:</span>
              <span>{beca.institucion?.nombre}</span>
            </div>
            <div className="flex items-center gap-2 flex-wrap text-sm text-slate-600">
              <Tag className="w-4 h-4 text-slate-500 shrink-0" />
              <span className="font-medium">Tipo:</span>
              <span>{beca.tipoBeca?.nombre}</span>
            </div>
            {beca.montoCobertura && (
              <div className="flex items-center gap-2 flex-wrap text-sm text-slate-600">
                <span className="font-medium">Monto:</span>
                <span>{beca.montoCobertura}</span>
              </div>
            )}
            <div className="flex items-center gap-2 flex-wrap text-sm text-slate-600">
              <Globe className="w-4 h-4 text-slate-500 shrink-0" />
              <span className="font-medium">Alcance:</span>
              <span>{beca.regiones.length > 0 ? beca.regiones.map(r => r.nombre).join(', ') : 'Nacional'}</span>
            </div>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 p-4 bg-[#f5f3ed] rounded-sm">
            {beca.fechaInicioPostulacion && (
              <div className="flex items-center gap-2 text-sm">
                <Calendar className="w-4 h-4 text-blue-500 shrink-0" />
                <div>
                  <span className="text-slate-600">Inicio postulación:</span>
                  <p className="font-medium text-[#123f48]">{formatDate(beca.fechaInicioPostulacion)}</p>
                </div>
              </div>
            )}
            <div className="flex items-center gap-2 text-sm">
              <Clock className={`w-4 h-4 shrink-0 ${isExpired ? 'text-red-700' : 'text-orange-500'}`} />
              <div>
                <span className="text-slate-600">Cierre postulación:</span>
                <p className="font-medium text-[#123f48]">{formatDate(beca.fechaCierrePostulacion)}</p>
              </div>
            </div>
          </div>
        </div>

        {beca.descripcionLarga && (
          <div className="bg-white rounded-sm shadow-none border border-[#dce3df] p-6">
            <h2 className="font-serif text-2xl text-[#123f48] mb-3">Descripción Completa</h2>
            <p className="text-slate-600 leading-relaxed whitespace-pre-line break-words">{beca.descripcionLarga}</p>
          </div>
        )}

        {beca.requisitoPerfil && (
          <div className="bg-white rounded-sm shadow-none border border-[#dce3df] p-6">
            <h2 className="font-serif text-2xl text-[#123f48] mb-4 flex items-center gap-2">
              <AlertCircle className="w-5 h-5 text-amber-700" />
              Requisitos del Perfil
            </h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              {beca.requisitoPerfil.rshMaximoPorcentaje != null && (
                <div className="p-3 bg-amber-50 rounded-sm">
                  <p className="text-xs text-amber-600 font-medium">RSH Máximo</p>
                  <p className="text-lg font-bold text-amber-800">{beca.requisitoPerfil.rshMaximoPorcentaje}%</p>
                </div>
              )}
              {beca.requisitoPerfil.nemMinimo != null && (
                <div className="p-3 bg-[#e7eeea] rounded-sm">
                  <p className="text-xs text-[#123f48] font-medium">NEM Mínimo</p>
                  <p className="text-lg font-bold text-[#123f48]">{beca.requisitoPerfil.nemMinimo}</p>
                </div>
              )}
              {beca.requisitoPerfil.paesMinimo != null && (
                <div className="p-3 bg-[#e7eeea] rounded-sm">
                  <p className="text-xs text-[#46717a] font-medium">PAES Mínimo</p>
                  <p className="text-lg font-bold text-[#123f48]">{beca.requisitoPerfil.paesMinimo}</p>
                </div>
              )}
              <div className="p-3 bg-[#f5f3ed] rounded-sm">
                <p className="text-xs text-slate-600 font-medium">Nivel</p>
                <p className="text-sm font-medium text-gray-700">
                  {beca.requisitoPerfil.esParaPrimerAnio && 'Primer Año'}
                  {beca.requisitoPerfil.esParaPrimerAnio && beca.requisitoPerfil.esParaCursoSuperior && ' / '}
                  {beca.requisitoPerfil.esParaCursoSuperior && 'Curso Superior'}
                  {!beca.requisitoPerfil.esParaPrimerAnio && !beca.requisitoPerfil.esParaCursoSuperior && 'Sin restricción'}
                </p>
              </div>
            </div>
          </div>
        )}

        {beca.documentosRequeridos.length > 0 ? (
          <div className="bg-white rounded-sm shadow-none border border-[#dce3df] p-6">
            <h2 className="font-serif text-2xl text-[#123f48] mb-4 flex items-center gap-2">
              <FileCheck className="w-5 h-5 text-green-500" />
              Documentos Requeridos
            </h2>
            <ul className="space-y-2">
              {beca.documentosRequeridos.map((doc) => (
                <li key={doc.idDocumento} className="flex items-center gap-2 flex-wrap text-sm text-slate-600">
                  <span className={`w-1.5 h-1.5 rounded-full shrink-0 ${doc.esObligatorio ? 'bg-red-400' : 'bg-amber-400'}`} />
                  {doc.nombreDocumento}
                  <span className={`text-xs font-medium ${doc.esObligatorio ? 'text-red-700' : 'text-amber-700'}`}>
                    ({doc.esObligatorio ? 'Obligatorio' : 'Opcional'})
                  </span>
                </li>
              ))}
            </ul>
          </div>
        ) : beca.descripcionLarga && /\[(OBLIGATORIO|OPCIONAL)\]/i.test(beca.descripcionLarga) ? (
          <div className="bg-white rounded-sm shadow-none border border-[#dce3df] p-6">
            <h2 className="font-serif text-2xl text-[#123f48] mb-4 flex items-center gap-2">
              <FileCheck className="w-5 h-5 text-green-500" />
              Documentos Requeridos
            </h2>
            <ul className="space-y-2">
              {beca.descripcionLarga.match(/\[(OBLIGATORIO|OPCIONAL)\]\s*([^;[\r\n]+)/gi)?.map((item, i) => {
                const obligatorio = item.toUpperCase().includes('OBLIGATORIO');
                const texto = item.replace(/\[(OBLIGATORIO|OPCIONAL)\]\s*/i, '').trim();
                return (
                  <li key={i} className="flex items-center gap-2 flex-wrap text-sm text-slate-600">
                    <span className={`w-1.5 h-1.5 rounded-full shrink-0 ${obligatorio ? 'bg-red-400' : 'bg-amber-400'}`} />
                    {texto}
                    <span className={`text-xs font-medium ${obligatorio ? 'text-red-700' : 'text-amber-700'}`}>
                      ({obligatorio ? 'Obligatorio' : 'Opcional'})
                    </span>
                  </li>
                );
              }) || null}
            </ul>
          </div>
        ) : null}

        {beca.urlOficial && (
          <div className="text-center">
            <a
              href={beca.urlOficial}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 min-h-12 px-6 py-3 focus-visible:outline-2 focus-visible:outline-offset-4 bg-[#123f48] hover:bg-[#1a525c] text-white font-medium rounded-sm transition"
            >
              <Globe className="w-4 h-4" />
              Ver convocatoria oficial
            </a>
          </div>
        )}
      </main>
    </div>
  );
}
