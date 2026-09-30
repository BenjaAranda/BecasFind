import { useState, type FormEvent } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/useAuth';
import { ArrowRight, LoaderCircle } from 'lucide-react';
import AuthLayout from '../components/layout/AuthLayout';
import PasswordField from '../components/common/PasswordField';

export default function RegisterPage() {
  const { register } = useAuth();
  const navigate = useNavigate();

  const [nombreCompleto, setNombreCompleto] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    if (loading) return;
    setError('');

    if (password !== confirmPassword) {
      setError('Las contraseñas no coinciden');
      return;
    }

    if (password.length < 8) {
      setError('La contraseña debe tener al menos 8 caracteres');
      return;
    }

    if (!nombreCompleto.trim()) {
      setError('Escribe tu nombre completo.');
      return;
    }
    if (new TextEncoder().encode(password).length > 72) {
      setError('La contraseña es demasiado larga. Usa menos caracteres.');
      return;
    }
    setLoading(true);
    try {
      await register(nombreCompleto.trim(), email.trim(), password);
      navigate('/explorar');
    } catch (err: unknown) {
      const axiosErr = err as { response?: { data?: { message?: string } } };
      setError(axiosErr.response?.data?.message || 'Error al registrar. Intenta nuevamente.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <AuthLayout title="Crear Cuenta" description="Organiza tus becas favoritas y encuentra opciones según tu perfil."
      footer={<p>¿Ya tienes cuenta? <Link to="/login" className="font-semibold text-[#123f48] underline underline-offset-4 rounded focus-visible:outline-2 focus-visible:outline-offset-4">Ingresa aquí</Link></p>}>
      {error && <p role="alert" className="mb-5 border-l-2 border-red-700 bg-red-50 p-3 text-sm text-red-800">{error}</p>}
      <form onSubmit={handleSubmit} aria-busy={loading} className="space-y-5">
        <div>
          <label htmlFor="nombre" className="block text-sm font-medium mb-2">Nombre Completo</label>
          <input id="nombre" type="text" required autoComplete="name" disabled={loading} value={nombreCompleto}
            onChange={event => setNombreCompleto(event.target.value)} placeholder="María González"
            className="w-full min-h-12 px-3 py-3 border border-[#b9cac8] rounded-sm text-slate-900 placeholder:text-slate-400 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#123f48] disabled:bg-slate-50" />
        </div>
        <div>
          <label htmlFor="email" className="block text-sm font-medium mb-2">Correo electrónico</label>
          <input id="email" type="email" required maxLength={254} autoComplete="email" disabled={loading} value={email}
            onChange={event => setEmail(event.target.value)} placeholder="maria@email.com"
            className="w-full min-h-12 px-3 py-3 border border-[#b9cac8] rounded-sm text-slate-900 placeholder:text-slate-400 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#123f48] disabled:bg-slate-50" />
        </div>
        <PasswordField id="password" label="Contraseña" value={password} onChange={setPassword} disabled={loading} newPassword
          placeholder="Mínimo 8 caracteres" help="Usa al menos 8 caracteres. Puedes combinar palabras, números y símbolos." />
        <PasswordField id="confirmPassword" label="Confirmar Contraseña" value={confirmPassword} onChange={setConfirmPassword}
          disabled={loading} newPassword placeholder="Repite la contraseña" visibilityLabel="confirmación de contraseña" />
        <button type="submit" disabled={loading} className="w-full min-h-12 flex items-center justify-between gap-3 bg-[#123f48] hover:bg-[#1a525c] text-white font-medium py-3 px-4 rounded-sm transition-colors disabled:opacity-60 disabled:cursor-wait focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-[#123f48]">
          {loading ? 'Creando cuenta...' : 'Crear Cuenta'}
          {loading ? <LoaderCircle size={18} className="animate-spin motion-reduce:animate-none" aria-hidden="true" /> : <ArrowRight size={18} aria-hidden="true" />}
        </button>
        {loading && <p role="status" className="text-xs text-slate-600">Creando tu cuenta…</p>}
      </form>
    </AuthLayout>
  );
}
