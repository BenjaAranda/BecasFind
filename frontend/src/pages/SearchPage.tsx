import { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { becaService } from '../services/becaService';
import type { BecaSummary } from '../types';
import SearchFilters from '../components/common/SearchFilters';
import BecaCard from '../components/common/BecaCard';
import { GraduationCap, Search, LogOut, Shield, User } from 'lucide-react';

export default function SearchPage() {
  const { user, isAdmin, logout } = useAuth();
  const navigate = useNavigate();

  const [rsh, setRsh] = useState('');
  const [nem, setNem] = useState('');
  const [regionId, setRegionId] = useState('');
  const [becas, setBecas] = useState<BecaSummary[]>([]);
  const [loading, setLoading] = useState(false);
  const [totalElements, setTotalElements] = useState(0);
  const [page, setPage] = useState(0);
  const [totalPages, setTotalPages] = useState(0);

  const fetchBecas = useCallback(async (p: number) => {
    setLoading(true);
    try {
      const { data } = await becaService.search({
        rsh: rsh ? Number(rsh) : undefined,
        nem: nem ? Number(nem) : undefined,
        regionId: regionId ? Number(regionId) : undefined,
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
  }, [rsh, nem, regionId]);

  useEffect(() => {
    fetchBecas(0);
  }, []);

  const handleSearch = () => fetchBecas(0);

  const handleCardClick = (id: number) => navigate(`/becas/${id}`);

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-white border-b border-gray-200 sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-4 h-14 flex items-center justify-between">
          <div className="flex items-center gap-2 cursor-pointer" onClick={() => navigate('/explorar')}>
            <GraduationCap className="w-6 h-6 text-blue-600" />
            <span className="font-bold text-lg text-gray-800">BecasFind</span>
          </div>

          <div className="flex items-center gap-3">
            {isAdmin && (
              <button
                onClick={() => navigate('/admin')}
                className="flex items-center gap-1 text-sm text-purple-600 hover:text-purple-700 font-medium cursor-pointer"
              >
                <Shield className="w-4 h-4" />
                Admin
              </button>
            )}
            <div className="flex items-center gap-2 text-sm text-gray-600">
              <User className="w-4 h-4" />
              <span>{user?.nombreCompleto}</span>
            </div>
            <button
              onClick={logout}
              className="flex items-center gap-1 text-sm text-red-500 hover:text-red-600 cursor-pointer"
            >
              <LogOut className="w-4 h-4" />
              Salir
            </button>
          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-4 py-6 flex flex-col lg:flex-row gap-6">
        <aside className="lg:w-72 shrink-0">
          <SearchFilters
            rsh={rsh}
            nem={nem}
            regionId={regionId}
            onRshChange={setRsh}
            onNemChange={setNem}
            onRegionChange={setRegionId}
            onSearch={handleSearch}
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
        </aside>

        <section className="flex-1 min-w-0">
          <div className="mb-4 flex items-center gap-2">
            <Search className="w-5 h-5 text-blue-600" />
            <h2 className="text-lg font-semibold text-gray-800">
              {totalElements > 0
                ? `${totalElements} beca${totalElements !== 1 ? 's' : ''} encontrada${totalElements !== 1 ? 's' : ''}`
                : 'Encuentra tu beca ideal'}
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
                  <BecaCard key={beca.idBeca} beca={beca} onClick={handleCardClick} />
                ))}
              </div>

              {totalPages > 1 && (
                <div className="flex items-center justify-center gap-2 mt-6">
                  <button
                    disabled={page === 0}
                    onClick={() => fetchBecas(page - 1)}
                    className="px-3 py-1.5 text-sm rounded-lg border border-gray-300 disabled:opacity-40 disabled:cursor-not-allowed hover:bg-gray-100 cursor-pointer"
                  >
                    Anterior
                  </button>
                  <span className="text-sm text-gray-500">
                    Pág. {page + 1} de {totalPages}
                  </span>
                  <button
                    disabled={page >= totalPages - 1}
                    onClick={() => fetchBecas(page + 1)}
                    className="px-3 py-1.5 text-sm rounded-lg border border-gray-300 disabled:opacity-40 disabled:cursor-not-allowed hover:bg-gray-100 cursor-pointer"
                  >
                    Siguiente
                  </button>
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
