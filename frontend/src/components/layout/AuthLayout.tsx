import { ArrowRight, GraduationCap } from 'lucide-react';
import { Link } from 'react-router-dom';
import type { ReactNode } from 'react';

export default function AuthLayout({ title, description, children, footer }: {
  title: string; description: string; children: ReactNode; footer: ReactNode;
}) {
  return (
    <main className="min-h-screen bg-[#f8fafc] text-[#16324f] px-5 py-7 sm:px-10 sm:py-10">
      <div className="mx-auto max-w-6xl">
        <header className="flex items-center justify-between gap-4 mb-8 lg:mb-12">
          <Link to="/" className="inline-flex items-center gap-3 rounded font-semibold text-xl focus-visible:outline-2 focus-visible:outline-offset-4">
            <GraduationCap size={30} aria-hidden="true" /> BecasFind
          </Link>
          <Link to="/" className="text-sm underline underline-offset-4 rounded focus-visible:outline-2 focus-visible:outline-offset-4">Volver al inicio</Link>
        </header>
        <div className="grid gap-8 lg:grid-cols-[1fr_1fr] lg:gap-14 items-center">
          <aside className="hidden lg:flex relative min-h-[610px] flex-col justify-between overflow-hidden bg-[#0b3c75] text-[#f8fafc] p-12">
            <div aria-hidden="true" className="absolute -right-16 -top-16 h-64 w-64 rounded-full border border-white/15" />
            <p className="relative text-xs uppercase tracking-[0.2em] text-[#bfdbfe]">Becas y beneficios · Chile</p>
            <div className="relative py-10">
              <p className="font-sans font-semibold text-5xl xl:text-6xl leading-[1.08] tracking-tight">Más caminos<br />para seguir<br /><span className="text-[#bfdbfe]">estudiando.</span></p>
              <p className="mt-7 max-w-xs text-[#dbeafe] leading-relaxed">Explora oportunidades, organiza tus favoritas y encuentra opciones a partir de tu perfil.</p>
            </div>
            <div className="relative border-t border-white/20 pt-6 flex items-center gap-4 text-sm">
              <span className="font-sans font-semibold text-3xl text-[#bfdbfe]">01</span>
              <p>Tu próximo paso empieza<br /><span className="text-[#bfdbfe]">con una oportunidad.</span></p>
            </div>
          </aside>
          <section className="w-full max-w-lg mx-auto lg:py-6" aria-labelledby="auth-title">
            <p className="text-xs font-semibold uppercase tracking-[0.18em] text-[#375b80] mb-3">Tu espacio en BecasFind</p>
            <h1 id="auth-title" className="font-sans font-semibold text-4xl sm:text-5xl tracking-tight mb-4">{title}</h1>
            <p className="text-slate-600 leading-relaxed mb-8">{description}</p>
            <div className="bg-white border border-[#dbe3ed] p-6 sm:p-8 shadow-[0_8px_30px_-20px_#0b3c7533]">{children}</div>
            <div className="text-sm text-slate-600 mt-6 leading-relaxed">{footer}</div>
            <Link to="/" className="inline-flex items-center gap-2 text-sm text-[#375b80] mt-8 rounded focus-visible:outline-2 focus-visible:outline-offset-4">Conoce BecasFind <ArrowRight size={15} aria-hidden="true" /></Link>
          </section>
        </div>
      </div>
    </main>
  );
}
