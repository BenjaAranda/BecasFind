import { useState, useEffect, useCallback } from 'react';
import { adminService } from '../../services/adminService';
import type { UsuarioDTO } from '../../types';
import UsuarioForm from '../../components/admin/UsuarioForm';
import { Plus, UserX } from 'lucide-react';

export default function AdminUsuariosPage() {
  const [usuarios, setUsuarios] = useState<UsuarioDTO[]>([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [confirmDeactivateId, setConfirmDeactivateId] = useState<number | null>(null);

  const fetchUsuarios = useCallback(async () => {
    setLoading(true);
    try {
      const { data } = await adminService.getUsuarios();
      setUsuarios(data.data);
    } catch { setUsuarios([]); }
    finally { setLoading(false); }
  }, []);

  useEffect(() => { fetchUsuarios(); }, [fetchUsuarios]);

  const handleDeactivate = async () => {
    if (!confirmDeactivateId) return;
    await adminService.deactivateUsuario(confirmDeactivateId);
    setConfirmDeactivateId(null);
    fetchUsuarios();
  };

  const handleFormSave = () => {
    setShowForm(false);
    fetchUsuarios();
  };

  const formatDate = (d?: string) => d ? new Date(d).toLocaleDateString('es-CL') : '-';

  return (
    <div className="p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Gestión de Usuarios</h1>
          <p className="text-sm text-gray-500 mt-1">{usuarios.length} usuarios registrados</p>
        </div>
        <button
          onClick={() => setShowForm(true)}
          className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 cursor-pointer"
        >
          <Plus className="w-4 h-4" />
          Nuevo Usuario
        </button>
      </div>

      {loading ? (
        <div className="space-y-3">
          {Array.from({ length: 3 }).map((_, i) => (
            <div key={i} className="h-16 bg-gray-100 rounded-lg animate-pulse" />
          ))}
        </div>
      ) : (
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
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
                  <td className="px-4 py-3 font-medium text-gray-800">{u.nombreCompleto}</td>
                  <td className="px-4 py-3 text-gray-600 hidden md:table-cell">{u.email}</td>
                  <td className="px-4 py-3">
                    <span className={`text-xs font-medium px-2 py-1 rounded-full ${u.rol === 'ADMIN' ? 'bg-purple-100 text-purple-700' : 'bg-blue-100 text-blue-700'}`}>
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
                      <button
                        onClick={() => setConfirmDeactivateId(u.idUsuario)}
                        className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded cursor-pointer"
                        title="Desactivar usuario"
                      >
                        <UserX className="w-4 h-4" />
                      </button>
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

      {showForm && <UsuarioForm onClose={() => setShowForm(false)} onSave={handleFormSave} />}

      {confirmDeactivateId && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl shadow-xl p-6 max-w-sm mx-4">
            <h3 className="text-lg font-semibold mb-2">Confirmar desactivación</h3>
            <p className="text-sm text-gray-600 mb-4">¿Estás seguro de desactivar este usuario? No podrá iniciar sesión.</p>
            <div className="flex justify-end gap-3">
              <button onClick={() => setConfirmDeactivateId(null)} className="px-4 py-2 text-sm border rounded-lg cursor-pointer">Cancelar</button>
              <button onClick={handleDeactivate} className="px-4 py-2 text-sm bg-red-600 text-white rounded-lg hover:bg-red-700 cursor-pointer">Desactivar</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
