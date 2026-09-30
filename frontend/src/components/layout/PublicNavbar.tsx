import { NavLink, Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/useAuth';
import { GraduationCap, Menu, X } from 'lucide-react';
import { useEffect, useRef, useState } from 'react';

export default function PublicNavbar() {
  const { isAuthenticated, isAdmin, user, logout } = useAuth();
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);
  const toggle = useRef<HTMLButtonElement>(null);
  const close = () => setOpen(false);
  useEffect(() => {
    if (!open) return;
    const escape = (event: KeyboardEvent) => {
      if (event.key === 'Escape') { setOpen(false); toggle.current?.focus(); }
    };
    window.addEventListener('keydown', escape);
    return () => window.removeEventListener('keydown', escape);
  }, [open]);
  const linkClass = ({ isActive }: { isActive: boolean }) => `inline-flex min-h-11 items-center px-3 text-sm rounded-sm focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#123f48] ${isActive ? 'bg-[#e7eeea] text-[#123f48] font-semibold' : 'text-slate-600 hover:bg-[#eef1eb] hover:text-[#123f48]'}`;
  return (
    <header className="sticky top-0 z-30 border-b border-[#dce3df] bg-[#f5f3ed] text-[#123f48]">
      <div className="relative max-w-7xl mx-auto px-4 sm:px-6">
        <div className="h-18 flex items-center justify-between gap-4">
          <Link to="/" onClick={close} className="inline-flex items-center gap-2.5 rounded font-semibold text-xl focus-visible:outline-2 focus-visible:outline-offset-4">
            <GraduationCap size={28} aria-hidden="true" /> BecasFind
          </Link>
          <button ref={toggle} type="button" aria-label={open ? 'Cerrar menú' : 'Abrir menú'} aria-expanded={open} aria-controls="public-navigation"
            onClick={() => setOpen(current => !current)} className="lg:hidden flex items-center justify-center min-h-11 min-w-11 rounded-sm border border-[#c5d5d0] focus-visible:outline-2 focus-visible:outline-offset-2">
            {open ? <X size={21} aria-hidden="true" /> : <Menu size={21} aria-hidden="true" />}
          </button>
          <nav id="public-navigation" aria-label="Navegación principal" className={`${open ? 'flex' : 'hidden'} absolute top-18 left-0 right-0 border-b border-[#dce3df] bg-[#f5f3ed] p-4 flex-col gap-1 shadow-sm lg:static lg:flex lg:flex-row lg:items-center lg:border-0 lg:bg-transparent lg:p-0 lg:shadow-none`}>
            <NavLink to="/explorar" onClick={close} className={linkClass}>Explorar Becas</NavLink>
            {isAuthenticated ? <>
              <NavLink to="/favoritos" onClick={close} className={linkClass}>Favoritos</NavLink>
              <NavLink to="/perfil" onClick={close} className={linkClass}>Mi Perfil</NavLink>
              {isAdmin && <NavLink to="/admin" onClick={close} className={linkClass}>Admin</NavLink>}
              <span className="max-w-32 truncate px-3 py-2 text-xs text-[#46717a]" title={user?.nombreCompleto}>{user?.nombreCompleto}</span>
              <button onClick={() => { close(); logout(); navigate('/'); }} className="min-h-11 px-3 text-left text-sm text-red-800 rounded-sm hover:bg-red-50 focus-visible:outline-2 focus-visible:outline-offset-2">Salir</button>
            </> : <>
              <NavLink to="/login" onClick={close} className={linkClass}>Ingresar</NavLink>
              <NavLink to="/register" onClick={close} className="inline-flex min-h-11 items-center justify-center px-4 text-sm font-medium rounded-sm bg-[#123f48] text-white hover:bg-[#1a525c] focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-[#123f48]">Registrarse</NavLink>
            </>}
          </nav>
        </div>
      </div>
    </header>
  );
}
