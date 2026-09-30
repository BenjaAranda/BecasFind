import AdminDialog from './AdminDialog';
import { useState } from 'react';
import { adminService } from '../../services/adminService';
import { X } from 'lucide-react';

interface UsuarioFormProps {
  onClose: () => void;
  onSave: () => void;
}

export default function UsuarioForm({ onClose, onSave }: UsuarioFormProps) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [nombreCompleto, setNombreCompleto] = useState('');
  const [idRol, setIdRol] = useState('2');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (loading) return;
    setError('');
    if (!nombreCompleto.trim() || new TextEncoder().encode(password).length > 72) {
      setError('Completa el nombre y usa una contraseña de hasta 72 bytes.');
      return;
    }
    setLoading(true);
    try {
      await adminService.createUsuario({
        email: email.trim(),
        password,
        nombreCompleto: nombreCompleto.trim(),
        idRol: Number(idRol),
      });
      onSave();
    } catch (err: unknown) {
      const axiosErr = err as { response?: { data?: { message?: string } } };
      setError(axiosErr.response?.data?.message || 'Error al crear el usuario');
    } finally {
      setLoading(false);
    }
  };

  return (
    <AdminDialog title="Nuevo usuario" busy={loading} onClose={onClose}>
        <div className="flex items-center justify-between p-4 border-b">
          <h2 className="text-lg font-semibold">Nuevo Usuario</h2>
          <button aria-label="Cerrar formulario" disabled={loading} onClick={onClose} className="p-1 hover:bg-gray-100 rounded cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#326d68]"><X className="w-5 h-5" /></button>
        </div>

        {error && <div role="alert" className="mx-4 mt-4 p-3 bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg">{error}</div>}

        <form onSubmit={handleSubmit} className="p-4 space-y-4">
          <fieldset disabled={loading} className="space-y-4 min-w-0">
          <div>
            <label htmlFor="beca-field-21" className="block text-sm font-medium text-gray-700 mb-1">Nombre Completo *</label>
            <input id="beca-field-21" autoComplete="name" maxLength={255} required value={nombreCompleto} onChange={e => setNombreCompleto(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#326d68] outline-none" />
          </div>
          <div>
            <label htmlFor="beca-field-22" className="block text-sm font-medium text-gray-700 mb-1">Email *</label>
            <input id="beca-field-22" type="email" autoComplete="email" maxLength={254} required value={email} onChange={e => setEmail(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#326d68] outline-none" />
          </div>
          <div>
            <label htmlFor="beca-field-23" className="block text-sm font-medium text-gray-700 mb-1">Contraseña *</label>
            <input id="beca-field-23" type="password" autoComplete="new-password" required minLength={8} maxLength={72} value={password} onChange={e => setPassword(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-[#326d68] outline-none" />
          </div>
          <div>
            <label htmlFor="beca-field-24" className="block text-sm font-medium text-gray-700 mb-1">Rol *</label>
            <select id="beca-field-24" value={idRol} onChange={e => setIdRol(e.target.value)} className="w-full px-3 py-2 border rounded-lg text-sm bg-[#fffdf7] focus:ring-2 focus:ring-[#326d68] outline-none">
              <option value="2">STUDENT</option>
              <option value="1">ADMIN</option>
            </select>
          </div>
          <div className="flex justify-end gap-3 pt-2">
            <button type="button" disabled={loading} onClick={onClose} className="px-4 py-2 text-sm border rounded-lg hover:bg-gray-50 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#326d68]">Cancelar</button>
            <button type="submit" disabled={loading} className="px-4 py-2 text-sm bg-[#163b3b] text-white rounded-lg hover:bg-[#245454] disabled:opacity-50 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#326d68]">
              {loading ? 'Creando...' : 'Crear Usuario'}
            </button>
          </div>
          </fieldset>
        </form>
    </AdminDialog>
  );
}
