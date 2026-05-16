import { useState, useEffect } from 'react';
import type { Region } from '../../types';
import { catalogoService } from '../../services/becaService';
import { Search, Filter } from 'lucide-react';

interface SearchFiltersProps {
  rsh: string;
  nem: string;
  regionId: string;
  onRshChange: (v: string) => void;
  onNemChange: (v: string) => void;
  onRegionChange: (v: string) => void;
  onSearch: () => void;
  onUseProfile?: () => void;
}

export default function SearchFilters({
  rsh,
  nem,
  regionId,
  onRshChange,
  onNemChange,
  onRegionChange,
  onSearch,
  onUseProfile,
}: SearchFiltersProps) {
  const [regiones, setRegiones] = useState<Region[]>([]);

  useEffect(() => {
    catalogoService.getRegiones().then(({ data }) => setRegiones(data.data)).catch(() => {});
  }, []);

  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-5">
      <div className="flex items-center gap-2 mb-4">
        <Filter className="w-5 h-5 text-blue-600" />
        <h3 className="font-semibold text-gray-800">Filtros</h3>
      </div>

      <div className="space-y-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Registro Social de Hogares (%)
          </label>
          <input
            type="number"
            min="0"
            max="100"
            value={rsh}
            onChange={(e) => onRshChange(e.target.value)}
            placeholder="Ej: 60"
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
          />
          <p className="text-xs text-gray-400 mt-1">Muestra becas con RSH ≥ este valor</p>
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            NEM Mínimo
          </label>
          <input
            type="number"
            min="1.0"
            max="7.0"
            step="0.1"
            value={nem}
            onChange={(e) => onNemChange(e.target.value)}
            placeholder="Ej: 5.5"
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
          />
          <p className="text-xs text-gray-400 mt-1">Muestra becas con NEM ≤ tu promedio</p>
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Región
          </label>
          <select
            value={regionId}
            onChange={(e) => onRegionChange(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none bg-white"
          >
            <option value="">Todas las regiones</option>
            {regiones.map((r) => (
              <option key={r.idRegion} value={r.idRegion}>
                {r.nombre}
              </option>
            ))}
          </select>
          <p className="text-xs text-gray-400 mt-1">Filtra por región o ve becas nacionales</p>
        </div>

        {onUseProfile && (
          <button
            type="button"
            onClick={onUseProfile}
            className="w-full text-sm text-blue-600 hover:text-blue-700 py-1 cursor-pointer"
          >
            Usar mi perfil
          </button>
        )}

        <button
          onClick={onSearch}
          className="w-full flex items-center justify-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-medium py-2.5 px-4 rounded-lg transition cursor-pointer text-sm"
        >
          <Search className="w-4 h-4" />
          Buscar Becas
        </button>
      </div>
    </div>
  );
}
