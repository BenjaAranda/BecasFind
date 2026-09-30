import { useState, type FormEvent } from 'react';
import { isAxiosError } from 'axios';
import { Mail, CheckCircle2 } from 'lucide-react';
import api from '../services/api';
import RecoveryLayout from '../components/common/RecoveryLayout';
import { authFormError } from '../utils/authFormError';

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState('');
  const [sent, setSent] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    if (loading) return;
    setError('');
    setLoading(true);
    try {
      await api.post('/auth/forgot-password', { email: email.trim() });
      setSent(true);
    } catch (err: unknown) {
      const status = isAxiosError(err) ? err.response?.status : undefined;
      setError(status === 429 ? 'Has realizado demasiados intentos. Espera unos minutos antes de volver a solicitar el enlace.'
        : status === 503 ? 'La recuperación por correo aún no está disponible. Inténtalo más tarde.'
        : authFormError(err, 'No pudimos procesar tu solicitud. Revisa tu conexión e inténtalo de nuevo.'));
    } finally {
      setLoading(false);
    }
  }

  return (
    <RecoveryLayout title="Recupera tu acceso" description="Escribe el correo que usaste al registrarte. Te enviaremos un enlace para elegir una nueva contraseña.">
      {sent ? (
        <div role="status" className="bg-[#edf5ef] border border-green-200 p-5 text-green-900">
          <CheckCircle2 className="mb-3" aria-hidden="true" />
          <p className="font-semibold mb-2">Revisa tu correo</p>
          <p className="text-sm leading-relaxed">Si el correo está registrado, recibirás un enlace que vence en 15 minutos. Revisa también la carpeta de spam.</p>
          <button type="button" onClick={() => setSent(false)} className="mt-4 text-sm underline underline-offset-4 cursor-pointer">Solicitar otro enlace</button>
        </div>
      ) : (
        <form onSubmit={handleSubmit} className="space-y-5" aria-busy={loading}>
          {error && <p role="alert" className="bg-red-50 border border-red-200 text-red-800 p-3 text-sm">{error}</p>}
          <div>
            <label htmlFor="recovery-email" className="block text-sm font-semibold mb-2">Correo electrónico</label>
            <input id="recovery-email" type="email" autoComplete="email" maxLength={254} required value={email}
              onChange={event => setEmail(event.target.value)} disabled={loading}
              className="w-full border border-slate-300 rounded-md px-4 py-3 focus:outline-2 focus:outline-[#123f48] focus:outline-offset-2" placeholder="tu@correo.cl" />
          </div>
          <button type="submit" disabled={loading} className="w-full flex items-center justify-center gap-2 bg-[#123f48] text-white rounded-md py-3 font-semibold hover:bg-[#205865] disabled:opacity-60 focus-visible:outline-2 focus-visible:outline-offset-4 cursor-pointer disabled:cursor-wait">
            <Mail size={18} aria-hidden="true" />{loading ? 'Enviando solicitud…' : 'Enviar enlace de recuperación'}
          </button>
        </form>
      )}
    </RecoveryLayout>
  );
}
