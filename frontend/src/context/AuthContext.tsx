import { createContext, useContext, useState, useEffect, useCallback, type ReactNode } from 'react';
import { jwtDecode } from 'jwt-decode';
import api from '../services/api';
import type { User, AuthContextType as ACT, ApiResponse, AuthResponse } from '../types';

interface JwtPayload {
  sub: string;
  role: string;
  nombre: string;
  exp: number;
}

const AuthContext = createContext<ACT | null>(null);

const TOKEN_KEY = 'token';
const USER_KEY = 'user';

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [token, setToken] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const storedToken = localStorage.getItem(TOKEN_KEY);
    if (storedToken) {
      try {
        const decoded = jwtDecode<JwtPayload>(storedToken);
        const now = Date.now() / 1000;
        if (decoded.exp > now) {
          setToken(storedToken);
          setUser({
            idUsuario: 0,
            email: decoded.sub,
            nombreCompleto: decoded.nombre,
            rol: decoded.role,
            activo: true,
          });
        } else {
          localStorage.removeItem(TOKEN_KEY);
          localStorage.removeItem(USER_KEY);
        }
      } catch {
        localStorage.removeItem(TOKEN_KEY);
        localStorage.removeItem(USER_KEY);
      }
    }
    setLoading(false);
  }, []);

  const login = useCallback(async (email: string, password: string) => {
    const { data } = await api.post<ApiResponse<AuthResponse>>('/auth/login', { email, password });
    const { token: jwtToken, nombreRol, nombreCompleto } = data.data;

    localStorage.setItem(TOKEN_KEY, jwtToken);

    const userData: User = {
      idUsuario: 0,
      email,
      nombreCompleto,
      rol: nombreRol,
      activo: true,
    };
    localStorage.setItem(USER_KEY, JSON.stringify(userData));

    setToken(jwtToken);
    setUser(userData);
  }, []);

  const logout = useCallback(() => {
    localStorage.removeItem(TOKEN_KEY);
    localStorage.removeItem(USER_KEY);
    setToken(null);
    setUser(null);
  }, []);

  const value: ACT = {
    user,
    token,
    loading,
    login,
    logout,
    isAuthenticated: !!token,
    isAdmin: user?.rol === 'ADMIN',
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth(): ACT {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth debe usarse dentro de un AuthProvider');
  }
  return context;
}
