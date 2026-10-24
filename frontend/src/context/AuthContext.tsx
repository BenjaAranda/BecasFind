import { useState, useEffect, useCallback, type ReactNode } from 'react';
import { jwtDecode } from 'jwt-decode';
import api from '../services/api';
import { AuthContext } from './useAuth';
import type { User, AuthContextType, ApiResponse, AuthResponse } from '../types';

interface Session {
  token: string;
  user: User;
  expiresAt: number;
}

function sessionFromToken(token: string): Session {
  const decoded = jwtDecode<{ sub: string; role: string; nombre: string; exp: number }>(token);
  if (typeof decoded.sub !== 'string' || !decoded.sub.trim()
      || typeof decoded.nombre !== 'string' || !decoded.nombre.trim()
      || !['ADMIN', 'STUDENT'].includes(decoded.role)
      || typeof decoded.exp !== 'number' || !Number.isFinite(decoded.exp)
      || decoded.exp * 1000 <= Date.now()) {
    throw new Error('La sesión recibida no es válida.');
  }
  // Decoding controls the interface only; the API verifies signature and permissions.
  return { token, expiresAt: decoded.exp * 1000, user: {
    idUsuario: 0, email: decoded.sub, nombreCompleto: decoded.nombre, rol: decoded.role, activo: true,
  } };
}

function readStoredSession(): Session | null {
  const token = localStorage.getItem('token');
  if (!token) return null;
  try { return sessionFromToken(token); }
  catch { return null; }
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<Session | null>(readStoredSession);

  useEffect(() => {
    // The legacy user cache is unnecessary: restored identity comes from the token.
    localStorage.removeItem('user');
    if (!session) {
      localStorage.removeItem('token');
      return;
    }
    const timer = setTimeout(() => setSession(readStoredSession()),
      Math.min(Math.max(0, session.expiresAt - Date.now()), 2_147_483_647));
    return () => clearTimeout(timer);
  }, [session]);

  useEffect(() => {
    const sync = (event: StorageEvent) => {
      if (event.storageArea === localStorage && (event.key === 'token' || event.key === null)) {
        setSession(readStoredSession());
      }
    };
    window.addEventListener('storage', sync);
    return () => window.removeEventListener('storage', sync);
  }, []);

  const saveSession = useCallback((token: string) => {
    const next = sessionFromToken(token);
    localStorage.setItem('token', token);
    setSession(next);
  }, []);

  const login = useCallback(async (email: string, password: string) => {
    const { data } = await api.post<ApiResponse<AuthResponse>>('/auth/login', { email, password });
    saveSession(data.data.token);
  }, [saveSession]);

  const register = useCallback(async (nombreCompleto: string, email: string, password: string) => {
    const { data } = await api.post<ApiResponse<AuthResponse>>('/auth/register', { nombreCompleto, email, password });
    saveSession(data.data.token);
  }, [saveSession]);

  const logout = useCallback(() => {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    setSession(null);
  }, []);

  const value: AuthContextType = {
    user: session?.user ?? null, token: session?.token ?? null, loading: false,
    login, register, logout, isAuthenticated: !!session, isAdmin: session?.user.rol === 'ADMIN',
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}
