import { useState, useEffect, useCallback, useRef } from 'react';
import { adminService } from '../../services/adminService';
import { becaService } from '../../services/becaService';
import type { BecaSummary, ImportResult } from '../../types';
import BecaForm from '../../components/admin/BecaForm';
import { Plus, Edit, Trash2, ExternalLink, Upload, X, Search as SearchIcon } from 'lucide-react';

export default function AdminBecasPage() {
  const [becas, setBecas] = useState<BecaSummary[]>([]);
  const [totalPages, setTotalPages] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [editId, setEditId] = useState<number | null>(null);
  const [editData, setEditData] = useState<Record<string, unknown> | null>(null);
  const [confirmDeleteId, setConfirmDeleteId] = useState<number | null>(null);
  const [showImport, setShowImport] = useState(false);
  const [importFile, setImportFile] = useState<File | null>(null);
  const [importResult, setImportResult] = useState<ImportResult | null>(null);
  const [importLoading, setImportLoading] = useState(false);
  const [searchText, setSearchText] = useState('');
  const fileInputRef = useRef<HTMLInputElement>(null);

  const fetchBecas = useCallback(async (p: number) => {
    setLoading(true);
    try {
      const { data } = await becaService.search({
        query: searchText || undefined,
        page: p,
        size: 50,
      });
      setBecas(data.data.content);
      setTotalPages(data.data.totalPages);
      setPage(data.data.number);
    } catch { setBecas([]); }
    finally { setLoading(false); }
  }, [searchText]);

  useEffect(() => { const t = setTimeout(() => fetchBecas(0), 400); return () => clearTimeout(t); }, [searchText]);
  useEffect(() => { fetchBecas(0); }, []);

  const displayed = becas;

  const handleEdit = async (id: number) => {
    try {
      const { data } = await adminService.getBeca(id);
      const d = data.data;
      setEditData({
        nombre: d.nombre,
        descripcionCorta: d.descripcionCorta,
        descripcionLarga: d.descripcionLarga,
        montoCobertura: d.montoCobertura,
        idTipoBeca: d.tipoBeca?.idTipoBeca,
        idInstitucion: d.institucion?.idInstitucion,
        fechaInicioPostulacion: d.fechaInicioPostulacion,
        fechaCierrePostulacion: d.fechaCierrePostulacion,
        urlOficial: d.urlOficial,
        estadoActiva: d.estadoActiva,
        regionesIds: d.regiones?.map(r => r.idRegion),
        rshMaximoPorcentaje: d.requisitoPerfil?.rshMaximoPorcentaje?.toString(),
        nemMinimo: d.requisitoPerfil?.nemMinimo?.toString(),
        paesMinimo: d.requisitoPerfil?.paesMinimo?.toString(),
        esParaPrimerAnio: d.requisitoPerfil?.esParaPrimerAnio,
        esParaCursoSuperior: d.requisitoPerfil?.esParaCursoSuperior,
        documentosRequeridos: d.documentosRequeridos,
      });
      setEditId(id);
      setShowForm(true);
    } catch {}
  };

  const handleDelete = async () => {
    if (!confirmDeleteId) return;
    await adminService.deleteBeca(confirmDeleteId);
    setConfirmDeleteId(null);
    fetchBecas(page);
  };

  const handleFormSave = () => {
    setShowForm(false);
    setEditId(null);
    setEditData(null);
    fetchBecas(0);
  };

  const formatDate = (d: string) => new Date(d).toLocaleDateString('es-CL');

  return (
    <div className="p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Gestión de Becas</h1>
          <p className="text-sm text-gray-500 mt-1">{becas.length} becas en total</p>
        </div>
        <div className="flex items-center gap-2">
          <div className="relative">
            <SearchIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input
              type="text"
              placeholder="Buscar beca..."
              value={searchText}
              onChange={e => setSearchText(e.target.value)}
              className="pl-9 pr-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none w-48"
            />
          </div>
          <button
            onClick={() => { setShowImport(true); setImportResult(null); setImportFile(null); }}
            className="flex items-center gap-2 px-4 py-2 border border-gray-300 text-gray-700 text-sm font-medium rounded-lg hover:bg-gray-50 cursor-pointer"
          >
            <Upload className="w-4 h-4" />
            Importar CSV
          </button>
          <button
            onClick={() => { setEditId(null); setEditData(null); setShowForm(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 cursor-pointer"
          >
            <Plus className="w-4 h-4" />
            Nueva Beca
          </button>
        </div>
      </div>

      {loading ? (
        <div className="space-y-3">
          {Array.from({ length: 5 }).map((_, i) => (
            <div key={i} className="h-16 bg-gray-100 rounded-lg animate-pulse" />
          ))}
        </div>
      ) : (
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-gray-50 text-left">
                <th className="px-4 py-3 font-medium text-gray-600">Nombre</th>
                <th className="px-4 py-3 font-medium text-gray-600 hidden md:table-cell">Institución</th>
                <th className="px-4 py-3 font-medium text-gray-600 hidden lg:table-cell">Cierre</th>
                <th className="px-4 py-3 font-medium text-gray-600">Estado</th>
                <th className="px-4 py-3 font-medium text-gray-600 w-24">Acciones</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {displayed.map(beca => (
                <tr key={beca.idBeca} className="hover:bg-gray-50">
                  <td className="px-4 py-3">
                    <span className="font-medium text-gray-800">{beca.nombre}</span>
                    <span className="block text-xs text-gray-400">{beca.nombreTipoBeca}</span>
                  </td>
                  <td className="px-4 py-3 text-gray-600 hidden md:table-cell">{beca.nombreInstitucion}</td>
                  <td className="px-4 py-3 text-gray-600 hidden lg:table-cell">{formatDate(beca.fechaCierrePostulacion)}</td>
                  <td className="px-4 py-3">
                    <span className={`text-xs font-medium px-2 py-1 rounded-full ${new Date(beca.fechaCierrePostulacion) > new Date() ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                      {new Date(beca.fechaCierrePostulacion) > new Date() ? 'Activa' : 'Expirada'}
                    </span>
                  </td>
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-1">
                      <a href={`/becas/${beca.idBeca}`} target="_blank" rel="noopener noreferrer" className="p-1.5 text-gray-400 hover:text-blue-600 hover:bg-blue-50 rounded cursor-pointer">
                        <ExternalLink className="w-4 h-4" />
                      </a>
                      <button onClick={() => handleEdit(beca.idBeca)} className="p-1.5 text-gray-400 hover:text-amber-600 hover:bg-amber-50 rounded cursor-pointer">
                        <Edit className="w-4 h-4" />
                      </button>
                      <button onClick={() => setConfirmDeleteId(beca.idBeca)} className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded cursor-pointer">
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
              {displayed.length === 0 && (
                <tr><td colSpan={5} className="px-4 py-8 text-center text-gray-400">No hay becas registradas</td></tr>
              )}
            </tbody>
          </table>
        </div>
      )}

      {totalPages > 1 && (
        <div className="flex items-center justify-center gap-1 mt-4">
          <button disabled={page === 0} onClick={() => fetchBecas(page - 1)}
            className="px-2.5 py-1 text-sm rounded border border-gray-300 disabled:opacity-40 hover:bg-gray-100 cursor-pointer">«</button>
          {Array.from({ length: Math.min(totalPages, 6) }, (_, i) => {
            let p: number;
            if (totalPages <= 6) { p = i; }
            else if (page < 3) { p = i; }
            else if (page > totalPages - 4) { p = totalPages - 6 + i; }
            else { p = page - 2 + i; }
            return (
              <button key={p} disabled={p === page}
                onClick={() => fetchBecas(p)}
                className={`w-7 h-7 text-xs rounded cursor-pointer ${p === page ? 'bg-blue-600 text-white font-medium' : 'border border-gray-300 hover:bg-gray-100'}`}>
                {p + 1}
              </button>
            );
          })}
          <button disabled={page >= totalPages - 1} onClick={() => fetchBecas(page + 1)}
            className="px-2.5 py-1 text-sm rounded border border-gray-300 disabled:opacity-40 hover:bg-gray-100 cursor-pointer">»</button>
        </div>
      )}

      {showForm && <BecaForm onClose={() => setShowForm(false)} onSave={handleFormSave} editId={editId} initialData={editData} />}

      {confirmDeleteId && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl shadow-xl p-6 max-w-sm mx-4">
            <h3 className="text-lg font-semibold mb-2">Confirmar eliminación</h3>
            <p className="text-sm text-gray-600 mb-4">¿Estás seguro de eliminar esta beca? Esta acción no se puede deshacer.</p>
            <div className="flex justify-end gap-3">
              <button onClick={() => setConfirmDeleteId(null)} className="px-4 py-2 text-sm border rounded-lg cursor-pointer">Cancelar</button>
              <button onClick={handleDelete} className="px-4 py-2 text-sm bg-red-600 text-white rounded-lg hover:bg-red-700 cursor-pointer">Eliminar</button>
            </div>
          </div>
        </div>
      )}

      {showImport && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl shadow-xl w-full max-w-md mx-4 p-6">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-semibold">Importar Becas desde CSV</h3>
              <button onClick={() => setShowImport(false)} className="p-1 hover:bg-gray-100 rounded cursor-pointer"><X className="w-5 h-5" /></button>
            </div>

            {importResult ? (
              <div className="space-y-3">
                <div className="grid grid-cols-3 gap-3">
                  <div className="p-3 bg-green-50 rounded-lg text-center">
                    <p className="text-2xl font-bold text-green-700">{importResult.creadas}</p>
                    <p className="text-xs text-green-600">Creadas</p>
                  </div>
                  <div className="p-3 bg-blue-50 rounded-lg text-center">
                    <p className="text-2xl font-bold text-blue-700">{importResult.actualizadas}</p>
                    <p className="text-xs text-blue-600">Actualizadas</p>
                  </div>
                  <div className="p-3 bg-red-50 rounded-lg text-center">
                    <p className="text-2xl font-bold text-red-700">{importResult.errores}</p>
                    <p className="text-xs text-red-600">Errores</p>
                  </div>
                </div>
                {importResult.mensajesError && importResult.mensajesError.length > 0 && (
                  <div className="p-3 bg-red-50 border border-red-200 rounded-lg max-h-32 overflow-y-auto">
                    {importResult.mensajesError.map((msg, i) => (
                      <p key={i} className="text-xs text-red-700">{msg}</p>
                    ))}
                  </div>
                )}
                <button onClick={() => { setShowImport(false); fetchBecas(0); }}
                  className="w-full py-2 bg-blue-600 text-white text-sm rounded-lg hover:bg-blue-700 cursor-pointer">
                  Cerrar
                </button>
              </div>
            ) : (
              <>
                <p className="text-sm text-gray-500 mb-4">
                  Selecciona un archivo CSV con las becas a importar. El sistema detectará duplicados y los actualizará automáticamente.
                </p>
                <input type="file" accept=".csv" ref={fileInputRef}
                  onChange={e => setImportFile(e.target.files?.[0] || null)}
                  className="w-full text-sm text-gray-600 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:bg-blue-50 file:text-blue-700 file:cursor-pointer hover:file:bg-blue-100" />
                <div className="flex justify-end gap-3 mt-4">
                  <button onClick={() => setShowImport(false)}
                    className="px-4 py-2 text-sm border rounded-lg hover:bg-gray-50 cursor-pointer">Cancelar</button>
                  <button
                    disabled={!importFile || importLoading}
                    onClick={async () => {
                      if (!importFile) return;
                      setImportLoading(true);
                      try {
                        const { data } = await adminService.importCsv(importFile);
                        setImportResult(data.data);
                      } catch (e) {
                        console.error(e);
                        const err = e as { response?: { data?: { message?: string; data?: { mensajesError?: string[] } } } };
                        const message = err?.response?.data?.data?.mensajesError?.[0]
                                     || err?.response?.data?.message
                                     || 'Error al importar el archivo';
                        setImportResult({ creadas: 0, actualizadas: 0, errores: 1, mensajesError: [message] });
                      }
                      finally { setImportLoading(false); }
                    }}
                    className="px-4 py-2 text-sm bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 cursor-pointer">
                    {importLoading ? 'Importando...' : 'Importar'}
                  </button>
                </div>
              </>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
