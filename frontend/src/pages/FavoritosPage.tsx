import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { favoritoService } from '../services/favoritoService';
import type { BecaSummary } from '../types';
import BecaCard from '../components/common/BecaCard';
import { GraduationCap, Bookmark, ArrowLeft } from 'lucide-react';

export default function FavoritosPage() {
  const navigate = useNavigate();
  const [becas, setBecas] = useState<BecaSummary[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchFavoritos = () => {
    favoritoService.listar()
      .then(({ data }) => setBecas(data.data))
      .catch(() => setBecas([]))
      .finally(() => setLoading(false));
  };

  useEffect(() => { fetchFavoritos(); }, []);

  const handleRemoveFav = async (id: number) => {
    await favoritoService.eliminar(id);
    setBecas(prev => prev.filter(b => b.idBeca !== id));
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-white border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 h-14 flex items-center justify-between">
          <div className="flex items-center gap-2 cursor-pointer" onClick={() => navigate('/explorar')}>
            <GraduationCap className="w-6 h-6 text-blue-600" />
            <span className="font-bold text-lg text-gray-800">BecasFind</span>
          </div>
          <button onClick={() => navigate('/explorar')} className="text-sm text-gray-500 hover:text-blue-600 cursor-pointer">
            Explorar Becas
          </button>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-4 py-6">
        <button onClick={() => navigate('/explorar')} className="flex items-center gap-1 text-sm text-gray-500 hover:text-blue-600 mb-3 cursor-pointer">
          <ArrowLeft className="w-4 h-4" /> Volver al Buscador
        </button>
        <div className="flex items-center gap-2 mb-6">
          <Bookmark className="w-6 h-6 text-blue-600" />
          <h1 className="text-2xl font-bold text-gray-800">Mis Favoritos</h1>
        </div>

        {loading ? (
          <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
            {Array.from({ length: 3 }).map((_, i) => (
              <div key={i} className="bg-white rounded-xl p-5 animate-pulse">
                <div className="h-5 bg-gray-200 rounded w-3/4 mb-3" />
                <div className="h-4 bg-gray-100 rounded w-full mb-4" />
                <div className="space-y-2">
                  <div className="h-3 bg-gray-100 rounded w-1/2" />
                  <div className="h-3 bg-gray-100 rounded w-1/3" />
                </div>
              </div>
            ))}
          </div>
        ) : becas.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
            {becas.map(beca => (
              <div key={beca.idBeca} className="relative">
                <BecaCard beca={beca} onClick={() => navigate(`/becas/${beca.idBeca}`)} />
                <button
                  onClick={(e) => { e.stopPropagation(); handleRemoveFav(beca.idBeca); }}
                  className="absolute top-3 right-3 p-1.5 bg-red-50 text-red-500 rounded-full hover:bg-red-100 cursor-pointer"
                  title="Quitar de favoritos"
                >
                  <Bookmark className="w-4 h-4 fill-current" />
                </button>
              </div>
            ))}
          </div>
        ) : (
          <div className="text-center py-12">
            <Bookmark className="w-12 h-12 text-gray-300 mx-auto mb-3" />
            <p className="text-gray-500 text-lg">No tienes becas guardadas</p>
            <button onClick={() => navigate('/explorar')} className="mt-3 text-blue-600 hover:underline text-sm cursor-pointer">
              Explorar becas disponibles
            </button>
          </div>
        )}
      </main>
    </div>
  );
}
