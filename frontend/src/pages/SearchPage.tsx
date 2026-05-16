import { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
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

  const [rsh, setRsh] = useState('');
  const [nem, setNem] = useState('');
  const [regionId, setRegionId] = useState('');
  const [query, setQuery] = useState('');
  const [idTipoBeca, setIdTipoBeca] = useState('');
  const [idInstitucion, setIdInstitucion] = useState('');
  const [sort, setSort] = useState('fechaAsc');
  const [becas, setBecas] = useState<BecaSummary[]>([]);
  const [loading, setLoading] = useState(false);
  const [totalElements, setTotalElements] = useState(0);
  const [page, setPage] = useState(0);
  const [totalPages, setTotalPages] = useState(0);
  const [tab, setTab] = useState<'buscar' | 'recomendar'>('buscar');
  const [favIds, setFavIds] = useState<Set<number>>(new Set());

  const fetchBecas = useCallback(async (p: number) => {
    setLoading(true);
    try {
      const { data } = await becaService.search({
        rsh: rsh ? Number(rsh) : undefined,
        nem: nem ? Number(nem) : undefined,
        regionId: regionId ? Number(regionId) : undefined,
        query: query || undefined,
        idTipoBeca: idTipoBeca ? Number(idTipoBeca) : undefined,
        idInstitucion: idInstitucion ? Number(idInstitucion) : undefined,
        sort,
        page: p,
        size: 12,
      });
      setBecas(data.data.content);
      setTotalElements(data.data.totalElements);
      setTotalPages(data.data.totalPages);
      setPage(data.data.number);
    } catch {
      setBecas([]);
    } finally {
      setLoading(false);
    }
  }, [rsh, nem, regionId, query, idTipoBeca, idInstitucion, sort]);

  useEffect(() => { fetchBecas(0); }, []);

  const handleToggleFavorito = async (idBeca: number) => {
    if (favIds.has(idBeca)) {
      await favoritoService.eliminar(idBeca);
      setFavIds(prev => { const n = new Set(prev); n.delete(idBeca); return n; });
    } else {
      await favoritoService.guardar(idBeca);
      setFavIds(prev => new Set(prev).add(idBeca));
    }
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-white border-b border-gray-200 sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-4 h-14 flex items-center justify-between">
          <div className="flex items-center gap-2 cursor-pointer" onClick={() => navigate('/explorar')}>
            <GraduationCap className="w-6 h-6 text-blue-600" />
            <span className="font-bold text-lg text-gray-800">BecasFind</span>
          </div>

          <div className="flex items-center gap-3">
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
                query={query} idTipoBeca={idTipoBeca} idInstitucion={idInstitucion} sort={sort}
                onRshChange={setRsh} onNemChange={setNem} onRegionChange={setRegionId}
                onQueryChange={setQuery} onTipoBecaChange={setIdTipoBeca}
                onInstitucionChange={setIdInstitucion} onSortChange={setSort}
                onSearch={() => fetchBecas(0)}
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
                Basadas en tu perfil académico (RSH, NEM y Región guardados).
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
              onClick={() => { setTab('buscar'); fetchBecas(0); }}
              className={`flex-1 py-2 px-3 text-sm rounded-md transition cursor-pointer ${tab === 'buscar' ? 'bg-blue-600 text-white font-medium' : 'text-gray-600 hover:bg-gray-100'}`}
            >
              <Search className="w-4 h-4 inline mr-1" />
              Buscador
            </button>
            <button
              onClick={() => {
                setTab('recomendar');
                setLoading(true);
                becaService.recomendar(0, 12)
                  .then(({ data }) => { setBecas(data.data.content); setTotalElements(data.data.totalElements); setTotalPages(data.data.totalPages); setPage(0); })
                  .catch(() => setBecas([]))
                  .finally(() => setLoading(false));
              }}
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
              {totalPages > 1 && (
                <div className="flex items-center justify-center gap-2 mt-6">
                  <button disabled={page === 0} onClick={() => fetchBecas(page - 1)}
                    className="px-3 py-1.5 text-sm rounded-lg border border-gray-300 disabled:opacity-40 disabled:cursor-not-allowed hover:bg-gray-100 cursor-pointer">Anterior</button>
                  <span className="text-sm text-gray-500">Pág. {page + 1} de {totalPages}</span>
                  <button disabled={page >= totalPages - 1} onClick={() => fetchBecas(page + 1)}
                    className="px-3 py-1.5 text-sm rounded-lg border border-gray-300 disabled:opacity-40 disabled:cursor-not-allowed hover:bg-gray-100 cursor-pointer">Siguiente</button>
                </div>
              )}
            </>
          ) : (
            <div className="text-center py-12">
              <Search className="w-12 h-12 text-gray-300 mx-auto mb-3" />
              <p className="text-gray-500 text-lg">No se encontraron becas con esos filtros</p>
              <p className="text-gray-400 text-sm mt-1">Intenta ajustar los parámetros de búsqueda</p>
            </div>
          )}
        </section>
      </main>
    </div>
  );
}
