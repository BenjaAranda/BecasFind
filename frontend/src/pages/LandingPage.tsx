import { Link } from 'react-router-dom';
import PublicNavbar from '../components/layout/PublicNavbar';
import { Search, UserCheck, MapPin } from 'lucide-react';

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-white">
      <PublicNavbar />

      <section className="bg-gradient-to-br from-blue-600 via-blue-700 to-blue-900 text-white">
        <div className="max-w-4xl mx-auto px-4 py-20 md:py-28 text-center">
          <h1 className="text-4xl md:text-5xl font-extrabold leading-tight">
            Encuentra la beca<br />que se ajusta a tu perfil
          </h1>
          <p className="mt-4 text-lg text-blue-200 max-w-xl mx-auto">
            El primer motor de búsqueda inteligente que cruza tu Registro Social de Hogares,
            NEM y región con cientos de becas disponibles en Chile.
          </p>
          <div className="mt-8 flex flex-col sm:flex-row items-center justify-center gap-3">
            <Link to="/register" className="w-full sm:w-auto inline-flex items-center justify-center gap-2 bg-white text-blue-700 font-semibold px-6 py-3 rounded-xl hover:bg-blue-50 transition shadow-lg">
              Comenzar ahora
            </Link>
            <Link to="/explorar" className="w-full sm:w-auto inline-flex items-center justify-center gap-2 bg-blue-500/30 text-white font-medium px-6 py-3 rounded-xl hover:bg-blue-500/50 transition">
              <Search className="w-4 h-4" />
              Explorar becas
            </Link>
          </div>
        </div>
      </section>

      <section className="max-w-5xl mx-auto px-4 py-16 grid grid-cols-1 md:grid-cols-3 gap-8">
        <div className="text-center">
          <div className="inline-flex items-center justify-center w-12 h-12 bg-blue-100 rounded-xl mb-4">
            <UserCheck className="w-6 h-6 text-blue-600" />
          </div>
          <h3 className="font-semibold text-gray-900 mb-2">Perfil Personalizado</h3>
          <p className="text-sm text-gray-500">
            Registra tu RSH, NEM y región. El sistema filtra automáticamente las becas que realmente puedes obtener.
          </p>
        </div>
        <div className="text-center">
          <div className="inline-flex items-center justify-center w-12 h-12 bg-green-100 rounded-xl mb-4">
            <Search className="w-6 h-6 text-green-600" />
          </div>
          <h3 className="font-semibold text-gray-900 mb-2">Búsqueda Inteligente</h3>
          <p className="text-sm text-gray-500">
            Filtra por monto, fecha de cierre, institución y tipo de beca. Solo ves lo que aplica para ti.
          </p>
        </div>
        <div className="text-center">
          <div className="inline-flex items-center justify-center w-12 h-12 bg-amber-100 rounded-xl mb-4">
            <MapPin className="w-6 h-6 text-amber-600" />
          </div>
          <h3 className="font-semibold text-gray-900 mb-2">Cobertura Nacional</h3>
          <p className="text-sm text-gray-500">
            Becas de las 16 regiones de Chile. Universidades, institutos, fundaciones y organismos públicos.
          </p>
        </div>
      </section>

      <footer className="border-t border-gray-100 py-8 text-center text-sm text-gray-400">
        BecasFind — Motor de búsqueda de becas estudiantiles · Chile {new Date().getFullYear()}
      </footer>
    </div>
  );
}
