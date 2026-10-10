import { ArrowLeft, GraduationCap } from 'lucide-react';
import { Link } from 'react-router-dom';
import type { ReactNode } from 'react';

export default function RecoveryLayout({ title, description, children }: {
  title: string; description: string; children: ReactNode;
}) {
  return (
    <main className="min-h-screen bg-[#f8fafc] text-slate-900 flex flex-col items-center justify-center px-5 py-12">
      <div className="w-full max-w-lg">
        <Link to="/" className="inline-flex items-center gap-3 text-[#0b3c75] font-bold text-xl mb-10 rounded focus-visible:outline-2 focus-visible:outline-offset-4">
          <GraduationCap size={30} aria-hidden="true" /> BecasFind
        </Link>
        <section className="border-t-4 border-[#0b3c75] bg-white px-6 py-8 sm:p-10 shadow-sm">
          <p className="text-xs uppercase tracking-[0.18em] font-semibold text-[#375b80] mb-4">Tu próxima oportunidad</p>
          <h1 className="text-3xl sm:text-4xl tracking-tight font-sans font-semibold text-[#0b3c75] mb-4">{title}</h1>
          <p className="text-slate-600 leading-relaxed mb-8">{description}</p>
          {children}
        </section>
        <Link to="/login" className="inline-flex items-center gap-2 mt-7 text-sm font-medium text-[#0b3c75] underline underline-offset-4 rounded focus-visible:outline-2 focus-visible:outline-offset-4">
          <ArrowLeft size={16} aria-hidden="true" /> Volver al inicio de sesión
        </Link>
      </div>
    </main>
  );
}
