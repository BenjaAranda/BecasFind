import { type BecaSummary } from '../../types';
import { Calendar, Building2, Tag, MapPin } from 'lucide-react';

interface BecaCardProps {
  beca: BecaSummary;
  onClick: (id: number) => void;
}

export default function BecaCard({ beca, onClick }: BecaCardProps) {
  const formatDate = (dateStr: string) =>
    new Date(dateStr).toLocaleDateString('es-CL', {
      day: 'numeric',
      month: 'long',
      year: 'numeric',
    });

  return (
    <div
      onClick={() => onClick(beca.idBeca)}
      className="bg-white rounded-xl shadow-sm border border-gray-100 p-5 hover:shadow-md hover:border-blue-200 transition cursor-pointer"
    >
      <div className="flex items-start justify-between mb-3">
        <h3 className="font-semibold text-gray-800 leading-snug pr-2">{beca.nombre}</h3>
        <span className="shrink-0 text-xs font-medium px-2 py-1 bg-blue-50 text-blue-700 rounded-full">
          {beca.nombreTipoBeca}
        </span>
      </div>

      {beca.descripcionCorta && (
        <p className="text-sm text-gray-500 mb-4 line-clamp-2">{beca.descripcionCorta}</p>
      )}

      <div className="space-y-2 text-sm text-gray-600">
        <div className="flex items-center gap-2">
          <Building2 className="w-4 h-4 text-gray-400 shrink-0" />
          <span>{beca.nombreInstitucion}</span>
        </div>

        {beca.montoCobertura && (
          <div className="flex items-center gap-2">
            <Tag className="w-4 h-4 text-gray-400 shrink-0" />
            <span>{beca.montoCobertura}</span>
          </div>
        )}

        <div className="flex items-center gap-2">
          <MapPin className="w-4 h-4 text-gray-400 shrink-0" />
          <span>{beca.nombreRegion}</span>
        </div>

        <div className="flex items-center gap-2">
          <Calendar className="w-4 h-4 text-gray-400 shrink-0" />
          <span>Cierre: {formatDate(beca.fechaCierrePostulacion)}</span>
        </div>
      </div>
    </div>
  );
}
