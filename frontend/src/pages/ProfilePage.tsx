import { useState, useEffect, type FormEvent } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { perfilService } from '../services/perfilService';
import { catalogoService } from '../services/becaService';
import type { Region, Institucion } from '../types';
import { GraduationCap, Save, ArrowLeft } from 'lucide-react';

export default function ProfilePage() {
  const { user } = useAuth();
  const navigate = useNavigate();

  const [rsh, setRsh] = useState('');
  const [nem, setNem] = useState('');
  const [regionId, setRegionId] = useState('');
  const [institucionId, setInstitucionId] = useState('');
  const [carrera, setCarrera] = useState('');
  const [esPrimerAnio, setEsPrimerAnio] = useState(false);
  const [esCursoSuperior, setEsCursoSuperior] = useState(false);
  const [regiones, setRegiones] = useState<Region[]>([]);
  const [instituciones, setInstituciones] = useState<Institucion[]>([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [success, setSuccess] = useState('');
  const [error, setError] = useState('');

  useEffect(() => {
    Promise.all([
      catalogoService.getRegiones().then(r => setRegiones(r.data.data)),
      import('../services/adminService').then(m => m.adminService.getInstituciones()).then(r => setInstituciones(r.data.data)),
      perfilService.getPerfil().then(r => {
        if (r.data.data) {
          const p = r.data.data;
          setRsh(p.rshPorcentaje?.toString() || '');
          setNem(p.nemPromedio?.toString() || '');
          setRegionId(p.region?.idRegion?.toString() || '');
          setInstitucionId(p.institucion?.idInstitucion?.toString() || '');
          setCarrera(p.carreraInteres || '');
          setEsPrimerAnio(p.esPrimerAnio);
          setEsCursoSuperior(p.esCursoSuperior);
        }
      }).catch(() => {}),
    ]).finally(() => setLoading(false));
  }, []);

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setError('');
    setSuccess('');
    setSaving(true);
    try {
      await perfilService.savePerfil({
        rshPorcentaje: rsh ? Number(rsh) : null,
        nemPromedio: nem ? Number(nem) : null,
        idRegion: regionId ? Number(regionId) : null,
        idInstitucion: institucionId ? Number(institucionId) : null,
        carreraInteres: carrera || null,
        esPrimerAnio,
        esCursoSuperior,
      });
      setSuccess('Perfil guardado exitosamente');
    } catch (err: unknown) {
      console.error('Error al guardar perfil:', err);
      const axiosErr = err as { response?: { data?: { message?: string } } };
      setError(axiosErr.response?.data?.message || 'Error al guardar el perfil');
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-blue-600" />
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-white border-b border-gray-200">
        <div className="max-w-2xl mx-auto px-4 h-14 flex items-center justify-between">
          <div className="flex items-center gap-2 cursor-pointer" onClick={() => navigate('/explorar')}>
            <GraduationCap className="w-6 h-6 text-blue-600" />
            <span className="font-bold text-lg text-gray-800">BecasFind</span>
          </div>
          <span className="text-sm text-gray-500">{user?.email}</span>
        </div>
      </header>

      <main className="max-w-2xl mx-auto px-4 py-6">
        <button onClick={() => navigate('/explorar')} className="flex items-center gap-1 text-sm text-gray-500 hover:text-blue-600 mb-3 cursor-pointer">
          <ArrowLeft className="w-4 h-4" /> Volver al Buscador
        </button>
        <h1 className="text-2xl font-bold text-gray-800 mb-6">Mi Perfil Académico</h1>

        {success && <div className="mb-4 p-3 bg-green-50 border border-green-200 text-green-700 text-sm rounded-lg">{success}</div>}
        {error && <div className="mb-4 p-3 bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg">{error}</div>}

        <form onSubmit={handleSubmit} className="bg-white rounded-xl shadow-sm border border-gray-100 p-6 space-y-4">
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">RSH (%)</label>
              <input type="number" min="0" max="100" value={rsh} onChange={e => setRsh(e.target.value)}
                className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" placeholder="Ej: 60" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">NEM Promedio</label>
              <input type="number" min="1.0" max="7.0" step="0.1" value={nem} onChange={e => setNem(e.target.value)}
                className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" placeholder="Ej: 5.5" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Región</label>
              <select value={regionId} onChange={e => setRegionId(e.target.value)}
                className="w-full px-3 py-2 border rounded-lg text-sm bg-white focus:ring-2 focus:ring-blue-500 outline-none">
                <option value="">Seleccionar</option>
                {regiones.map(r => <option key={r.idRegion} value={r.idRegion}>{r.nombre}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Institución</label>
              <select value={institucionId} onChange={e => setInstitucionId(e.target.value)}
                className="w-full px-3 py-2 border rounded-lg text-sm bg-white focus:ring-2 focus:ring-blue-500 outline-none">
                <option value="">Seleccionar</option>
                {instituciones.map(i => <option key={i.idInstitucion} value={i.idInstitucion}>{i.nombre}</option>)}
              </select>
            </div>
            <div className="sm:col-span-2">
              <label className="block text-sm font-medium text-gray-700 mb-1">Carrera de Interés</label>
              <input type="text" value={carrera} onChange={e => setCarrera(e.target.value)}
                className="w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" placeholder="Ej: Ingeniería en Informática" />
            </div>
            <div className="sm:col-span-2 flex gap-4">
              <label className="flex items-center gap-2 cursor-pointer">
                <input type="checkbox" checked={esPrimerAnio} onChange={e => setEsPrimerAnio(e.target.checked)} className="w-4 h-4" />
                <span className="text-sm text-gray-700">Estudiante de primer año</span>
              </label>
              <label className="flex items-center gap-2 cursor-pointer">
                <input type="checkbox" checked={esCursoSuperior} onChange={e => setEsCursoSuperior(e.target.checked)} className="w-4 h-4" />
                <span className="text-sm text-gray-700">Estudiante de curso superior</span>
              </label>
            </div>
          </div>

          <button type="submit" disabled={saving}
            className="flex items-center gap-2 px-6 py-2.5 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 disabled:opacity-50 cursor-pointer">
            <Save className="w-4 h-4" />
            {saving ? 'Guardando...' : 'Guardar Perfil'}
          </button>
        </form>

        <p className="mt-4 text-sm text-gray-400 text-center">
          Tus datos se usan para recomendarte becas que se ajusten a tu perfil
        </p>
      </main>
    </div>
  );
}
