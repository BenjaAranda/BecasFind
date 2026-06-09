import { type BecaSummary } from '../../types';
import { Calendar, Building2, Tag, MapPin, Bookmark, Clock } from 'lucide-react';

interface BecaCardProps {
  beca: BecaSummary;
  onClick: (id: number) => void;
  isFavorito?: boolean;
  onToggleFavorito?: (id: number) => void;
}

export default function BecaCard({ beca, onClick, isFavorito, onToggleFavorito }: BecaCardProps) {
  const formatDate = (dateStr: string) =>
    new Date(dateStr).toLocaleDateString('es-CL', {
      day: 'numeric',
      month: 'long',
      year: 'numeric',
    });

  const isExpired = new Date(beca.fechaCierrePostulacion) < new Date();

  return (
    <div
      onClick={() => onClick(beca.idBeca)}
      className="bg-white rounded-xl shadow-sm border border-gray-100 p-5 hover:shadow-md hover:border-blue-200 transition cursor-pointer h-full flex flex-col"
    >
      <div className="flex items-center justify-between mb-2">
        <span className="text-xs font-medium px-2 py-1 bg-blue-50 text-blue-700 rounded-full shrink-0">
          {beca.nombreTipoBeca}
        </span>
        {onToggleFavorito && (
          <button
            onClick={(e) => { e.stopPropagation(); e.preventDefault(); onToggleFavorito(beca.idBeca); }}
            className={`p-1 rounded-full transition cursor-pointer shrink-0 ${isFavorito ? 'text-blue-600 bg-blue-50 hover:bg-blue-100' : 'text-gray-300 hover:text-blue-400 hover:bg-gray-100'}`}
            title={isFavorito ? 'Quitar de favoritos' : 'Guardar en favoritos'}
          >
            <Bookmark className={`w-4 h-4 ${isFavorito ? 'fill-current' : ''}`} />
          </button>
        )}
      </div>

      <h3 className="font-semibold text-gray-800 leading-snug line-clamp-3 mb-2">
        {beca.nombre}
      </h3>

      {isExpired && (
        <div className="flex items-center gap-1.5 mb-3">
          <Clock className="w-3.5 h-3.5 text-amber-500 shrink-0" />
          <span className="text-xs font-medium text-amber-600 bg-amber-50 px-2 py-0.5 rounded-full">
            Postulación cerrada
          </span>
        </div>
      )}

      {beca.descripcionCorta && (
        <p className="text-sm text-gray-500 mb-4 line-clamp-3">{beca.descripcionCorta}</p>
      )}

      <div className="space-y-2.5 text-sm text-gray-600 mt-auto">
        <div className="flex items-center gap-2">
          <Building2 className="w-4 h-4 text-gray-400 shrink-0" />
          <span className="truncate">{beca.nombreInstitucion}</span>
        </div>

        {beca.montoCobertura && (
          <div className="flex items-start gap-2">
            <Tag className="w-4 h-4 text-gray-400 shrink-0 mt-0.5" />
            <span className="line-clamp-2">{beca.montoCobertura}</span>
          </div>
        )}

        <div className="flex items-center gap-2">
          <MapPin className="w-4 h-4 text-gray-400 shrink-0" />
          <span className="truncate">{beca.nombreRegion}</span>
        </div>

        <div className="flex items-center gap-2">
          <Calendar className="w-4 h-4 text-gray-400 shrink-0" />
          <span className="truncate">Cierre: {formatDate(beca.fechaCierrePostulacion)}</span>
        </div>
      </div>
    </div>
  );
}
