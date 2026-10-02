import { type BecaSummary } from '../../types';
import { Calendar, Building2, Tag, MapPin, Bookmark, Clock, ArrowUpRight } from 'lucide-react';
import { formatCalendarDate, isClosingDateExpired } from '../../utils/dates';

interface BecaCardProps {
  beca: BecaSummary;
  onClick: (id: string) => void;
  isFavorito?: boolean;
  onToggleFavorito?: (id: string) => void;
  favoritoPending?: boolean;
}

export default function BecaCard({ beca, onClick, isFavorito, onToggleFavorito, favoritoPending }: BecaCardProps) {
  const isExpired = isClosingDateExpired(beca.fechaCierrePostulacion);

  return (
    <div
      onClick={() => onClick(beca.idBeca)}
      className="bg-white rounded-sm shadow-none border border-[#dbe3ed] p-6 hover:border-[#375b80] transition cursor-pointer h-full flex flex-col"
    >
      <div className="flex items-center justify-between mb-2">
        <span className="text-xs font-medium px-2 py-1 bg-[#eff6ff] text-[#0b3c75] rounded-full break-words min-w-0">
          {beca.nombreTipoBeca}
        </span>
        {onToggleFavorito && (
          <button
            disabled={favoritoPending}
            onClick={(e) => { e.stopPropagation(); e.preventDefault(); onToggleFavorito(beca.idBeca); }}
            className={`min-h-11 min-w-11 flex items-center justify-center rounded-sm focus-visible:outline-2 focus-visible:outline-offset-2 transition cursor-pointer shrink-0 ${isFavorito ? 'text-[#0b3c75] bg-[#eff6ff] hover:bg-blue-100' : 'text-[#375b80] hover:text-[#0b3c75] hover:bg-[#eff6ff]'}`}
            aria-label={isFavorito ? 'Quitar de favoritos' : 'Guardar en favoritos'}
            aria-pressed={!!isFavorito}
            aria-busy={favoritoPending}
          >
            <Bookmark className={`w-4 h-4 ${isFavorito ? 'fill-current' : ''}`} />
          </button>
        )}
      </div>

      <h3 className="font-sans font-semibold text-2xl text-[#0b3c75] leading-tight mb-3 break-words">
        <button onClick={event => { event.stopPropagation(); onClick(beca.idBeca); }} className="text-left cursor-pointer hover:underline decoration-1 underline-offset-4 focus-visible:outline-2 focus-visible:outline-offset-2">{beca.nombre}</button>
      </h3>

      {(isExpired || beca.estadoActiva === false) && (
        <div className="flex items-center gap-1.5 mb-3">
          <Clock className="w-3.5 h-3.5 text-amber-500 shrink-0" />
          <span className="text-xs font-medium text-amber-600 bg-amber-50 px-2 py-0.5 rounded-full">
            {beca.estadoActiva === false ? 'Beca inactiva' : 'Postulación cerrada'}
          </span>
        </div>
      )}

      {beca.descripcionCorta && (
        <p className="text-sm leading-relaxed text-slate-600 mb-5 line-clamp-3">{beca.descripcionCorta}</p>
      )}

      <div className="space-y-3 text-sm text-slate-600 mt-auto pt-5 border-t border-[#dbe3ed]">
        <div className="flex items-center gap-2">
          <Building2 className="w-4 h-4 text-slate-500 shrink-0" />
          <span className="truncate">{beca.nombreInstitucion}</span>
        </div>

        {beca.montoCobertura && (
          <div className="flex items-start gap-2">
            <Tag className="w-4 h-4 text-slate-500 shrink-0 mt-0.5" />
            <span className="font-semibold text-[#0b3c75] break-words">{beca.montoCobertura}</span>
          </div>
        )}

        <div className="flex items-center gap-2">
          <MapPin className="w-4 h-4 text-slate-500 shrink-0" />
          <span className="truncate">{beca.nombreRegion}</span>
        </div>

        <div className="flex items-center gap-2">
          <Calendar className="w-4 h-4 text-slate-500 shrink-0" />
          <span className="truncate">Cierre: {formatCalendarDate(beca.fechaCierrePostulacion)}</span>
        </div>
      </div>
      <span aria-hidden="true" className="mt-5 flex justify-between items-center text-sm font-medium text-[#0b3c75]">Conocer esta beca <ArrowUpRight size={18} /></span>
    </div>
  );
}
