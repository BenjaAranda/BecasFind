import AdminDialog from '../../components/admin/AdminDialog';
import { useState, useEffect } from 'react';
import { adminService } from '../../services/adminService';
import type { UsuarioDTO } from '../../types';
import UsuarioForm from '../../components/admin/UsuarioForm';
import { Plus, UserX, Edit } from 'lucide-react';

export default function AdminUsuariosPage() {
  const [usuarios, setUsuarios] = useState<UsuarioDTO[]>([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [editUsuario, setEditUsuario] = useState<UsuarioDTO | null>(null);
  const [confirmDeactivateId, setConfirmDeactivateId] = useState<number | null>(null);

  const [error, setError] = useState('');
  const [deactivateError, setDeactivateError] = useState('');
  const [deactivating, setDeactivating] = useState(false);
  const [refresh, setRefresh] = useState(0);

  useEffect(() => {
    let active = true;
    const controller = new AbortController();
    adminService.getUsuarios(controller.signal)
      .then(({ data }) => { if (active) { setUsuarios(data.data); setError(''); } })
      .catch(() => { if (active) { setUsuarios([]); setError('No se pudieron cargar los usuarios.'); } })
      .finally(() => { if (active) setLoading(false); });
    return () => { active = false; controller.abort(); };
  }, [refresh]);

  const reload = () => { setLoading(true); setRefresh(v => v + 1); };

  const handleDeactivate = async () => {
    if (!confirmDeactivateId || deactivating) return;
    setDeactivating(true);
    setDeactivateError('');
    try {
      await adminService.deactivateUsuario(confirmDeactivateId);
      setConfirmDeactivateId(null);
      reload();
    } catch { setDeactivateError('No se pudo desactivar el usuario. Puedes reintentar.'); }
    finally { setDeactivating(false); }
  };

  const handleFormSave = () => {
    setShowForm(false);
    reload();
  };

  const formatDate = (d?: string) => d ? new Date(d).toLocaleDateString('es-CL') : '-';

  return (
    <div className="p-4 sm:p-6">
      <div className="flex flex-wrap items-center justify-between gap-4 mb-6">
        <div>
          <h1 className="text-2xl font-bold text-[#163b3b]">Gestión de Usuarios</h1>
          <p className="text-sm text-gray-500 mt-1">{usuarios.length} usuarios registrados</p>
        </div>
        <button
          onClick={() => { setEditUsuario(null); setShowForm(true); }}
          className="flex items-center gap-2 px-4 py-2 bg-[#163b3b] text-white text-sm font-medium rounded-lg hover:bg-[#245454] cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#326d68]"
        >
          <Plus className="w-4 h-4" />
          Nuevo Usuario
        </button>
      </div>

      {error && <p role="alert" className="mb-4 p-3 bg-red-50 text-red-700 rounded-lg">{error} <button onClick={reload} className="underline">Reintentar</button></p>}
      {loading ? (
        <div className="space-y-3">
          {Array.from({ length: 3 }).map((_, i) => (
            <div key={i} className="h-16 bg-gray-100 rounded-lg animate-pulse" />
          ))}
        </div>
      ) : (
        <div className="bg-[#fffdf7] rounded-xl shadow-sm border border-gray-100 overflow-x-auto">
          <table className="w-full min-w-[560px] text-sm">
            <thead>
              <tr className="bg-gray-50 text-left">
                <th className="px-4 py-3 font-medium text-gray-600">Nombre</th>
                <th className="px-4 py-3 font-medium text-gray-600 hidden md:table-cell">Email</th>
                <th className="px-4 py-3 font-medium text-gray-600">Rol</th>
                <th className="px-4 py-3 font-medium text-gray-600 hidden lg:table-cell">Creado</th>
                <th className="px-4 py-3 font-medium text-gray-600">Estado</th>
                <th className="px-4 py-3 font-medium text-gray-600 w-20">Acción</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {usuarios.map(u => (
                <tr key={u.idUsuario} className="hover:bg-gray-50">
                  <td className="px-4 py-3 font-medium text-[#163b3b]">{u.nombreCompleto}</td>
                  <td className="px-4 py-3 text-gray-600 hidden md:table-cell">{u.email}</td>
                  <td className="px-4 py-3">
                    <span className={`text-xs font-medium px-2 py-1 rounded-full ${u.rol === 'ADMIN' ? 'bg-[#efe8d5] text-[#685521]' : 'bg-[#e2eee8] text-[#245454]'}`}>
                      {u.rol}
                    </span>
                  </td>
                  <td className="px-4 py-3 text-gray-600 hidden lg:table-cell">{formatDate(u.creadoEn)}</td>
                  <td className="px-4 py-3">
                    <span className={`text-xs font-medium px-2 py-1 rounded-full ${u.activo ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                      {u.activo ? 'Activo' : 'Inactivo'}
                    </span>
                  </td>
                  <td className="px-4 py-3">
                    {u.activo && (
                      <div className="flex gap-2">
                      <button aria-label={`Editar ${u.nombreCompleto}`} onClick={() => { setEditUsuario(u); setShowForm(true); }}
                        className="p-1.5 text-[#245454] hover:bg-[#e2eee8] rounded cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2">
                        <Edit className="w-4 h-4" />
                      </button>
                      <button
                        aria-label={`Desactivar ${u.nombreCompleto}`} onClick={() => { setDeactivateError(''); setConfirmDeactivateId(u.idUsuario); }}
                        className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#326d68]"
                        title="Desactivar usuario"
                      >
                        <UserX className="w-4 h-4" />
                      </button>
                      </div>
                    )}
                  </td>
                </tr>
              ))}
              {usuarios.length === 0 && (
                <tr><td colSpan={6} className="px-4 py-8 text-center text-gray-400">No hay usuarios registrados</td></tr>
              )}
            </tbody>
          </table>
        </div>
      )}

      {showForm && <UsuarioForm usuario={editUsuario} onClose={() => setShowForm(false)} onSave={handleFormSave} />}

      {confirmDeactivateId && (
        <AdminDialog title="Confirmar desactivación" busy={deactivating} onClose={() => setConfirmDeactivateId(null)}>
          <div className="p-6">
            <h3 className="text-lg font-semibold mb-2">Confirmar desactivación</h3>
            <p className="text-sm text-gray-600 mb-4">¿Estás seguro de desactivar este usuario? No podrá iniciar sesión.</p>
            {deactivateError && <p role="alert" className="mb-3 text-red-700">{deactivateError}</p>}
            <div className="flex justify-end gap-3">
              <button disabled={deactivating} onClick={() => setConfirmDeactivateId(null)} className="px-4 py-2 text-sm border rounded-lg cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#326d68]">Cancelar</button>
              <button disabled={deactivating} onClick={handleDeactivate} className="px-4 py-2 text-sm bg-red-600 text-white rounded-lg hover:bg-red-700 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#326d68]">Desactivar</button>
            </div>
          </div>
        </AdminDialog>
      )}
    </div>
  );
}
