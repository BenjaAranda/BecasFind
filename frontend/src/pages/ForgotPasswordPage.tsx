import { useState, type FormEvent } from 'react';
import { Link } from 'react-router-dom';
import api from '../services/api';
import { GraduationCap, Mail, KeyRound } from 'lucide-react';

const Card = ({ children, title }: { children: React.ReactNode; title: string }) => (
  <div className="w-full max-w-md">
    <div className="text-center mb-8">
      <Link to="/" className="inline-flex items-center justify-center w-16 h-16 bg-white/20 rounded-2xl mb-4">
        <GraduationCap className="w-8 h-8 text-white" />
      </Link>
      <h1 className="text-3xl font-bold text-white">BecasFind</h1>
      <p className="text-blue-200 mt-2">{title}</p>
    </div>
    <div className="bg-white rounded-2xl shadow-xl p-8">
      {children}
    </div>
  </div>
);

export default function ForgotPasswordPage() {
  const [step, setStep] = useState<'email' | 'reset'>('email');
  const [email, setEmail] = useState('');
  const [token, setToken] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [loading, setLoading] = useState(false);

  const handleForgot = async (e: FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      await api.post('/auth/forgot-password', { email });
      setSuccess('Si el email existe, recibirás instrucciones. Token: revisa la consola del servidor.');
      setStep('reset');
    } catch {
      setError('Error al procesar la solicitud.');
    } finally {
      setLoading(false);
    }
  };

  const handleReset = async (e: FormEvent) => {
    e.preventDefault();
    setError('');
    setSuccess('');

    if (newPassword !== confirmPassword) {
      setError('Las contrasenias no coinciden');
      return;
    }

    if (newPassword.length < 8) {
      setError('La contrasenia debe tener al menos 8 caracteres');
      return;
    }

    setLoading(true);
    try {
      await api.post('/auth/reset-password', { token, newPassword });
      setSuccess('Contrasenia restablecida exitosamente. Redirigiendo...');
      setTimeout(() => window.location.href = '/login', 2000);
    } catch (err: unknown) {
      const axiosErr = err as { response?: { data?: { message?: string } } };
      setError(axiosErr.response?.data?.message || 'Token invalido o expirado.');
    } finally {
      setLoading(false);
    }
  };

  if (step === 'email') {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-600 to-blue-900 flex items-center justify-center p-4">
        <Card title="Recuperar Contraseña">
          {error && <div className="mb-4 p-3 bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg">{error}</div>}
          <form onSubmit={handleForgot} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Correo electrónico</label>
              <input type="email" value={email} onChange={e => setEmail(e.target.value)} required
                className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition text-gray-800" placeholder="tu@email.com" />
            </div>
            <button type="submit" disabled={loading}
              className="w-full flex items-center justify-center gap-2 bg-blue-600 hover:bg-blue-700 disabled:bg-blue-400 text-white font-medium py-2.5 rounded-lg transition cursor-pointer disabled:cursor-not-allowed">
              <Mail className="w-5 h-5" />
              {loading ? 'Enviando...' : 'Enviar enlace de recuperación'}
            </button>
          </form>
          <p className="mt-4 text-center text-sm text-gray-500">
            <Link to="/login" className="text-blue-600 hover:underline">Volver al inicio de sesión</Link>
          </p>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-600 to-blue-900 flex items-center justify-center p-4">
      <Card title="Nueva Contraseña">
        {success && <div className="mb-4 p-3 bg-green-50 border border-green-200 text-green-700 text-sm rounded-lg">{success}</div>}
        {error && <div className="mb-4 p-3 bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg">{error}</div>}
        <form onSubmit={handleReset} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Token de recuperación</label>
            <input type="text" value={token} onChange={e => setToken(e.target.value)} required
              className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition text-gray-800 font-mono text-sm" placeholder="UUID del token" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Nueva contraseña</label>
            <input type="password" value={newPassword} onChange={e => setNewPassword(e.target.value)} required minLength={8}
              className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition text-gray-800" placeholder="Mínimo 8 caracteres" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Confirmar contraseña</label>
            <input type="password" value={confirmPassword} onChange={e => setConfirmPassword(e.target.value)} required minLength={8}
              className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition text-gray-800" placeholder="Repite la contraseña" />
          </div>
          <button type="submit" disabled={loading}
            className="w-full flex items-center justify-center gap-2 bg-green-600 hover:bg-green-700 disabled:bg-green-400 text-white font-medium py-2.5 rounded-lg transition cursor-pointer disabled:cursor-not-allowed">
            <KeyRound className="w-5 h-5" />
            {loading ? 'Restableciendo...' : 'Restablecer Contraseña'}
          </button>
        </form>
        <p className="mt-4 text-center text-sm text-gray-500">
          <Link to="/login" className="text-blue-600 hover:underline">Volver al inicio de sesión</Link>
        </p>
      </Card>
    </div>
  );
}
