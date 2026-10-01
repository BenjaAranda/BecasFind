import { useState, useEffect, useRef } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { becaService } from '../services/becaService';
import { useAuth } from '../context/useAuth';
import { favoritoService } from '../services/favoritoService';
import type { BecaSummary } from '../types';
import SearchFilters from '../components/common/SearchFilters';
import BecaCard from '../components/common/BecaCard';
import { Search, Sparkles } from 'lucide-react';
import PublicNavbar from '../components/layout/PublicNavbar';

export default function SearchPage() {
  const navigate = useNavigate();
  const { isAuthenticated } = useAuth();
  const [searchParams, setSearchParams] = useSearchParams();

  // La URL conserva filtros, pestaña y página al volver desde un detalle.
  const paramsKey = searchParams.toString();
  const rsh = searchParams.get('rsh') || '';
  const nem = searchParams.get('nem') || '';
  const regionId = searchParams.get('region') || '';
  const query = searchParams.get('q') || '';
  const idTipoBeca = searchParams.get('tipo') || '';
  const idInstitucion = searchParams.get('inst') || '';
  const idTipoInstitucion = searchParams.get('cat') || '';
  const sort = searchParams.get('sort') || 'fechaAsc';
  const page = Math.max(0, Number.parseInt(searchParams.get('page') || '0') || 0);
  const requestedSize = Number(searchParams.get('size') || 12);
  const pageSize = [12, 50, 100].includes(requestedSize) ? requestedSize : 12;
  const tab = isAuthenticated && searchParams.get('mode') === 'recomendar' ? 'recomendar' : 'buscar';
  const [becas, setBecas] = useState<BecaSummary[]>([]);
  const [loading, setLoading] = useState(true);
  const [totalElements, setTotalElements] = useState(0);
  const [totalPages, setTotalPages] = useState(0);
  const [error, setError] = useState('');
  const [requestVersion, setRequestVersion] = useState(0);
  const urgent = useRef(true);
  const [favIds, setFavIds] = useState<Set<string>>(new Set());
  const pendingFavoriteIds = useRef(new Set<string>());
  const [pendingFavorites, setPendingFavorites] = useState<Set<string>>(new Set());
  const [favoriteError, setFavoriteError] = useState('');

  useEffect(() => {
    const params = new URLSearchParams(paramsKey);
    const controller = new AbortController();
    let active = true;
    const delay = urgent.current ? 0 : 400;
    urgent.current = false;
    const timer = setTimeout(async () => {
      setLoading(true);
      setError('');
      const p = Math.max(0, Number.parseInt(params.get('page') || '0') || 0);
      const sz = Number(params.get('size') || 12);
      const size = [12, 50, 100].includes(sz) ? sz : 12;
      const number = (key: string) => params.get(key) ? Number(params.get(key)) : undefined;
      try {
        if (['rsh', 'nem', 'region', 'tipo', 'inst', 'cat'].some(key => params.has(key) && !Number.isFinite(number(key)))) {
          throw new Error('Filtro numérico no válido');
        }
        const response = isAuthenticated && params.get('mode') === 'recomendar'
          ? await becaService.recomendar(p, size, controller.signal)
          : await becaService.search({ rsh: number('rsh'), nem: number('nem'), regionId: number('region'),
            query: params.get('q') || undefined, idTipoBeca: number('tipo'), idInstitucion: number('inst'),
            idTipoInstitucion: number('cat'), sort: params.get('sort') || 'fechaAsc', page: p, size }, controller.signal);
        if (!active) return;
        setBecas(response.data.data.content);
        setTotalElements(response.data.data.totalElements);
        setTotalPages(response.data.data.totalPages);
      } catch {
        if (!active) return;
        setBecas([]);
        setTotalElements(0);
        setTotalPages(0);
        setError('No pudimos cargar las becas. Revisa los filtros y tu conexión, e inténtalo de nuevo.');
      } finally {
        if (active) setLoading(false);
      }
    }, delay);
    return () => { active = false; clearTimeout(timer); controller.abort(); };
  }, [paramsKey, requestVersion, isAuthenticated]);

  useEffect(() => {
    if (!isAuthenticated) return;
    let active = true;
    favoritoService.listar().then(({ data }) => {
      if (active) setFavIds(new Set(data.data.map(b => b.idBeca)));
    }).catch(() => { /* La búsqueda sigue disponible si no se cargan favoritos. */ });
    return () => { active = false; };
  }, [isAuthenticated]);

  const updateParam = (key: string, value: string, immediate = false) => {
    urgent.current = immediate;
    setSearchParams(previous => {
      const next = new URLSearchParams(previous);
      if (value) next.set(key, value); else next.delete(key);
      if (key !== 'page') next.delete('page');
      return next;
    }, { replace: true });
  };
  const handleSearch = () => { urgent.current = true; setRequestVersion(value => value + 1); };
  const handlePageChange = (p: number) => updateParam('page', String(p), true);
  const handleReset = () => {
    urgent.current = true;
    setSearchParams(new URLSearchParams(), { replace: true });
    setRequestVersion(value => value + 1);
  };

  const handleToggleFavorito = async (idBeca: string) => {
    if (!isAuthenticated) { navigate('/login'); return; }
    if (pendingFavoriteIds.current.has(idBeca)) return;
    pendingFavoriteIds.current.add(idBeca);
    setPendingFavorites(new Set(pendingFavoriteIds.current));
    setFavoriteError('');
    const wasFav = favIds.has(idBeca);
    setFavIds(prev => {
      const n = new Set(prev);
      if (wasFav) n.delete(idBeca); else n.add(idBeca);
      return n;
    });
    try {
      if (wasFav) await favoritoService.eliminar(idBeca);
      else await favoritoService.guardar(idBeca);
    } catch {
      setFavoriteError('No pudimos actualizar tus favoritos. Inténtalo nuevamente.');
      setFavIds(prev => {
        const n = new Set(prev);
        if (wasFav) n.add(idBeca); else n.delete(idBeca);
        return n;
      });
    } finally {
      pendingFavoriteIds.current.delete(idBeca);
      setPendingFavorites(new Set(pendingFavoriteIds.current));
    }
  };

  return (
    <div className="min-h-screen bg-[#f5f3ed]">
      <PublicNavbar />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 pt-10 pb-8 border-b border-[#dce3df]">
        <p className="text-xs uppercase tracking-[0.2em] text-[#46717a] mb-3">Oportunidades para estudiar</p>
        <h1 className="font-serif text-4xl sm:text-5xl text-[#123f48] leading-tight">Tu próximo paso empieza aquí.</h1>
        <p className="mt-4 max-w-2xl text-slate-600 leading-relaxed">Explora becas y beneficios. Compara sus requisitos y consulta la convocatoria oficial antes de postular.</p>
      </div>
      {!isAuthenticated && <div className="max-w-7xl mx-auto px-4 sm:px-6 pt-6 text-sm text-[#123f48]">
        <p>Explora gratis y sin cuenta. Inicia sesión como estudiante para guardar tu perfil y favoritos, o como administrador para gestionar BecasFind.</p>
        <Link to="/login" className="inline-block mt-2 underline underline-offset-4 focus-visible:outline-2 focus-visible:outline-offset-2">Iniciar sesión para guardar mis datos o administrar</Link>
      </div>}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 py-8 flex flex-col lg:flex-row gap-8">
        <aside className="lg:w-72 shrink-0">
          {tab === 'buscar' ? (
            <>
              <SearchFilters
                rsh={rsh} nem={nem} regionId={regionId}
                query={query} idTipoBeca={idTipoBeca} idInstitucion={idInstitucion} idTipoInstitucion={idTipoInstitucion} sort={sort}
                onRshChange={value => updateParam('rsh', value)} onNemChange={value => updateParam('nem', value)} onRegionChange={value => updateParam('region', value)}
                onQueryChange={value => updateParam('q', value)} onTipoBecaChange={value => updateParam('tipo', value)}
                onInstitucionChange={value => updateParam('inst', value)} onTipoInstitucionChange={value => updateParam('cat', value)} onSortChange={value => updateParam('sort', value)}
                onSearch={handleSearch}
                onReset={handleReset}
              />
              <div className="mt-4 p-4 bg-[#e7eeea] rounded-sm border border-[#c5d5d0]">
                <p className="text-xs text-[#123f48] font-medium mb-1">¿Cómo funciona?</p>
                <ul className="text-xs text-[#123f48] space-y-1">
                  <li>• RSH: ingresas tu %, ves becas que acepten ≥ ese valor</li>
                  <li>• NEM: ingresas tu promedio, ves becas con mínimo ≤ tu nota</li>
                  <li>• Región: filtra becas locales o de alcance nacional</li>
                  <li>• Becas vencidas se excluyen automáticamente</li>
                </ul>
              </div>
            </>
          ) : (
            <div className="bg-white rounded-sm shadow-none border border-[#dce3df] p-5">
              <div className="flex items-center gap-2 mb-3">
                <Sparkles className="w-5 h-5 text-amber-500" />
                <h3 className="font-semibold text-[#123f48]">Recomendadas para ti</h3>
              </div>
              <p className="text-sm text-slate-600 mb-4">
                Basadas en tu RSH, NEM y región guardados. Revisa los requisitos oficiales: una recomendación no garantiza que puedas postular.
              </p>
              <button
                onClick={() => navigate('/perfil')}
                className="w-full py-2 text-sm bg-amber-50 text-amber-700 rounded-sm hover:bg-amber-100 cursor-pointer"
              >
                Configurar mi perfil
              </button>
            </div>
          )}
        </aside>

        <section aria-label="Resultados de búsqueda" aria-busy={loading} className="flex-1 min-w-0">
          {tab === 'buscar' && sort.startsWith('monto') && <p id="coverage-order-note" role="note" className="mb-4 border-l-2 border-[#123f48] bg-[#eaf0eb] p-3 text-sm text-[#123f48]">
            Agrupamos por moneda y periodicidad y ordenamos el importe dentro de cada grupo. No convertimos monedas ni anualizamos pagos. Los beneficios sin importe confirmado aparecen al final; los empates conservan un orden estable.
          </p>}
          <div className="flex items-center gap-1 mb-6 bg-white rounded-sm p-1 border border-[#dce3df]">
            <button
              aria-pressed={tab === 'buscar'} onClick={() => updateParam('mode', '', true)}
              className={`flex-1 min-h-12 py-2 px-3 focus-visible:outline-2 focus-visible:outline-offset-2 text-sm rounded-md transition cursor-pointer ${tab === 'buscar' ? 'bg-[#123f48] text-white font-medium' : 'text-slate-600 hover:bg-gray-100'}`}
            >
              <Search className="w-4 h-4 inline mr-1" />
              Buscador
            </button>
            <button
              aria-pressed={tab === 'recomendar'} onClick={() => isAuthenticated ? updateParam('mode', 'recomendar', true) : navigate('/login')}
              className={`flex-1 min-h-12 py-2 px-3 focus-visible:outline-2 focus-visible:outline-offset-2 text-sm rounded-md transition cursor-pointer ${tab === 'recomendar' ? 'bg-[#123f48] text-white font-medium' : 'text-slate-600 hover:bg-gray-100'}`}
            >
              <Sparkles className="w-4 h-4 inline mr-1" />
              Recomendadas
            </button>
          </div>

          <div className="mb-4 flex items-center gap-2">
            <Search className="w-5 h-5 text-[#123f48]" />
            <h2 className="text-xl font-medium text-[#123f48]">
              {totalElements > 0 ? `${totalElements} beca${totalElements !== 1 ? 's' : ''} encontrada${totalElements !== 1 ? 's' : ''}` : 'Encuentra tu beca ideal'}
            </h2>
          </div>

          {tab === 'buscar' && (query || rsh || nem) && <div aria-label="Filtros activos" className="flex flex-wrap gap-2 mb-5">
            {[['q', query, `Texto: ${query}`], ['rsh', rsh, `RSH: ${rsh}%`], ['nem', nem, `NEM: ${nem}`]].filter(([, value]) => value).map(([key, , label]) => <button key={key} onClick={() => updateParam(key, '', true)} aria-label={`Quitar filtro ${label}`} className="min-h-11 max-w-full break-words text-left px-3 py-2 bg-[#e7eeea] border border-[#c5d5d0] text-sm text-[#123f48] focus-visible:outline-2 focus-visible:outline-offset-2">{label} <span aria-hidden="true">×</span></button>)}
          </div>}

          {error && <div role="alert" className="mb-4 rounded-sm border border-red-200 bg-red-50 p-4 text-red-800">
            <p>{error}</p><button onClick={handleSearch} className="mt-2 underline cursor-pointer">Reintentar</button>
          </div>}
          {favoriteError && <p role="alert" className="mb-4 border-l-2 border-red-700 bg-red-50 p-4 text-red-800">{favoriteError}</p>}
          {loading ? (
            <div role="status" aria-label="Cargando becas" className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-2 gap-4">
              {Array.from({ length: 6 }).map((_, i) => (
                <div key={i} className="bg-white rounded-sm p-5 animate-pulse motion-reduce:animate-none">
                  <div className="h-5 bg-gray-200 rounded w-3/4 mb-3" />
                  <div className="h-4 bg-gray-100 rounded w-full mb-2" />
                  <div className="h-4 bg-gray-100 rounded w-2/3 mb-4" />
                  <div className="space-y-2">
                    <div className="h-3 bg-gray-100 rounded w-1/2" />
                    <div className="h-3 bg-gray-100 rounded w-1/3" />
                  </div>
                </div>
              ))}
            </div>
          ) : becas.length > 0 ? (
            <>
              <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-2 gap-4">
                {becas.map((beca) => (
                  <BecaCard
                    key={beca.idBeca}
                    beca={beca}
                    onClick={(id) => navigate(`/becas/${id}`)}
                    isFavorito={favIds.has(beca.idBeca)}
                    favoritoPending={pendingFavorites.has(beca.idBeca)}
                    onToggleFavorito={isAuthenticated ? handleToggleFavorito : undefined}
                  />
                ))}
              </div>
              {totalPages > 0 && (
                <div className="flex flex-col sm:flex-row items-center justify-between gap-3 mt-6">
                  <div className="flex items-center gap-2">
                    <span className="text-xs text-slate-600">Filas:</span>
                    <select value={pageSize} onChange={e => updateParam('size', e.target.value, true)} aria-label="Resultados por página"
                      className="text-xs border rounded px-2 py-1 bg-white">
                      <option value={12}>12</option>
                      <option value={50}>50</option>
                      <option value={100}>100</option>
                    </select>
                  </div>
                  <div className="flex items-center gap-1 flex-wrap justify-center">
                    <button disabled={page === 0} aria-label="Página anterior" onClick={() => handlePageChange(page - 1)}
                      className="min-w-9 min-h-11 px-2 py-1 text-sm focus-visible:outline-2 focus-visible:outline-offset-2 rounded border border-[#b9cac8] disabled:opacity-40 hover:bg-gray-100 cursor-pointer">«</button>
                    {Array.from({ length: Math.min(totalPages, 8) }, (_, i) => {
                      let p: number;
                      if (totalPages <= 8) { p = i; }
                      else if (page < 4) { p = i; }
                      else if (page > totalPages - 5) { p = totalPages - 8 + i; }
                      else { p = page - 3 + i; }
                      return (
                        <button key={p} disabled={p === page}
                          onClick={() => handlePageChange(p)} aria-current={p === page ? 'page' : undefined} aria-label={`Página ${p + 1}`}
                          className={`min-w-9 min-h-11 text-sm focus-visible:outline-2 focus-visible:outline-offset-2 rounded cursor-pointer ${p === page ? 'bg-[#123f48] text-white font-medium' : 'border border-[#b9cac8] hover:bg-gray-100'}`}>
                          {p + 1}
                        </button>
                      );
                    })}
                    <button disabled={page >= totalPages - 1} aria-label="Página siguiente" onClick={() => handlePageChange(page + 1)}
                      className="min-w-9 min-h-11 px-2 py-1 text-sm focus-visible:outline-2 focus-visible:outline-offset-2 rounded border border-[#b9cac8] disabled:opacity-40 hover:bg-gray-100 cursor-pointer">»</button>
                  </div>
                  <span className="text-xs text-slate-600">{totalElements} resultados</span>
                </div>
              )}
            </>
          ) : (
            <div className="text-center py-12">
              <Search className="w-12 h-12 text-gray-300 mx-auto mb-3" />
              <p className="text-slate-600 text-lg">{tab === 'recomendar' ? 'No encontramos coincidencias con tu perfil' : 'No se encontraron becas con esos filtros'}</p>
              <p className="text-slate-500 text-sm mt-1">{tab === 'recomendar' ? 'Completa tu perfil o consulta las becas en el buscador' : 'Intenta ajustar los parámetros de búsqueda'}</p>
            </div>
          )}
        </section>
      </main>
    </div>
  );
}
