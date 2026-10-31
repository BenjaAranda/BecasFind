import { Link } from 'react-router-dom';
import PublicNavbar from '../components/layout/PublicNavbar';
import { useAuth } from '../context/useAuth';
import { ArrowRight, Bookmark, Search, SlidersHorizontal, ArrowUpRight } from 'lucide-react';

const steps = [
  { number: '01', icon: Search, title: 'Explora tus opciones', text: 'Busca por nombre, institución, tipo de beca o región. Compara la cobertura y las fechas de postulación.' },
  { number: '02', icon: SlidersHorizontal, title: 'Encuentra coincidencias', text: 'Completa tu RSH, promedio NEM y región para consultar recomendaciones basadas en esos datos.' },
  { number: '03', icon: Bookmark, title: 'Guarda tu próximo paso', text: 'Organiza tus favoritas y consulta los requisitos, documentos y convocatoria oficial de cada beca.' },
];
const focus = 'focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-[#0b3c75]';

export default function LandingPage() {
  const { isAuthenticated } = useAuth();
  return (
    <div className="min-h-screen bg-[#f8fafc] text-[#0b3c75]">
      <a href="#landing-main" className="sr-only focus:not-sr-only focus:fixed focus:top-3 focus:left-3 focus:z-50 focus:bg-white focus:p-3">Saltar al contenido</a>
      <PublicNavbar />
      <main id="landing-main" tabIndex={-1}>
        <section aria-labelledby="landing-title" className="max-w-7xl mx-auto px-5 sm:px-8 py-12 lg:py-20 grid lg:grid-cols-[1.2fr_1fr] gap-12 lg:gap-16 items-center">
          <div>
            <p className="text-xs uppercase tracking-[0.2em] text-[#375b80] mb-6">Becas y beneficios · Chile</p>
            <h1 id="landing-title" className="font-sans font-semibold text-4xl sm:text-5xl lg:text-6xl leading-[1.04] tracking-tight">Más caminos<br />para seguir<br /><span className="text-blue-700">estudiando.</span></h1>
            <p className="max-w-lg mt-7 text-base sm:text-lg leading-relaxed text-slate-600">Un lugar para explorar oportunidades educativas, comparar requisitos y organizar las becas que te interesan.</p>
            <div className="mt-8 flex flex-col sm:flex-row gap-4">
              <Link to="/explorar" className={`min-h-12 inline-flex items-center justify-between gap-6 bg-[#0b3c75] hover:bg-[#082e5b] text-white px-5 py-3 rounded-sm transition-colors ${focus}`}>
                Explorar becas <ArrowRight size={18} aria-hidden="true" />
              </Link>
              <Link to={isAuthenticated ? '/perfil' : '/login'} className={`min-h-12 inline-flex items-center justify-center px-3 underline underline-offset-4 rounded-sm ${focus}`}>
                {isAuthenticated ? 'Completar mi perfil' : 'Ya tengo cuenta'}
              </Link>
            </div>
            <p className="mt-4 text-sm text-slate-600">{isAuthenticated ? 'Tus favoritas y tu perfil acompañan tu búsqueda.' : 'Explora gratis y sin cuenta. Inicia sesión solo para guardar tu perfil y favoritas o acceder como administrador.'}</p>
          </div>
          <div className="relative overflow-hidden bg-[#0b3c75] text-[#f8fafc] p-7 sm:p-10 min-h-96 flex flex-col justify-between">
            <div aria-hidden="true" className="absolute w-72 h-72 border border-white/15 rounded-full -right-28 -top-24" />
            <p className="relative text-xs uppercase tracking-[0.2em] text-[#bfdbfe]">Una decisión a la vez</p>
            <div className="relative py-10">
              <p className="font-sans font-semibold text-4xl sm:text-5xl leading-tight">Explora.<br />Compara.<br /><span className="text-[#bfdbfe]">Prepárate.</span></p>
            </div>
            <div className="relative border-t border-white/25 pt-5 flex gap-4 items-start">
              <ArrowUpRight className="shrink-0 text-[#bfdbfe]" size={25} aria-hidden="true" />
              <p className="text-sm leading-relaxed">La recomendación es un punto de partida. La institución define los requisitos y decide la adjudicación.</p>
            </div>
          </div>
        </section>

        <section aria-labelledby="steps-title" className="border-y border-[#dbe3ed] bg-white">
          <div className="max-w-7xl mx-auto px-5 sm:px-8 py-12 sm:py-16">
            <p className="text-xs uppercase tracking-[0.2em] text-[#375b80] mb-3">Cómo funciona</p>
            <h2 id="steps-title" className="font-sans font-semibold text-3xl sm:text-4xl mb-10">De la búsqueda a tu siguiente paso.</h2>
            <ol className="grid md:grid-cols-3 gap-8 lg:gap-12">
              {steps.map(({ number, icon: Icon, title, text }) => <li key={number} className="border-t border-[#cbd5e1] pt-5">
                <div className="flex items-center justify-between mb-7"><span className="font-sans font-semibold text-3xl text-[#375b80]">{number}</span><Icon size={22} aria-hidden="true" /></div>
                <h3 className="font-sans font-semibold text-2xl mb-3">{title}</h3>
                <p className="text-sm leading-relaxed text-slate-600">{text}</p>
              </li>)}
            </ol>
          </div>
        </section>

        <section aria-labelledby="prepare-title" className="max-w-7xl mx-auto px-5 sm:px-8 py-12 sm:py-16 grid md:grid-cols-2 gap-8 items-start">
          <div><p className="text-xs uppercase tracking-[0.2em] text-[#375b80] mb-3">Antes de postular</p><h2 id="prepare-title" className="font-sans font-semibold text-3xl sm:text-4xl">Consulta siempre<br />la fuente oficial.</h2></div>
          <div className="text-slate-600 leading-relaxed space-y-4"><p>Revisa las fechas, los documentos y las condiciones en el sitio de la institución. Los requisitos pueden cambiar y una coincidencia con tu perfil no garantiza que puedas postular ni recibir el beneficio.</p><p>BecasFind te ayuda a explorar y organizar información. La postulación se realiza según las instrucciones de cada convocatoria.</p></div>
        </section>
      </main>
      <footer className="border-t border-[#dbe3ed] max-w-7xl mx-auto px-5 sm:px-8 py-7 flex flex-col sm:flex-row justify-between gap-4 text-sm text-slate-600">
        <p>BecasFind · Oportunidades educativas en Chile</p>
        <Link to="/explorar" className={`text-[#0b3c75] underline underline-offset-4 rounded-sm ${focus}`}>Ir al buscador</Link>
      </footer>
    </div>
  );
}
