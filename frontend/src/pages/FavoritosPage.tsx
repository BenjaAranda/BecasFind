import { useState, useEffect, useRef } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { favoritoService } from '../services/favoritoService';
import type { BecaSummary } from '../types';
import BecaCard from '../components/common/BecaCard';
import PublicNavbar from '../components/layout/PublicNavbar';
import { Bookmark } from 'lucide-react';

export default function FavoritosPage() {
  const navigate = useNavigate();
  const [becas, setBecas] = useState<BecaSummary[]>([]);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState('');
  const [writeError, setWriteError] = useState('');
  const [status, setStatus] = useState('');
  const [retry, setRetry] = useState(0);
  const inFlight = useRef(new Set<string>());
  const [pending, setPending] = useState<Set<string>>(new Set());
  useEffect(() => {
    let active = true;
    const controller = new AbortController();
    favoritoService.listar(controller.signal)
      .then(({ data }) => { if (active) { setBecas(data.data); setLoadError(''); } })
      .catch(() => { if (active) setLoadError('No pudimos cargar tus favoritas. Revisa tu conexión e inténtalo nuevamente.'); })
      .finally(() => { if (active) setLoading(false); });
    return () => { active = false; controller.abort(); };
  }, [retry]);
  const remove = async (id: string) => {
    if (inFlight.current.has(id)) return;
    inFlight.current.add(id); setPending(new Set(inFlight.current)); setWriteError(''); setStatus('');
    try {
      await favoritoService.eliminar(id);
      setBecas(previous => previous.filter(b => b.idBeca !== id));
      setStatus('Beca quitada de favoritos.');
    } catch { setWriteError('No pudimos quitar la beca de favoritos. Sigue guardada; puedes volver a intentarlo.'); }
    finally { inFlight.current.delete(id); setPending(new Set(inFlight.current)); }
  };
  return <div className="min-h-screen bg-[#f5f3ed] text-[#123f48]">
    <PublicNavbar />
    <main className="max-w-6xl mx-auto px-5 sm:px-8 py-10">
      <Link to="/explorar" className="inline-flex min-h-11 items-center text-sm underline underline-offset-4 focus-visible:outline-2">Volver al Buscador</Link>
      <p className="mt-6 mb-3 text-xs uppercase tracking-[0.2em] text-[#46717a]">Tu selección de oportunidades</p>
      <h1 className="font-serif text-4xl sm:text-5xl mb-4">Mis Favoritos</h1>
      <p className="text-slate-600 mb-8 max-w-xl leading-relaxed">Vuelve a las becas que te interesan y compara sus condiciones. Guardarlas no realiza una postulación; revisa sus plazos y requisitos oficiales.</p>
      {status && <p role="status" className="mb-5 bg-[#e7eeea] p-4">{status}</p>}
      {writeError && <p role="alert" className="mb-5 bg-red-50 border-l-2 border-red-700 p-4 text-red-800">{writeError}</p>}
      {loading ? <p role="status">Cargando tus favoritas…</p> : loadError ? <div role="alert" className="bg-red-50 border-l-2 border-red-700 p-5 text-red-800"><p>{loadError}</p><button onClick={() => { setLoading(true); setRetry(value => value + 1); }} className="min-h-11 mt-2 underline focus-visible:outline-2">Reintentar</button></div> : becas.length ? <>
        <p className="mb-5 text-sm text-slate-600">{becas.length} beca{becas.length === 1 ? '' : 's'} guardada{becas.length === 1 ? '' : 's'}</p>
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-5">{becas.map(b => <BecaCard key={b.idBeca} beca={b} onClick={id => navigate(`/becas/${id}`)} isFavorito onToggleFavorito={remove} favoritoPending={pending.has(b.idBeca)} />)}</div>
      </> : <div className="border border-[#dce3df] bg-white p-8 sm:p-12 text-center"><Bookmark size={32} aria-hidden="true" className="mx-auto mb-5 text-[#46717a]" /><h2 className="font-serif text-2xl mb-3">No tienes becas guardadas</h2><p className="text-sm text-slate-600 mb-5">Usa el botón de favoritos en las tarjetas para reunir tus opciones aquí.</p><Link to="/explorar" className="inline-flex min-h-12 items-center px-5 bg-[#123f48] text-white focus-visible:outline-2 focus-visible:outline-offset-4">Explorar becas disponibles</Link></div>}
    </main>
  </div>;
}
