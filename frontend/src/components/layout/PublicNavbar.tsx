import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import { GraduationCap, Search, UserPlus, LogIn, Menu, X } from 'lucide-react';
import { useState } from 'react';

export default function PublicNavbar() {
  const { isAuthenticated, isAdmin, logout } = useAuth();
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);

  const handleLogout = () => { logout(); navigate('/'); };

  return (
    <header className="bg-white/90 backdrop-blur border-b border-gray-200 sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 h-14 flex items-center justify-between">
        <Link to="/" className="flex items-center gap-2 hover:opacity-80 transition">
          <GraduationCap className="w-6 h-6 text-blue-600" />
          <span className="font-bold text-lg text-gray-900">BecasFind</span>
        </Link>

        <button onClick={() => setOpen(!open)} className="lg:hidden p-2">
          {open ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
        </button>

        <nav className={`${open ? 'flex' : 'hidden'} lg:flex absolute lg:static top-14 left-0 right-0 bg-white lg:bg-transparent border-b lg:border-b-0 flex-col lg:flex-row items-start lg:items-center gap-2 p-4 lg:p-0 shadow lg:shadow-none`}>
          <Link to="/explorar" className="flex items-center gap-1 text-sm text-gray-600 hover:text-blue-600 px-3 py-1.5 rounded-lg transition">
            <Search className="w-4 h-4" />
            Explorar Becas
          </Link>

          {isAuthenticated ? (
            <>
              {isAdmin && (
                <Link to="/admin" className="text-sm text-purple-600 hover:text-purple-700 px-3 py-1.5 rounded-lg transition font-medium">
                  Admin
                </Link>
              )}
              <button onClick={handleLogout} className="text-sm text-red-500 hover:text-red-600 px-3 py-1.5 rounded-lg transition cursor-pointer">
                Salir
              </button>
            </>
          ) : (
            <>
              <Link to="/login" className="flex items-center gap-1 text-sm text-gray-600 hover:text-blue-600 px-3 py-1.5 rounded-lg transition">
                <LogIn className="w-4 h-4" />
                Ingresar
              </Link>
              <Link to="/register" className="flex items-center gap-1 text-sm bg-blue-600 text-white px-4 py-1.5 rounded-lg hover:bg-blue-700 transition">
                <UserPlus className="w-4 h-4" />
                Registrarse
              </Link>
            </>
          )}
        </nav>
      </div>
    </header>
  );
}
