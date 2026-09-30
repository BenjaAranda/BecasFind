import { useState, useEffect, useRef } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { becaService } from '../services/becaService';
import { favoritoService } from '../services/favoritoService';
import type { BecaSummary } from '../types';
import SearchFilters from '../components/common/SearchFilters';
import BecaCard from '../components/common/BecaCard';
import { GraduationCap, Search, LogOut, Shield, User, Bookmark, Sparkles } from 'lucide-react';

export default function SearchPage() {
  const { user, isAdmin, logout } = useAuth();
  const navigate = useNavigate();
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
  const tab = searchParams.get('mode') === 'recomendar' ? 'recomendar' : 'buscar';
  const [becas, setBecas] = useState<BecaSummary[]>([]);
  const [loading, setLoading] = useState(true);
  const [totalElements, setTotalElements] = useState(0);
  const [totalPages, setTotalPages] = useState(0);
  const [error, setError] = useState('');
  const [requestVersion, setRequestVersion] = useState(0);
  const urgent = useRef(true);
  const [favIds, setFavIds] = useState<Set<number>>(new Set());

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
        const response = params.get('mode') === 'recomendar'
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
  }, [paramsKey, requestVersion]);

  useEffect(() => {
    let active = true;
    favoritoService.listar().then(({ data }) => {
      if (active) setFavIds(new Set(data.data.map(b => b.idBeca)));
    }).catch(() => { /* La búsqueda sigue disponible si no se cargan favoritos. */ });
    return () => { active = false; };
  }, []);

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

  const handleToggleFavorito = async (idBeca: number) => {
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
      setFavIds(prev => {
        const n = new Set(prev);
        if (wasFav) n.add(idBeca); else n.delete(idBeca);
        return n;
      });
    }
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-white border-b border-gray-200 sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-4 min-h-14 py-2 flex flex-wrap gap-2 items-center justify-between">
          <div className="flex items-center gap-2 cursor-pointer" onClick={() => navigate('/explorar')}>
            <GraduationCap className="w-6 h-6 text-blue-600" />
            <span className="font-bold text-lg text-gray-800">BecasFind</span>
          </div>

          <div className="flex flex-wrap items-center gap-3">
            <button onClick={() => navigate('/favoritos')} className="flex items-center gap-1 text-sm text-gray-500 hover:text-blue-600 cursor-pointer">
              <Bookmark className="w-4 h-4" />
              Favoritos
            </button>
            <button onClick={() => navigate('/perfil')} className="flex items-center gap-1 text-sm text-gray-500 hover:text-blue-600 cursor-pointer">
              <User className="w-4 h-4" />
              Mi Perfil
            </button>
            {isAdmin && (
              <button onClick={() => navigate('/admin')} className="flex items-center gap-1 text-sm text-purple-600 hover:text-purple-700 font-medium cursor-pointer">
                <Shield className="w-4 h-4" />
                Admin
              </button>
            )}
            <span className="text-sm text-gray-600 hidden sm:inline">{user?.nombreCompleto}</span>
            <button onClick={logout} className="flex items-center gap-1 text-sm text-red-500 hover:text-red-600 cursor-pointer">
              <LogOut className="w-4 h-4" />
              Salir
            </button>
          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-4 py-6 flex flex-col lg:flex-row gap-6">
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
              <div className="mt-4 p-4 bg-blue-50 rounded-xl border border-blue-100">
                <p className="text-xs text-blue-700 font-medium mb-1">¿Cómo funciona?</p>
                <ul className="text-xs text-blue-600 space-y-1">
                  <li>• RSH: ingresas tu %, ves becas que acepten ≥ ese valor</li>
                  <li>• NEM: ingresas tu promedio, ves becas con mínimo ≤ tu nota</li>
                  <li>• Región: filtra becas locales o de alcance nacional</li>
                  <li>• Becas vencidas se excluyen automáticamente</li>
                </ul>
              </div>
            </>
          ) : (
            <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-5">
              <div className="flex items-center gap-2 mb-3">
                <Sparkles className="w-5 h-5 text-amber-500" />
                <h3 className="font-semibold text-gray-800">Recomendadas para ti</h3>
              </div>
              <p className="text-sm text-gray-500 mb-4">
                Basadas en tu RSH, NEM y región guardados. Revisa los requisitos oficiales: una recomendación no garantiza que puedas postular.
              </p>
              <button
                onClick={() => navigate('/perfil')}
                className="w-full py-2 text-sm bg-amber-50 text-amber-700 rounded-lg hover:bg-amber-100 cursor-pointer"
              >
                Configurar mi perfil
              </button>
            </div>
          )}
        </aside>

        <section className="flex-1 min-w-0">
          <div className="flex items-center gap-1 mb-4 bg-white rounded-lg p-1 border border-gray-200">
            <button
              onClick={() => updateParam('mode', '', true)}
              className={`flex-1 py-2 px-3 text-sm rounded-md transition cursor-pointer ${tab === 'buscar' ? 'bg-blue-600 text-white font-medium' : 'text-gray-600 hover:bg-gray-100'}`}
            >
              <Search className="w-4 h-4 inline mr-1" />
              Buscador
            </button>
            <button
              onClick={() => updateParam('mode', 'recomendar', true)}
              className={`flex-1 py-2 px-3 text-sm rounded-md transition cursor-pointer ${tab === 'recomendar' ? 'bg-blue-600 text-white font-medium' : 'text-gray-600 hover:bg-gray-100'}`}
            >
              <Sparkles className="w-4 h-4 inline mr-1" />
              Recomendadas
            </button>
          </div>

          <div className="mb-4 flex items-center gap-2">
            <Search className="w-5 h-5 text-blue-600" />
            <h2 className="text-lg font-semibold text-gray-800">
              {totalElements > 0 ? `${totalElements} beca${totalElements !== 1 ? 's' : ''} encontrada${totalElements !== 1 ? 's' : ''}` : 'Encuentra tu beca ideal'}
            </h2>
          </div>

          {error && <div role="alert" className="mb-4 rounded-lg border border-red-200 bg-red-50 p-4 text-red-800">
            <p>{error}</p><button onClick={handleSearch} className="mt-2 underline cursor-pointer">Reintentar</button>
          </div>}
          {loading ? (
            <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
              {Array.from({ length: 6 }).map((_, i) => (
                <div key={i} className="bg-white rounded-xl p-5 animate-pulse">
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
              <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
                {becas.map((beca) => (
                  <BecaCard
                    key={beca.idBeca}
                    beca={beca}
                    onClick={(id) => navigate(`/becas/${id}`)}
                    isFavorito={favIds.has(beca.idBeca)}
                    onToggleFavorito={handleToggleFavorito}
                  />
                ))}
              </div>
              {totalPages > 0 && (
                <div className="flex flex-col sm:flex-row items-center justify-between gap-3 mt-6">
                  <div className="flex items-center gap-2">
                    <span className="text-xs text-gray-500">Filas:</span>
                    <select value={pageSize} onChange={e => updateParam('size', e.target.value, true)} aria-label="Resultados por página"
                      className="text-xs border rounded px-2 py-1 bg-white">
                      <option value={12}>12</option>
                      <option value={50}>50</option>
                      <option value={100}>100</option>
                    </select>
                  </div>
                  <div className="flex items-center gap-1">
                    <button disabled={page === 0} aria-label="Página anterior" onClick={() => handlePageChange(page - 1)}
                      className="px-2.5 py-1 text-sm rounded border border-gray-300 disabled:opacity-40 hover:bg-gray-100 cursor-pointer">«</button>
                    {Array.from({ length: Math.min(totalPages, 8) }, (_, i) => {
                      let p: number;
                      if (totalPages <= 8) { p = i; }
                      else if (page < 4) { p = i; }
                      else if (page > totalPages - 5) { p = totalPages - 8 + i; }
                      else { p = page - 3 + i; }
                      return (
                        <button key={p} disabled={p === page}
                          onClick={() => handlePageChange(p)} aria-current={p === page ? 'page' : undefined} aria-label={`Página ${p + 1}`}
                          className={`w-8 h-8 text-sm rounded cursor-pointer ${p === page ? 'bg-blue-600 text-white font-medium' : 'border border-gray-300 hover:bg-gray-100'}`}>
                          {p + 1}
                        </button>
                      );
                    })}
                    <button disabled={page >= totalPages - 1} aria-label="Página siguiente" onClick={() => handlePageChange(page + 1)}
                      className="px-2.5 py-1 text-sm rounded border border-gray-300 disabled:opacity-40 hover:bg-gray-100 cursor-pointer">»</button>
                  </div>
                  <span className="text-xs text-gray-500">{totalElements} resultados</span>
                </div>
              )}
            </>
          ) : (
            <div className="text-center py-12">
              <Search className="w-12 h-12 text-gray-300 mx-auto mb-3" />
              <p className="text-gray-500 text-lg">{tab === 'recomendar' ? 'No encontramos coincidencias con tu perfil' : 'No se encontraron becas con esos filtros'}</p>
              <p className="text-gray-400 text-sm mt-1">{tab === 'recomendar' ? 'Completa tu perfil o consulta las becas en el buscador' : 'Intenta ajustar los parámetros de búsqueda'}</p>
            </div>
          )}
        </section>
      </main>
    </div>
  );
}
