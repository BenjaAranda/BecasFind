import { useState, type FormEvent } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/useAuth';
import { ArrowRight, LoaderCircle } from 'lucide-react';
import AuthLayout from '../components/layout/AuthLayout';
import PasswordField from '../components/common/PasswordField';
import { authFormError } from '../utils/authFormError';

export default function LoginPage() {
  const { login } = useAuth();
  const navigate = useNavigate();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    if (loading) return;
    setError('');
    if (new TextEncoder().encode(password).length > 72) {
      setError('La contraseña supera la longitud permitida. Usa menos caracteres.');
      return;
    }
    setLoading(true);

    try {
      await login(email.trim(), password);
      navigate('/explorar');
    } catch (err: unknown) {
      setError(authFormError(err, 'Error de conexión. Intenta nuevamente.'));
    } finally {
      setLoading(false);
    }
  };

  return (
    <AuthLayout title="Iniciar Sesión" description="Vuelve a tus favoritas y continúa buscando oportunidades para estudiar."
      footer={<p>¿Todavía no tienes cuenta? <Link to="/register" className="font-semibold text-[#123f48] underline underline-offset-4 rounded focus-visible:outline-2 focus-visible:outline-offset-4">Regístrate</Link></p>}>
      {error && <p role="alert" className="mb-5 border-l-2 border-red-700 bg-red-50 p-3 text-sm text-red-800">{error}</p>}
      <form onSubmit={handleSubmit} aria-busy={loading} className="space-y-5">
        <div>
          <label htmlFor="email" className="block text-sm font-medium mb-2">Correo electrónico</label>
          <input id="email" type="email" required maxLength={254} autoComplete="email" disabled={loading}
            value={email} onChange={event => setEmail(event.target.value)} placeholder="maria@email.com"
            className="w-full min-h-12 px-3 py-3 border border-[#b9cac8] rounded-sm text-slate-900 placeholder:text-slate-400 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#123f48] disabled:bg-slate-50" />
        </div>
        <PasswordField id="password" label="Contraseña" value={password} onChange={setPassword} disabled={loading} placeholder="Tu contraseña" />
        <div className="text-right"><Link to="/forgot-password" className="text-sm text-[#123f48] underline underline-offset-4 rounded focus-visible:outline-2 focus-visible:outline-offset-4">¿Olvidaste tu contraseña?</Link></div>
        <button type="submit" disabled={loading} className="w-full min-h-12 flex items-center justify-between gap-3 bg-[#123f48] hover:bg-[#1a525c] text-white font-medium py-3 px-4 rounded-sm transition-colors disabled:opacity-60 disabled:cursor-wait focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-[#123f48]">
          {loading ? 'Ingresando...' : 'Ingresar'}
          {loading ? <LoaderCircle size={18} className="animate-spin motion-reduce:animate-none" aria-hidden="true" /> : <ArrowRight size={18} aria-hidden="true" />}
        </button>
        {loading && <p role="status" className="text-xs text-slate-600">Comprobando tu acceso…</p>}
      </form>
    </AuthLayout>
  );
}
