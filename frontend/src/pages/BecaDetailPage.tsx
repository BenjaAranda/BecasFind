import { useState, useEffect, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { becaService } from '../services/becaService';
import type { BecaDetail } from '../types';
import {
  ArrowLeft,
  Calendar,
  Building2,
  Tag,
  Globe,
  FileCheck,
  GraduationCap,
  AlertCircle,
  Clock,
} from 'lucide-react';

export default function BecaDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [beca, setBeca] = useState<BecaDetail | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!id) return;
    becaService.findById(Number(id))
      .then(({ data }) => setBeca(data.data))
      .catch(() => navigate('/'))
      .finally(() => setLoading(false));
  }, [id, navigate]);

  const goBack = useCallback(() => {
    if (window.history.length > 1) {
      navigate(-1);
    } else {
      navigate('/explorar');
    }
  }, [navigate]);

  useEffect(() => {
    const handleHardwareBack = (e: Event) => {
      if (e instanceof KeyboardEvent && e.key === 'Escape') {
        goBack();
      } else if (e instanceof MouseEvent && (e.button === 3 || e.button === 4)) {
        e.preventDefault();
        goBack();
      }
    };
    window.addEventListener('keydown', handleHardwareBack);
    window.addEventListener('mouseup', handleHardwareBack);
    return () => {
      window.removeEventListener('keydown', handleHardwareBack);
      window.removeEventListener('mouseup', handleHardwareBack);
    };
  }, [goBack]);

  const formatDate = (dateStr: string) =>
    new Date(dateStr).toLocaleDateString('es-CL', {
      day: 'numeric',
      month: 'long',
      year: 'numeric',
    });

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-blue-600" />
      </div>
    );
  }

  if (!beca) return null;

  const isExpired = new Date(beca.fechaCierrePostulacion) < new Date();

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-white border-b border-gray-200">
        <div className="max-w-4xl mx-auto px-4 h-14 flex items-center justify-between">
          <button
            onClick={goBack}
            className="flex items-center gap-1 text-sm text-gray-600 hover:text-blue-600 transition cursor-pointer"
          >
            <ArrowLeft className="w-4 h-4" />
            Volver
          </button>
          <div className="flex items-center gap-2 cursor-pointer" onClick={() => navigate('/')}>
            <GraduationCap className="w-6 h-6 text-blue-600" />
            <span className="font-bold text-lg text-gray-800">BecasFind</span>
          </div>
        </div>
      </header>

      <main className="max-w-4xl mx-auto px-4 py-6 space-y-6">
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
          <div className="flex flex-wrap items-start justify-between gap-3 mb-4">
            <h1 className="text-2xl font-bold text-gray-800">{beca.nombre}</h1>
            <span className={`text-xs font-semibold px-3 py-1 rounded-full ${isExpired ? 'bg-red-50 text-red-700' : 'bg-green-50 text-green-700'}`}>
              {isExpired ? 'Expirada' : 'Activa'}
            </span>
          </div>

          {beca.descripcionCorta && (
            <p className="text-gray-600 mb-4">{beca.descripcionCorta}</p>
          )}

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-6">
            <div className="flex items-center gap-2 text-sm text-gray-600">
              <Building2 className="w-4 h-4 text-gray-400 shrink-0" />
              <span className="font-medium">Institución:</span>
              <span>{beca.institucion?.nombre}</span>
            </div>
            <div className="flex items-center gap-2 text-sm text-gray-600">
              <Tag className="w-4 h-4 text-gray-400 shrink-0" />
              <span className="font-medium">Tipo:</span>
              <span>{beca.tipoBeca?.nombre}</span>
            </div>
            {beca.montoCobertura && (
              <div className="flex items-center gap-2 text-sm text-gray-600">
                <span className="font-medium">Monto:</span>
                <span>{beca.montoCobertura}</span>
              </div>
            )}
            <div className="flex items-center gap-2 text-sm text-gray-600">
              <Globe className="w-4 h-4 text-gray-400 shrink-0" />
              <span className="font-medium">Alcance:</span>
              <span>{beca.regiones.length > 0 ? beca.regiones.map(r => r.nombre).join(', ') : 'Nacional'}</span>
            </div>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 p-4 bg-gray-50 rounded-lg">
            {beca.fechaInicioPostulacion && (
              <div className="flex items-center gap-2 text-sm">
                <Calendar className="w-4 h-4 text-blue-500 shrink-0" />
                <div>
                  <span className="text-gray-500">Inicio postulación:</span>
                  <p className="font-medium text-gray-800">{formatDate(beca.fechaInicioPostulacion)}</p>
                </div>
              </div>
            )}
            <div className="flex items-center gap-2 text-sm">
              <Clock className={`w-4 h-4 shrink-0 ${isExpired ? 'text-red-500' : 'text-orange-500'}`} />
              <div>
                <span className="text-gray-500">Cierre postulación:</span>
                <p className="font-medium text-gray-800">{formatDate(beca.fechaCierrePostulacion)}</p>
              </div>
            </div>
          </div>
        </div>

        {beca.descripcionLarga && (
          <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
            <h2 className="text-lg font-semibold text-gray-800 mb-3">Descripción Completa</h2>
            <p className="text-gray-600 whitespace-pre-line">{beca.descripcionLarga}</p>
          </div>
        )}

        {beca.requisitoPerfil && (
          <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
            <h2 className="text-lg font-semibold text-gray-800 mb-4 flex items-center gap-2">
              <AlertCircle className="w-5 h-5 text-amber-500" />
              Requisitos del Perfil
            </h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              {beca.requisitoPerfil.rshMaximoPorcentaje != null && (
                <div className="p-3 bg-amber-50 rounded-lg">
                  <p className="text-xs text-amber-600 font-medium">RSH Máximo</p>
                  <p className="text-lg font-bold text-amber-800">{beca.requisitoPerfil.rshMaximoPorcentaje}%</p>
                </div>
              )}
              {beca.requisitoPerfil.nemMinimo != null && (
                <div className="p-3 bg-blue-50 rounded-lg">
                  <p className="text-xs text-blue-600 font-medium">NEM Mínimo</p>
                  <p className="text-lg font-bold text-blue-800">{beca.requisitoPerfil.nemMinimo}</p>
                </div>
              )}
              {beca.requisitoPerfil.paesMinimo != null && (
                <div className="p-3 bg-purple-50 rounded-lg">
                  <p className="text-xs text-purple-600 font-medium">PAES Mínimo</p>
                  <p className="text-lg font-bold text-purple-800">{beca.requisitoPerfil.paesMinimo}</p>
                </div>
              )}
              <div className="p-3 bg-gray-50 rounded-lg">
                <p className="text-xs text-gray-500 font-medium">Nivel</p>
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

        {beca.documentosRequeridos.length > 0 && (
          <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
            <h2 className="text-lg font-semibold text-gray-800 mb-4 flex items-center gap-2">
              <FileCheck className="w-5 h-5 text-green-500" />
              Documentos Requeridos
            </h2>
            <ul className="space-y-2">
              {beca.documentosRequeridos.map((doc) => (
                <li key={doc.idDocumento} className="flex items-center gap-2 text-sm text-gray-600">
                  <span className="w-1.5 h-1.5 rounded-full bg-green-400 shrink-0" />
                  {doc.nombreDocumento}
                  {doc.esObligatorio && (
                    <span className="text-xs text-red-500 font-medium">(Obligatorio)</span>
                  )}
                </li>
              ))}
            </ul>
          </div>
        )}

        {beca.urlOficial && (
          <div className="text-center">
            <a
              href={beca.urlOficial}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 px-6 py-2.5 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition"
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
