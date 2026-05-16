import { useState, useEffect, useRef, useCallback } from 'react';
import type { Region, TipoBeca, Institucion } from '../../types';
import { catalogoService } from '../../services/becaService';
import { adminService } from '../../services/adminService';
import { Search, Filter } from 'lucide-react';

interface SearchFiltersProps {
  rsh: string;
  nem: string;
  regionId: string;
  query: string;
  idTipoBeca: string;
  idInstitucion: string;
  sort: string;
  onRshChange: (v: string) => void;
  onNemChange: (v: string) => void;
  onRegionChange: (v: string) => void;
  onQueryChange: (v: string) => void;
  onTipoBecaChange: (v: string) => void;
  onInstitucionChange: (v: string) => void;
  onSortChange: (v: string) => void;
  onSearch: () => void;
  onUseProfile?: () => void;
}

export default function SearchFilters({
  rsh, nem, regionId, query, idTipoBeca, idInstitucion, sort,
  onRshChange, onNemChange, onRegionChange, onQueryChange,
  onTipoBecaChange, onInstitucionChange, onSortChange,
  onSearch, onUseProfile,
}: SearchFiltersProps) {
  const [regiones, setRegiones] = useState<Region[]>([]);
  const [tiposBeca, setTiposBeca] = useState<TipoBeca[]>([]);
  const [instituciones, setInstituciones] = useState<Institucion[]>([]);
  const [localQuery, setLocalQuery] = useState(query);
  const debounceTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    Promise.all([
      catalogoService.getRegiones().then(r => setRegiones(r.data.data)),
      adminService.getTiposBeca().then(r => setTiposBeca(r.data.data)),
      adminService.getInstituciones().then(r => setInstituciones(r.data.data)),
    ]).catch(() => {});
  }, []);

  const handleQueryChange = useCallback((value: string) => {
    setLocalQuery(value);
    if (debounceTimer.current) clearTimeout(debounceTimer.current);
    debounceTimer.current = setTimeout(() => onQueryChange(value), 400);
  }, [onQueryChange]);

  useEffect(() => {
    return () => { if (debounceTimer.current) clearTimeout(debounceTimer.current); };
  }, []);

  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-5">
      <div className="flex items-center gap-2 mb-4">
        <Filter className="w-5 h-5 text-blue-600" />
        <h3 className="font-semibold text-gray-800">Filtros</h3>
      </div>

      <div className="space-y-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Buscar</label>
          <input
            type="text"
            value={localQuery}
            onChange={(e) => handleQueryChange(e.target.value)}
            placeholder="Buscar por nombre o descripción..."
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">RSH (%)</label>
          <input type="number" min="0" max="100" value={rsh} onChange={e => onRshChange(e.target.value)}
            placeholder="Ej: 60" className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none" />
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">NEM Mínimo</label>
          <input type="number" min="1.0" max="7.0" step="0.1" value={nem} onChange={e => onNemChange(e.target.value)}
            placeholder="Ej: 5.5" className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none" />
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Región</label>
          <select value={regionId} onChange={e => onRegionChange(e.target.value)}
            className="w-full px-3 py-2 border rounded-lg text-sm bg-white focus:ring-2 focus:ring-blue-500 outline-none">
            <option value="">Todas</option>
            {regiones.map(r => <option key={r.idRegion} value={r.idRegion}>{r.nombre}</option>)}
          </select>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Tipo de Beca</label>
          <select value={idTipoBeca} onChange={e => onTipoBecaChange(e.target.value)}
            className="w-full px-3 py-2 border rounded-lg text-sm bg-white focus:ring-2 focus:ring-blue-500 outline-none">
            <option value="">Todos</option>
            {tiposBeca.map(t => <option key={t.idTipoBeca} value={t.idTipoBeca}>{t.nombre}</option>)}
          </select>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Institución</label>
          <select value={idInstitucion} onChange={e => onInstitucionChange(e.target.value)}
            className="w-full px-3 py-2 border rounded-lg text-sm bg-white focus:ring-2 focus:ring-blue-500 outline-none">
            <option value="">Todas</option>
            {instituciones.map(i => <option key={i.idInstitucion} value={i.idInstitucion}>{i.nombre}</option>)}
          </select>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Ordenar por</label>
          <select value={sort} onChange={e => onSortChange(e.target.value)}
            className="w-full px-3 py-2 border rounded-lg text-sm bg-white focus:ring-2 focus:ring-blue-500 outline-none">
            <option value="fechaAsc">Más próximas a vencer</option>
            <option value="fechaDesc">Mayor plazo</option>
            <option value="montoAsc">Menor monto</option>
            <option value="montoDesc">Mayor monto</option>
          </select>
        </div>

        {onUseProfile && (
          <button type="button" onClick={onUseProfile} className="w-full text-sm text-blue-600 hover:text-blue-700 py-1 cursor-pointer">
            Usar mi perfil
          </button>
        )}

        <button onClick={onSearch}
          className="w-full flex items-center justify-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-medium py-2.5 px-4 rounded-lg transition cursor-pointer text-sm">
          <Search className="w-4 h-4" />
          Buscar Becas
        </button>
      </div>
    </div>
  );
}
