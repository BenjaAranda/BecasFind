import { useState, useEffect } from 'react';
import type { Region, TipoBeca, Institucion, TipoInstitucion } from '../../types';
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
  idTipoInstitucion: string;
  sort: string;
  onRshChange: (v: string) => void;
  onNemChange: (v: string) => void;
  onRegionChange: (v: string) => void;
  onQueryChange: (v: string) => void;
  onTipoBecaChange: (v: string) => void;
  onInstitucionChange: (v: string) => void;
  onTipoInstitucionChange: (v: string) => void;
  onSortChange: (v: string) => void;
  onSearch: () => void;
  onUseProfile?: () => void;
  onReset?: () => void;
}

export default function SearchFilters({
  rsh, nem, regionId, query, idTipoBeca, idInstitucion, idTipoInstitucion, sort,
  onRshChange, onNemChange, onRegionChange, onQueryChange,
  onTipoBecaChange, onInstitucionChange, onTipoInstitucionChange, onSortChange,
  onSearch, onUseProfile, onReset,
}: SearchFiltersProps) {
  const [expanded, setExpanded] = useState(false);
  const [regiones, setRegiones] = useState<Region[]>([]);
  const [tiposBeca, setTiposBeca] = useState<TipoBeca[]>([]);
  const [instituciones, setInstituciones] = useState<Institucion[]>([]);
  const [tiposInstitucion, setTiposInstitucion] = useState<TipoInstitucion[]>([]);
  const [catalogError, setCatalogError] = useState('');

  useEffect(() => {
    Promise.all([
      catalogoService.getRegiones().then(r => setRegiones(r.data.data)),
      adminService.getTiposBeca().then(r => setTiposBeca(r.data.data)),
      adminService.getInstituciones().then(r => setInstituciones(r.data.data)),
      adminService.getTiposInstitucion().then(r => setTiposInstitucion(r.data.data)),
    ]).catch(() => setCatalogError('No pudimos cargar todas las opciones de los filtros. Recarga la página para volver a intentarlo.'));
  }, []);


  return (
    <form aria-label="Filtros de búsqueda" className="bg-white rounded-sm border border-[#dce3df] p-5"
      onSubmit={event => { event.preventDefault(); onSearch(); }}>
      <div className="flex items-center gap-2 mb-4">
        <Filter className="w-5 h-5 text-[#123f48]" />
        <h2 className="font-serif text-2xl text-[#123f48]">Afina tu búsqueda</h2>
        <button type="button" aria-expanded={expanded} aria-controls="search-filter-fields" onClick={() => setExpanded(value => !value)} className="lg:hidden ml-auto min-h-11 px-2 text-sm text-[#123f48] underline underline-offset-4 focus-visible:outline-2">{expanded ? 'Ocultar filtros' : 'Mostrar filtros'}</button>
      </div>

      <div id="search-filter-fields" className={`${expanded ? 'block' : 'hidden'} lg:block space-y-4`}>
        {catalogError && <p role="alert" className="text-sm text-red-700">{catalogError}</p>}
        <div>
          <label htmlFor="search-query" className="block text-sm font-medium text-gray-700 mb-1">Buscar</label>
          <input
            type="text"
            id="search-query" maxLength={200} value={query}
            onChange={(e) => onQueryChange(e.target.value)}
            placeholder="Buscar por nombre o descripción..."
            className="w-full min-h-12 px-3 py-2 border border-[#b9cac8] rounded-sm text-sm focus:ring-2 focus:ring-[#123f48] focus:border-[#123f48] outline-none"
          />
        </div>

        <div>
          <label htmlFor="search-rsh" className="block text-sm font-medium text-gray-700 mb-1">RSH (%)</label>
          <input type="number" min="0" max="100" id="search-rsh" value={rsh} onChange={e => onRshChange(e.target.value)}
            placeholder="Ej: 60" className="w-full min-h-12 px-3 py-2 border border-[#b9cac8] rounded-sm text-sm focus:ring-2 focus:ring-[#123f48] focus:border-[#123f48] outline-none" />
        </div>
        <div>
          <label htmlFor="search-nem" className="block text-sm font-medium text-gray-700 mb-1">Tu promedio NEM</label>
          <input type="number" min="1.0" max="7.0" step="0.1" id="search-nem" value={nem} onChange={e => onNemChange(e.target.value)}
            placeholder="Ej: 5.5" className="w-full min-h-12 px-3 py-2 border border-[#b9cac8] rounded-sm text-sm focus:ring-2 focus:ring-[#123f48] focus:border-[#123f48] outline-none" />
        </div>
        <div>
          <label htmlFor="search-region" className="block text-sm font-medium text-gray-700 mb-1">Región</label>
          <select id="search-region" value={regionId} onChange={e => onRegionChange(e.target.value)}
            className="w-full min-h-12 px-3 py-2 border rounded-sm text-sm bg-white focus:ring-2 focus:ring-[#123f48] outline-none">
            <option value="">Todas</option>
            {regiones.map(r => <option key={r.idRegion} value={r.idRegion}>{r.nombre}</option>)}
          </select>
        </div>
        <div>
          <label htmlFor="search-type" className="block text-sm font-medium text-gray-700 mb-1">Tipo de Beca</label>
          <select id="search-type" value={idTipoBeca} onChange={e => onTipoBecaChange(e.target.value)}
            className="w-full min-h-12 px-3 py-2 border rounded-sm text-sm bg-white focus:ring-2 focus:ring-[#123f48] outline-none">
            <option value="">Todos</option>
            {tiposBeca.map(t => <option key={t.idTipoBeca} value={t.idTipoBeca}>{t.nombre}</option>)}
          </select>
        </div>
        <div>
          <label htmlFor="search-institution" className="block text-sm font-medium text-gray-700 mb-1">Institución</label>
          <select id="search-institution" value={idInstitucion} onChange={e => onInstitucionChange(e.target.value)}
            className="w-full min-h-12 px-3 py-2 border rounded-sm text-sm bg-white focus:ring-2 focus:ring-[#123f48] outline-none">
            <option value="">Todas</option>
            {instituciones.map(i => <option key={i.idInstitucion} value={i.idInstitucion}>{i.nombre}</option>)}
          </select>
        </div>
        <div>
          <label htmlFor="search-category" className="block text-sm font-medium text-gray-700 mb-1">Categoría</label>
          <select id="search-category" value={idTipoInstitucion} onChange={e => onTipoInstitucionChange(e.target.value)}
            className="w-full min-h-12 px-3 py-2 border rounded-sm text-sm bg-white focus:ring-2 focus:ring-[#123f48] outline-none">
            <option value="">Todas</option>
            {tiposInstitucion.map(t => <option key={t.idTipoInst} value={t.idTipoInst}>{t.nombre}</option>)}
          </select>
        </div>
        <div>
          <label htmlFor="search-sort" className="block text-sm font-medium text-gray-700 mb-1">Ordenar por</label>
          <select id="search-sort" value={sort} onChange={e => onSortChange(e.target.value)}
            className="w-full min-h-12 px-3 py-2 border rounded-sm text-sm bg-white focus:ring-2 focus:ring-[#123f48] outline-none">
            <option value="fechaAsc">Más próximas a vencer</option>
            <option value="fechaDesc">Mayor plazo</option>
            <option value="montoAsc">Menor monto</option>
            <option value="montoDesc">Mayor monto</option>
          </select>
        </div>

        {onUseProfile && (
          <button type="button" onClick={onUseProfile} className="w-full text-sm text-[#123f48] hover:text-[#123f48] min-h-11 py-1 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2">
            Usar mi perfil
          </button>
        )}

        {onReset && (
          <button type="button" onClick={onReset}
            className="w-full text-sm text-slate-600 hover:text-red-500 min-h-11 py-1 cursor-pointer focus-visible:outline-2 focus-visible:outline-offset-2">
            Reiniciar filtros
          </button>
        )}

        <button type="submit"
          className="w-full flex items-center justify-center gap-2 bg-[#123f48] hover:bg-[#1a525c] text-white font-medium py-2.5 px-4 rounded-sm transition cursor-pointer text-sm">
          <Search className="w-4 h-4" />
          Buscar Becas
        </button>
      </div>
    </form>
  );
}
