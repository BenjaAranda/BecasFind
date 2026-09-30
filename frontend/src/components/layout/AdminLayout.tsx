import { Link, NavLink, Outlet, useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/useAuth';
import { GraduationCap, LayoutGrid, Users, LogOut, ArrowLeft, Menu, X } from 'lucide-react';
import { useEffect, useRef, useState } from 'react';

export default function AdminLayout() {
  const { logout } = useAuth();
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);
  const toggle = useRef<HTMLButtonElement>(null);
  useEffect(() => {
    if (!open) return;
    const escape = (event: KeyboardEvent) => {
      if (event.key === 'Escape') { setOpen(false); toggle.current?.focus(); }
    };
    window.addEventListener('keydown', escape);
    return () => window.removeEventListener('keydown', escape);
  }, [open]);
  const linkClass = ({ isActive }: { isActive: boolean }) => `flex min-h-11 items-center gap-3 px-3 py-2 text-sm rounded-sm focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#e5c58d] ${isActive ? 'bg-[#e7eeea] text-[#123f48] font-semibold' : 'text-[#cfdfdf] hover:bg-white/10'}`;
  return (
    <div className="min-h-screen bg-[#f5f3ed] flex flex-col lg:flex-row">
      <a href="#admin-main" className="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 bg-white text-[#123f48] p-3">Saltar al contenido</a>
      <aside className="bg-[#123f48] text-white shrink-0 lg:w-60 lg:sticky lg:top-0 lg:h-screen lg:flex lg:flex-col">
        <div className="p-5 border-b border-white/15 flex items-center justify-between gap-4">
          <div><Link to="/" className="inline-flex items-center gap-2 rounded font-semibold text-lg focus-visible:outline-2 focus-visible:outline-offset-4"><GraduationCap size={27} aria-hidden="true" /> BecasFind</Link>
            <p className="text-xs text-[#b7d4d5] mt-1">Panel de Administración</p></div>
          <button ref={toggle} type="button" aria-label={open ? 'Cerrar navegación administrativa' : 'Abrir navegación administrativa'} aria-expanded={open} aria-controls="admin-navigation"
            onClick={() => setOpen(current => !current)} className="lg:hidden min-h-11 min-w-11 flex items-center justify-center rounded-sm border border-white/30 focus-visible:outline-2 focus-visible:outline-offset-2">
            {open ? <X size={21} aria-hidden="true" /> : <Menu size={21} aria-hidden="true" />}
          </button>
        </div>
        <div id="admin-navigation" className={`${open ? 'flex' : 'hidden'} flex-col lg:flex lg:flex-1`}>
          <nav aria-label="Administración" className="flex-1 p-4 space-y-2">
            <p className="px-3 mb-4 text-[10px] uppercase tracking-[0.18em] text-[#b7d4d5]">Gestionar contenido</p>
            <NavLink to="/admin/becas" onClick={() => setOpen(false)} className={linkClass}><LayoutGrid size={17} aria-hidden="true" /> Becas</NavLink>
            <NavLink to="/admin/usuarios" onClick={() => setOpen(false)} className={linkClass}><Users size={17} aria-hidden="true" /> Usuarios</NavLink>
          </nav>
          <div className="p-4 border-t border-white/15 space-y-2">
            <Link to="/explorar" onClick={() => setOpen(false)} className="flex min-h-11 items-center gap-3 px-3 text-sm text-[#cfdfdf] rounded-sm hover:bg-white/10 focus-visible:outline-2 focus-visible:outline-offset-2"><ArrowLeft size={17} aria-hidden="true" /> Volver al Buscador</Link>
            <button onClick={() => { logout(); navigate('/login'); }} className="w-full min-h-11 flex items-center gap-3 px-3 text-sm text-[#ffd2c8] rounded-sm hover:bg-white/10 focus-visible:outline-2 focus-visible:outline-offset-2"><LogOut size={17} aria-hidden="true" /> Cerrar Sesión</button>
          </div>
        </div>
      </aside>
      <main id="admin-main" tabIndex={-1} className="flex-1 min-w-0 overflow-x-auto focus:outline-none"><Outlet /></main>
    </div>
  );
}
