import { useState, useEffect } from 'react';
import type { TipoBeca, Institucion, Region } from '../../types';
import { adminService } from '../../services/adminService';
import { X, Plus, Trash2 } from 'lucide-react';

interface BecaFormProps {
  onClose: () => void;
  onSave: () => void;
  editId?: number | null;
  initialData?: Record<string, unknown> | null;
}

export default function BecaForm({ onClose, onSave, editId, initialData }: BecaFormProps) {
  const [tiposBeca, setTiposBeca] = useState<TipoBeca[]>([]);
  const [instituciones, setInstituciones] = useState<Institucion[]>([]);
  const [regiones, setRegiones] = useState<Region[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const [nombre, setNombre] = useState('');
  const [descripcionCorta, setDescripcionCorta] = useState('');
  const [descripcionLarga, setDescripcionLarga] = useState('');
  const [montoCobertura, setMontoCobertura] = useState('');
  const [idTipoBeca, setIdTipoBeca] = useState('');
  const [idInstitucion, setIdInstitucion] = useState('');
  const [fechaInicio, setFechaInicio] = useState('');
  const [fechaCierre, setFechaCierre] = useState('');
  const [urlOficial, setUrlOficial] = useState('');
  const [estadoActiva, setEstadoActiva] = useState(true);
  const [regionesIds, setRegionesIds] = useState<number[]>([]);
  const [rshMaximo, setRshMaximo] = useState('');
  const [nemMinimo, setNemMinimo] = useState('');
  const [paesMinimo, setPaesMinimo] = useState('');
  const [esPrimerAnio, setEsPrimerAnio] = useState(false);
  const [esCursoSuperior, setEsCursoSuperior] = useState(false);
  const [documentos, setDocumentos] = useState<{ nombreDocumento: string; esObligatorio: boolean }[]>([]);

  useEffect(() => {
    Promise.all([
      adminService.getTiposBeca().then(r => setTiposBeca(r.data.data)),
      adminService.getInstituciones().then(r => setInstituciones(r.data.data)),
      adminService.getRegiones().then(r => setRegiones(r.data.data)),
    ]).catch(() => {});

    if (editId && initialData) {
      const d = initialData as Record<string, unknown>;
      setNombre((d.nombre as string) || '');
      setDescripcionCorta((d.descripcionCorta as string) || '');
      setDescripcionLarga((d.descripcionLarga as string) || '');
      setMontoCobertura((d.montoCobertura as string) || '');
      setIdTipoBeca(String(d.idTipoBeca || ''));
      setIdInstitucion(String(d.idInstitucion || ''));
      setFechaInicio((d.fechaInicioPostulacion as string) || '');
      setFechaCierre((d.fechaCierrePostulacion as string) || '');
      setUrlOficial((d.urlOficial as string) || '');
      setEstadoActiva(d.estadoActiva !== false);
      setRegionesIds((d.regionesIds as number[]) || []);
      setRshMaximo((d.rshMaximoPorcentaje as string) || '');
      setNemMinimo((d.nemMinimo as string) || '');
      setPaesMinimo((d.paesMinimo as string) || '');
      setEsPrimerAnio(Boolean(d.esParaPrimerAnio));
      setEsCursoSuperior(Boolean(d.esParaCursoSuperior));
      setDocumentos((d.documentosRequeridos as []) || []);
    }
  }, [editId, initialData]);

  const toggleRegion = (id: number) => {
    setRegionesIds(prev => prev.includes(id) ? prev.filter(r => r !== id) : [...prev, id]);
  };

  const addDocumento = () => setDocumentos([...documentos, { nombreDocumento: '', esObligatorio: true }]);

  const removeDocumento = (i: number) => setDocumentos(documentos.filter((_, idx) => idx !== i));

  const updateDocumento = (i: number, field: string, value: string | boolean) => {
    const updated = [...documentos];
    updated[i] = { ...updated[i], [field]: value };
    setDocumentos(updated);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    const payload: Record<string, unknown> = {
      nombre,
      descripcionCorta: descripcionCorta || null,
      descripcionLarga: descripcionLarga || null,
      montoCobertura: montoCobertura || null,
      idTipoBeca: Number(idTipoBeca),
      idInstitucion: Number(idInstitucion),
      fechaInicioPostulacion: fechaInicio || null,
      fechaCierrePostulacion: fechaCierre,
      urlOficial: urlOficial || null,
      estadoActiva,
      regionesIds: regionesIds.length > 0 ? regionesIds : null,
      rshMaximoPorcentaje: rshMaximo ? Number(rshMaximo) : null,
      nemMinimo: nemMinimo ? Number(nemMinimo) : null,
      paesMinimo: paesMinimo ? Number(paesMinimo) : null,
      esParaPrimerAnio: esPrimerAnio,
      esParaCursoSuperior: esCursoSuperior,
      documentosRequeridos: documentos.length > 0 ? documentos : null,
    };

    try {
      if (editId) await adminService.updateBeca(editId, payload);
      else await adminService.createBeca(payload);
      onSave();
    } catch (err: unknown) {
      const axiosErr = err as { response?: { data?: { message?: string } } };
      setError(axiosErr.response?.data?.message || 'Error al guardar la beca');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 bg-black/50 flex items-start justify-center pt-8 z-50 overflow-y-auto">
      <div className="bg-white rounded-xl shadow-xl w-full max-w-2xl mx-4 mb-8">
        <div className="flex items-center justify-between p-4 border-b">
          <h2 className="text-lg font-semibold">{editId ? 'Editar Beca' : 'Nueva Beca'}</h2>
          <button onClick={onClose} className="p-1 hover:bg-gray-100 rounded cursor-pointer"><X className="w-5 h-5" /></button>
        </div>

        {error && <div className="mx-4 mt-4 p-3 bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg">{error}</div>}

        <form onSubmit={handleSubmit} className="p-4 space-y-4 max-h-[70vh] overflow-y-auto">
          <div className="grid grid-cols-2 gap-4">
            <div className="col-span-2">
              <label className="block text-sm font-medium text-gray-700 mb-1">Nombre *</label>
              <input required value={nombre} onChange={e => setNombre(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Tipo Beca *</label>
              <select required value={idTipoBeca} onChange={e => setIdTipoBeca(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm bg-white focus:ring-2 focus:ring-blue-500 outline-none">
                <option value="">Seleccionar</option>
                {tiposBeca.map(t => <option key={t.idTipoBeca} value={t.idTipoBeca}>{t.nombre}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Institución *</label>
              <select required value={idInstitucion} onChange={e => setIdInstitucion(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm bg-white focus:ring-2 focus:ring-blue-500 outline-none">
                <option value="">Seleccionar</option>
                {instituciones.map(i => <option key={i.idInstitucion} value={i.idInstitucion}>{i.nombre}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Monto Cobertura</label>
              <input value={montoCobertura} onChange={e => setMontoCobertura(e.target.value)} placeholder="Ej: $600.000 anual" className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">URL Oficial</label>
              <input value={urlOficial} onChange={e => setUrlOficial(e.target.value)} placeholder="https://..." className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Inicio Postulación</label>
              <input type="date" value={fechaInicio} onChange={e => setFechaInicio(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Cierre Postulación *</label>
              <input type="date" required value={fechaCierre} onChange={e => setFechaCierre(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" />
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-gray-700 mb-1">Descripción Corta</label>
              <textarea value={descripcionCorta} onChange={e => setDescripcionCorta(e.target.value)} rows={2} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" />
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-gray-700 mb-1">Descripción Larga</label>
              <textarea value={descripcionLarga} onChange={e => setDescripcionLarga(e.target.value)} rows={3} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" />
            </div>
            <div className="col-span-2">
              <label className="flex items-center gap-2 cursor-pointer">
                <input type="checkbox" checked={estadoActiva} onChange={e => setEstadoActiva(e.target.checked)} className="w-4 h-4" />
                <span className="text-sm text-gray-700">Beca activa</span>
              </label>
            </div>
          </div>

          <div className="border-t pt-4">
            <h3 className="text-sm font-semibold text-gray-800 mb-2">Requisitos del Perfil</h3>
            <div className="grid grid-cols-3 gap-3">
              <div>
                <label className="block text-xs text-gray-600 mb-1">RSH Máximo (%)</label>
                <input type="number" value={rshMaximo} onChange={e => setRshMaximo(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" />
              </div>
              <div>
                <label className="block text-xs text-gray-600 mb-1">NEM Mínimo</label>
                <input type="number" step="0.1" value={nemMinimo} onChange={e => setNemMinimo(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" />
              </div>
              <div>
                <label className="block text-xs text-gray-600 mb-1">PAES Mínimo</label>
                <input type="number" value={paesMinimo} onChange={e => setPaesMinimo(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" />
              </div>
              <div className="col-span-3 flex gap-4">
                <label className="flex items-center gap-2 cursor-pointer">
                  <input type="checkbox" checked={esPrimerAnio} onChange={e => setEsPrimerAnio(e.target.checked)} className="w-4 h-4" />
                  <span className="text-xs text-gray-700">Para primer año</span>
                </label>
                <label className="flex items-center gap-2 cursor-pointer">
                  <input type="checkbox" checked={esCursoSuperior} onChange={e => setEsCursoSuperior(e.target.checked)} className="w-4 h-4" />
                  <span className="text-xs text-gray-700">Para curso superior</span>
                </label>
              </div>
            </div>
          </div>

          <div className="border-t pt-4">
            <h3 className="text-sm font-semibold text-gray-800 mb-2">Regiones</h3>
            <div className="flex flex-wrap gap-2">
              {regiones.map(r => (
                <button
                  key={r.idRegion}
                  type="button"
                  onClick={() => toggleRegion(r.idRegion)}
                  className={`px-3 py-1 text-xs rounded-full border transition cursor-pointer ${regionesIds.includes(r.idRegion) ? 'bg-blue-100 border-blue-400 text-blue-700' : 'bg-gray-50 border-gray-200 text-gray-600 hover:bg-gray-100'}`}
                >
                  {r.nombre}
                </button>
              ))}
            </div>
          </div>

          <div className="border-t pt-4">
            <div className="flex items-center justify-between mb-2">
              <h3 className="text-sm font-semibold text-gray-800">Documentos Requeridos</h3>
              <button type="button" onClick={addDocumento} className="flex items-center gap-1 text-xs text-blue-600 hover:text-blue-700 cursor-pointer">
                <Plus className="w-3 h-3" /> Agregar
              </button>
            </div>
            {documentos.map((doc, i) => (
              <div key={i} className="flex items-center gap-2 mb-2">
                <input
                  value={doc.nombreDocumento}
                  onChange={e => updateDocumento(i, 'nombreDocumento', e.target.value)}
                  placeholder="Nombre del documento"
                  className="flex-1 px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none"
                />
                <label className="flex items-center gap-1 text-xs text-gray-600 shrink-0 cursor-pointer">
                  <input type="checkbox" checked={doc.esObligatorio} onChange={e => updateDocumento(i, 'esObligatorio', e.target.checked)} className="w-3.5 h-3.5" />
                  Obligatorio
                </label>
                <button type="button" onClick={() => removeDocumento(i)} className="p-1 text-red-500 hover:bg-red-50 rounded cursor-pointer">
                  <Trash2 className="w-4 h-4" />
                </button>
              </div>
            ))}
          </div>

          <div className="flex justify-end gap-3 pt-4 border-t">
            <button type="button" onClick={onClose} className="px-4 py-2 text-sm border rounded-lg hover:bg-gray-50 cursor-pointer">Cancelar</button>
            <button type="submit" disabled={loading} className="px-4 py-2 text-sm bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 cursor-pointer">
              {loading ? 'Guardando...' : editId ? 'Actualizar' : 'Crear Beca'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
