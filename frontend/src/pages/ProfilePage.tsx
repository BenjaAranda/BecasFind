import { useState, useEffect, useRef, type FormEvent } from 'react';
import { Link } from 'react-router-dom';
import { perfilService } from '../services/perfilService';
import { catalogoService } from '../services/becaService';
import { adminService } from '../services/adminService';
import type { Region, Institucion } from '../types';
import PublicNavbar from '../components/layout/PublicNavbar';
import { Save, ArrowRight } from 'lucide-react';

const initial = { rsh: '', nem: '', region: '', institution: '', career: '', firstYear: false, upperYear: false };
const inputClass = 'w-full min-h-12 px-3 py-2 border border-[#94a3b8] rounded-sm bg-white text-sm focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#0b3c75]';
const actionClass = 'min-h-12 px-5 py-3 bg-[#0b3c75] text-white rounded-sm hover:bg-[#082e5b] focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-[#0b3c75] disabled:opacity-50';

export default function ProfilePage() {
  const [form, setForm] = useState(initial);
  const [regions, setRegions] = useState<Region[]>([]);
  const [institutions, setInstitutions] = useState<Institucion[]>([]);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState('');
  const [retry, setRetry] = useState(0);
  const [saving, setSaving] = useState(false);
  const pending = useRef(false);
  const [success, setSuccess] = useState('');
  const [error, setError] = useState('');

  useEffect(() => {
    let active = true;
    Promise.all([catalogoService.getRegiones(), adminService.getInstituciones(), perfilService.getPerfil()])
      .then(([regionResponse, institutionResponse, profileResponse]) => {
        if (!active) return;
        setRegions(regionResponse.data.data);
        setInstitutions(institutionResponse.data.data);
        const p = profileResponse.data.data;
        setForm(p ? { rsh: p.rshPorcentaje?.toString() ?? '', nem: p.nemPromedio?.toString() ?? '',
          region: p.region?.idRegion?.toString() ?? '', institution: p.institucion?.idInstitucion?.toString() ?? '',
          career: p.carreraInteres ?? '', firstYear: !!p.esPrimerAnio, upperYear: !!p.esCursoSuperior } : initial);
        setLoadError('');
      }).catch(() => { if (active) setLoadError('No pudimos cargar tu perfil y sus opciones. Reintenta antes de editar para conservar tus datos.'); })
      .finally(() => { if (active) setLoading(false); });
    return () => { active = false; };
  }, [retry]);

  const change = <K extends keyof typeof initial>(key: K, value: typeof initial[K]) => {
    setForm(previous => ({ ...previous, [key]: value }));
    setSuccess('');
    setError('');
  };
  const handleSubmit = async (event: FormEvent) => {
    event.preventDefault();
    if (pending.current || loading || loadError) return;
    setError(''); setSuccess('');
    const rsh = form.rsh === '' ? null : Number(form.rsh);
    const nem = form.nem === '' ? null : Number(form.nem);
    if (rsh !== null && (!Number.isInteger(rsh) || rsh < 0 || rsh > 100)) { setError('El RSH debe ser un porcentaje entero entre 0 y 100.'); return; }
    if (nem !== null && (!Number.isFinite(nem) || nem < 1 || nem > 7 || Math.abs(nem * 10 - Math.round(nem * 10)) > 0.000001)) { setError('El NEM debe estar entre 1 y 7, con un máximo de un decimal.'); return; }
    if (form.career.trim().length > 255) { setError('La carrera debe tener como máximo 255 caracteres.'); return; }
    pending.current = true; setSaving(true);
    try {
      await perfilService.savePerfil({ rshPorcentaje: rsh, nemPromedio: nem,
        idRegion: form.region ? Number(form.region) : null, idInstitucion: form.institution ? Number(form.institution) : null,
        carreraInteres: form.career.trim() || null, esPrimerAnio: form.firstYear, esCursoSuperior: form.upperYear });
      setSuccess('Perfil guardado exitosamente');
    } catch (err: unknown) {
      const response = err as { response?: { data?: { message?: string } } };
      setError(response.response?.data?.message || 'No pudimos guardar tu perfil. Tus cambios siguen aquí; inténtalo nuevamente.');
    } finally { pending.current = false; setSaving(false); }
  };

  return <div className="min-h-screen bg-[#f8fafc] text-[#0b3c75]">
    <PublicNavbar />
    <main className="max-w-3xl mx-auto px-5 sm:px-8 py-10">
      <Link to="/explorar" className="inline-flex min-h-11 items-center text-sm underline underline-offset-4 focus-visible:outline-2">Volver al Buscador</Link>
      <p className="mt-6 mb-3 text-xs uppercase tracking-[0.2em] text-[#375b80]">Tu punto de partida</p>
      <h1 className="font-sans font-semibold text-4xl sm:text-5xl mb-4">Mi Perfil Académico</h1>
      <p className="text-slate-600 leading-relaxed mb-8">Las recomendaciones usan tu RSH, promedio NEM y región. Los campos son opcionales; dejar uno vacío omite ese criterio.</p>
      {loading ? <p role="status">Cargando tu perfil…</p> : loadError ? <div role="alert" className="border-l-2 border-red-700 bg-red-50 p-5 text-red-800"><p>{loadError}</p><button onClick={() => { setLoading(true); setRetry(value => value + 1); }} className="mt-3 min-h-11 underline focus-visible:outline-2">Reintentar</button></div> : <>
        {success && <p role="status" className="mb-5 p-4 bg-[#eff6ff] border border-[#cbd5e1]">{success}</p>}
        {error && <p role="alert" className="mb-5 border-l-2 border-red-700 bg-red-50 p-4 text-red-800">{error}</p>}
        <form onSubmit={handleSubmit} aria-busy={saving} className="bg-white border border-[#dbe3ed] p-5 sm:p-8">
          <fieldset disabled={saving} className="space-y-6 disabled:opacity-70">
            <legend className="font-sans font-semibold text-2xl mb-5">Datos para recomendar</legend>
            <div className="grid sm:grid-cols-2 gap-5">
              <div><label htmlFor="profile-rsh" className="block text-sm mb-2">RSH (%)</label><input id="profile-rsh" type="number" min="0" max="100" step="1" value={form.rsh} onChange={e => change('rsh', e.target.value)} className={inputClass} placeholder="Ej: 60" aria-describedby="rsh-help" /><p id="rsh-help" className="text-xs text-slate-600 mt-2">Porcentaje de tu Registro Social de Hogares.</p></div>
              <div><label htmlFor="profile-nem" className="block text-sm mb-2">NEM Promedio</label><input id="profile-nem" type="number" min="1" max="7" step="0.1" value={form.nem} onChange={e => change('nem', e.target.value)} className={inputClass} placeholder="Ej: 5.5" aria-describedby="nem-help" /><p id="nem-help" className="text-xs text-slate-600 mt-2">Promedio de enseñanza media. Actualmente se admite un decimal.</p></div>
              <div className="sm:col-span-2"><label htmlFor="profile-region" className="block text-sm mb-2">Región</label><select id="profile-region" value={form.region} onChange={e => change('region', e.target.value)} className={inputClass}><option value="">Sin especificar</option>{regions.map(r => <option key={r.idRegion} value={r.idRegion}>{r.nombre}</option>)}</select></div>
            </div>
            <div className="border-t border-[#dbe3ed] pt-6"><h2 className="font-sans font-semibold text-2xl mb-3">Tu información académica</h2><p className="text-sm text-slate-600 mb-5">Puedes guardar estos datos como referencia. La recomendación actual no evalúa institución, carrera ni año de estudio.</p>
              <div className="space-y-5"><div><label htmlFor="profile-institution" className="block text-sm mb-2">Institución</label><select id="profile-institution" value={form.institution} onChange={e => change('institution', e.target.value)} className={inputClass}><option value="">Sin especificar</option>{institutions.map(i => <option key={i.idInstitucion} value={i.idInstitucion}>{i.nombre}</option>)}</select></div>
              <div><label htmlFor="profile-career" className="block text-sm mb-2">Carrera de Interés</label><input id="profile-career" maxLength={255} value={form.career} onChange={e => change('career', e.target.value)} className={inputClass} placeholder="Ej: Ingeniería en Informática" /></div>
              <div className="flex flex-col sm:flex-row flex-wrap gap-3"><label className="flex min-h-11 items-center gap-3 text-sm"><input type="checkbox" checked={form.firstYear} onChange={e => change('firstYear', e.target.checked)} className="w-5 h-5 accent-[#0b3c75]" />Estudiante de primer año</label><label className="flex min-h-11 items-center gap-3 text-sm"><input type="checkbox" checked={form.upperYear} onChange={e => change('upperYear', e.target.checked)} className="w-5 h-5 accent-[#0b3c75]" />Estudiante de curso superior</label></div></div>
            </div>
            <button type="submit" className={`${actionClass} inline-flex items-center gap-3`}><Save size={18} aria-hidden="true" />{saving ? 'Guardando...' : 'Guardar Perfil'}</button>
          </fieldset>
        </form>
        <Link to="/explorar?mode=recomendar" className="mt-6 inline-flex min-h-12 items-center gap-4 underline underline-offset-4 focus-visible:outline-2">Ver recomendaciones con mi perfil guardado <ArrowRight size={18} aria-hidden="true" /></Link>
      </>}
      <p className="mt-5 text-sm text-slate-600">Una coincidencia no garantiza elegibilidad ni adjudicación. Consulta siempre los requisitos oficiales.</p>
    </main>
  </div>;
}
