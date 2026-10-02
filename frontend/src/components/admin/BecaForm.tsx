import AdminDialog from './AdminDialog';
import { useState, useEffect } from 'react';
import type { TipoBeca, Institucion, Region, Cobertura } from '../../types';
import CoberturaFields from './CoberturaFields';
import { coverageError } from './coverageValidation';
import { authFormError } from '../../utils/authFormError';
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

  const d = initialData ?? {};
  const [catalogLoading, setCatalogLoading] = useState(true);
  const [catalogVersion, setCatalogVersion] = useState(0);

  const [nombre, setNombre] = useState(() => String(d.nombre ?? ''));
  const [descripcionCorta, setDescripcionCorta] = useState(() => String(d.descripcionCorta ?? ''));
  const [descripcionLarga, setDescripcionLarga] = useState(() => String(d.descripcionLarga ?? ''));
  const [montoCobertura, setMontoCobertura] = useState(() => String(d.montoCobertura ?? ''));
  const [cobertura, setCobertura] = useState<Cobertura>(() => (d.cobertura as Cobertura | undefined) ?? { tipo: 'DESCONOCIDA' });
  const [idTipoBeca, setIdTipoBeca] = useState(() => String(d.idTipoBeca ?? ''));
  const [idInstitucion, setIdInstitucion] = useState(() => String(d.idInstitucion ?? ''));
  const [fechaInicio, setFechaInicio] = useState(() => String(d.fechaInicioPostulacion ?? ''));
  const [fechaCierre, setFechaCierre] = useState(() => String(d.fechaCierrePostulacion ?? ''));
  const [urlOficial, setUrlOficial] = useState(() => String(d.urlOficial ?? ''));
  const [estadoActiva, setEstadoActiva] = useState(d.estadoActiva !== false);
  const [regionesIds, setRegionesIds] = useState<number[]>(() => (d.regionesIds as number[]) ?? []);
  const [rshMaximo, setRshMaximo] = useState(() => String(d.rshMaximoPorcentaje ?? ''));
  const [nemMinimo, setNemMinimo] = useState(() => String(d.nemMinimo ?? ''));
  const [paesMinimo, setPaesMinimo] = useState(() => String(d.paesMinimo ?? ''));
  const [esPrimerAnio, setEsPrimerAnio] = useState(Boolean(d.esParaPrimerAnio));
  const [esCursoSuperior, setEsCursoSuperior] = useState(Boolean(d.esParaCursoSuperior));
  const [documentos, setDocumentos] = useState<{ nombreDocumento: string; esObligatorio: boolean }[]>(() => (d.documentosRequeridos as { nombreDocumento: string; esObligatorio: boolean }[]) ?? []);

  useEffect(() => {
    let active = true;
    Promise.all([adminService.getTiposBeca(), adminService.getInstituciones(), adminService.getRegiones()])
      .then(([tipos, instituciones, regiones]) => {
        if (!active) return;
        setTiposBeca(tipos.data.data);
        setInstituciones(instituciones.data.data);
        setRegiones(regiones.data.data);
      })
      .catch(() => { if (active) setError('No se pudieron cargar los catálogos. Reintenta antes de guardar.'); })
      .finally(() => { if (active) setCatalogLoading(false); });
    return () => { active = false; };
  }, [catalogVersion]);

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
    if (loading || catalogLoading || !tiposBeca.length || !instituciones.length) return;
    setError('');
    const invalidCoverage = coverageError(cobertura);
    if (invalidCoverage) { setError(invalidCoverage); return; }
    if (!nombre.trim() || documentos.some(doc => !doc.nombreDocumento.trim())) {
      setError('Completa el nombre de la beca y de cada documento.');
      return;
    }
    if (fechaInicio && fechaCierre && fechaInicio > fechaCierre) {
      setError('La fecha de cierre debe ser igual o posterior al inicio.');
      return;
    }
    if (urlOficial && !/^https?:\/\//i.test(urlOficial)) {
      setError('La URL oficial debe comenzar con https:// o http://.');
      return;
    }
    setLoading(true);

    const payload: Record<string, unknown> = {
      nombre: nombre.trim(),
      descripcionCorta: descripcionCorta || null,
      descripcionLarga: descripcionLarga || null,
      montoCobertura: montoCobertura || null,
      cobertura,
      idTipoBeca: Number(idTipoBeca),
      idInstitucion: Number(idInstitucion),
      fechaInicioPostulacion: fechaInicio || null,
      fechaCierrePostulacion: fechaCierre || null,
      version: d.version,
      urlOficial: urlOficial || null,
      estadoActiva,
      regionesIds,
      rshMaximoPorcentaje: rshMaximo ? Number(rshMaximo) : null,
      nemMinimo: nemMinimo ? Number(nemMinimo) : null,
      paesMinimo: paesMinimo ? Number(paesMinimo) : null,
      esParaPrimerAnio: esPrimerAnio,
      esParaCursoSuperior: esCursoSuperior,
      documentosRequeridos: documentos.map(doc => ({ nombreDocumento: doc.nombreDocumento.trim(), esObligatorio: doc.esObligatorio })),
    };

    try {
      if (editId) await adminService.updateBeca(editId, payload);
      else await adminService.createBeca(payload);
      onSave();
    } catch (err: unknown) {
      setError(authFormError(err, 'Error al guardar la beca. Conservamos tus cambios para reintentar.'));
    } finally {
      setLoading(false);
    }
  };

  return (
    <AdminDialog title={editId ? 'Editar beca' : 'Nueva beca'} busy={loading} onClose={onClose} wide>
        <div className="flex items-center justify-between p-4 border-b">
          <h2 className="text-lg font-semibold">{editId ? 'Editar Beca' : 'Nueva Beca'}</h2>
          <button aria-label="Cerrar formulario" disabled={loading} onClick={onClose} className="p-1 hover:bg-gray-100 rounded cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#164e8c]"><X className="w-5 h-5" /></button>
        </div>

        {error && <div role="alert" className="mx-4 mt-4 p-3 bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg">{error}</div>}

        {!catalogLoading && (!tiposBeca.length || !instituciones.length) && <button type="button" onClick={() => { setCatalogLoading(true); setError(''); setCatalogVersion(v => v + 1); }} className="m-4 text-[#0b3c75] underline">Reintentar catálogos</button>}
        {catalogLoading && <p role="status" className="m-4 text-sm">Cargando catálogos…</p>}
        <form onSubmit={handleSubmit} className="p-4 space-y-4 max-h-[70vh] overflow-y-auto">
          <fieldset disabled={loading} className="space-y-4 min-w-0">
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div className="sm:col-span-2">
              <label htmlFor="beca-field-1" className="block text-sm font-medium text-gray-700 mb-1">Nombre *</label>
              <input id="beca-field-1" required value={nombre} onChange={e => setNombre(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none" />
            </div>
            <div>
              <label htmlFor="beca-field-2" className="block text-sm font-medium text-gray-700 mb-1">Tipo Beca *</label>
              <select id="beca-field-2" required value={idTipoBeca} onChange={e => setIdTipoBeca(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm bg-[#ffffff] focus:ring-2 focus:ring-[#164e8c] outline-none">
                <option value="">Seleccionar</option>
                {tiposBeca.map(t => <option key={t.idTipoBeca} value={t.idTipoBeca}>{t.nombre}</option>)}
              </select>
            </div>
            <div>
              <label htmlFor="beca-field-3" className="block text-sm font-medium text-gray-700 mb-1">Institución *</label>
              <select id="beca-field-3" required value={idInstitucion} onChange={e => setIdInstitucion(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm bg-[#ffffff] focus:ring-2 focus:ring-[#164e8c] outline-none">
                <option value="">Seleccionar</option>
                {instituciones.map(i => <option key={i.idInstitucion} value={i.idInstitucion}>{i.nombre}</option>)}
              </select>
            </div>
            <div>
              <label htmlFor="beca-field-4" className="block text-sm font-medium text-gray-700 mb-1">Monto Cobertura</label>
              <input id="beca-field-4" value={montoCobertura} onChange={e => setMontoCobertura(e.target.value)} placeholder="Ej: $600.000 anual" className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none" />
            </div>
            <div>
              <label htmlFor="beca-field-5" className="block text-sm font-medium text-gray-700 mb-1">URL Oficial</label>
              <input id="beca-field-5" type="url" value={urlOficial} onChange={e => setUrlOficial(e.target.value)} placeholder="https://..." className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none" />
            </div>
            <div>
              <label htmlFor="beca-field-6" className="block text-sm font-medium text-gray-700 mb-1">Inicio Postulación</label>
              <input id="beca-field-6" type="date" value={fechaInicio} onChange={e => setFechaInicio(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none" />
            </div>
            <div>
              <label htmlFor="beca-field-7" className="block text-sm font-medium text-gray-700 mb-1">Cierre Postulación</label>
              <input id="beca-field-7" type="date" aria-describedby="closing-date-help" value={fechaCierre} onChange={e => setFechaCierre(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none" />
            </div>
            <p id="closing-date-help" className="sm:col-span-2 text-sm text-gray-600">Si el cierre no está confirmado, déjalo vacío. La beca no aparecerá en la búsqueda vigente.</p>
            <div className="sm:col-span-2">
              <label htmlFor="beca-field-8" className="block text-sm font-medium text-gray-700 mb-1">Descripción Corta</label>
              <textarea id="beca-field-8" value={descripcionCorta} onChange={e => setDescripcionCorta(e.target.value)} rows={2} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none" />
            </div>
            <div className="sm:col-span-2">
              <label htmlFor="beca-field-9" className="block text-sm font-medium text-gray-700 mb-1">Descripción Larga</label>
              <textarea id="beca-field-9" value={descripcionLarga} onChange={e => setDescripcionLarga(e.target.value)} rows={3} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none" />
            </div>
            <div className="sm:col-span-2">
              <label className="flex items-center gap-2 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#164e8c]">
                <input type="checkbox" checked={estadoActiva} onChange={e => setEstadoActiva(e.target.checked)} className="w-4 h-4" />
                <span className="text-sm text-gray-700">Beca activa</span>
              </label>
            </div>
          </div>

          <CoberturaFields value={cobertura} onChange={setCobertura} />

          <div className="border-t pt-4">
            <h3 className="text-sm font-semibold text-[#16324f] mb-2">Requisitos del Perfil</h3>
            <div className="grid grid-cols-3 gap-3">
              <div>
                <label htmlFor="beca-field-10" className="block text-xs text-gray-600 mb-1">RSH Máximo (%)</label>
                <input id="beca-field-10" type="number" min="0" max="100" value={rshMaximo} onChange={e => setRshMaximo(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none" />
              </div>
              <div>
                <label htmlFor="beca-field-11" className="block text-xs text-gray-600 mb-1">NEM Mínimo</label>
                <input id="beca-field-11" type="number" min="1" max="7" step="0.01" value={nemMinimo} onChange={e => setNemMinimo(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none" />
              </div>
              <div>
                <label htmlFor="beca-field-12" className="block text-xs text-gray-600 mb-1">PAES Mínimo</label>
                <input id="beca-field-12" type="number" min="0" max="1000" value={paesMinimo} onChange={e => setPaesMinimo(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none" />
              </div>
              <div className="col-span-3 flex gap-4">
                <label className="flex items-center gap-2 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#164e8c]">
                  <input type="checkbox" checked={esPrimerAnio} onChange={e => setEsPrimerAnio(e.target.checked)} className="w-4 h-4" />
                  <span className="text-xs text-gray-700">Para primer año</span>
                </label>
                <label className="flex items-center gap-2 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#164e8c]">
                  <input type="checkbox" checked={esCursoSuperior} onChange={e => setEsCursoSuperior(e.target.checked)} className="w-4 h-4" />
                  <span className="text-xs text-gray-700">Para curso superior</span>
                </label>
              </div>
            </div>
          </div>

          <div className="border-t pt-4">
            <h3 className="text-sm font-semibold text-[#16324f] mb-2">Regiones</h3>
            <p className="text-xs text-gray-500 mb-2">Sin regiones seleccionadas: cobertura nacional.</p>
            <div className="flex flex-wrap gap-2">
              {regiones.map(r => (
                <button
                  key={r.idRegion}
                  type="button"
                  aria-pressed={regionesIds.includes(r.idRegion)} onClick={() => toggleRegion(r.idRegion)}
                  className={`px-3 py-1 text-xs rounded-full border transition cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#164e8c] ${regionesIds.includes(r.idRegion) ? 'bg-[#eff6ff] border-blue-400 text-[#0b3c75]' : 'bg-gray-50 border-gray-200 text-gray-600 hover:bg-gray-100'}`}
                >
                  {r.nombre}
                </button>
              ))}
            </div>
          </div>

          <div className="border-t pt-4">
            <div className="flex items-center justify-between mb-2">
              <h3 className="text-sm font-semibold text-[#16324f]">Documentos Requeridos</h3>
              <button type="button" onClick={addDocumento} className="flex items-center gap-1 text-xs text-blue-600 hover:text-[#0b3c75] cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#164e8c]">
                <Plus className="w-3 h-3" /> Agregar
              </button>
            </div>
            {documentos.map((doc, i) => (
              <div key={i} className="flex items-center gap-2 mb-2">
                <input
                  required aria-label={`Nombre del documento ${i + 1}`} value={doc.nombreDocumento}
                  onChange={e => updateDocumento(i, 'nombreDocumento', e.target.value)}
                  placeholder="Nombre del documento"
                  className="flex-1 px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#164e8c] outline-none"
                />
                <label className="flex items-center gap-1 text-xs text-gray-600 shrink-0 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#164e8c]">
                  <input type="checkbox" checked={doc.esObligatorio} onChange={e => updateDocumento(i, 'esObligatorio', e.target.checked)} className="w-3.5 h-3.5" />
                  Obligatorio
                </label>
                <button type="button" aria-label={`Eliminar documento ${i + 1}`} onClick={() => removeDocumento(i)} className="p-1 text-red-500 hover:bg-red-50 rounded cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#164e8c]">
                  <Trash2 className="w-4 h-4" />
                </button>
              </div>
            ))}
          </div>

          <div className="flex justify-end gap-3 pt-4 border-t">
            <button type="button" disabled={loading} onClick={onClose} className="px-4 py-2 text-sm border rounded-lg hover:bg-gray-50 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#164e8c]">Cancelar</button>
            <button type="submit" disabled={loading || catalogLoading || !tiposBeca.length || !instituciones.length} className="px-4 py-2 text-sm bg-[#16324f] text-white rounded-lg hover:bg-[#0b3c75] disabled:opacity-50 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#164e8c]">
              {loading ? 'Guardando...' : editId ? 'Actualizar' : 'Crear Beca'}
            </button>
          </div>
          </fieldset>
        </form>
    </AdminDialog>
  );
}
