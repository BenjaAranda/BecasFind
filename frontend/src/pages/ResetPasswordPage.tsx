import { useEffect, useState, type FormEvent } from 'react';
import { isAxiosError } from 'axios';
import { Link } from 'react-router-dom';
import { CheckCircle2, KeyRound } from 'lucide-react';
import api from '../services/api';
import RecoveryLayout from '../components/common/RecoveryLayout';

export default function ResetPasswordPage() {
  const [token] = useState(() => {
    const value = new URLSearchParams(window.location.hash.slice(1)).get('token') || '';
    return /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(value) ? value : '';
  });
  const [password, setPassword] = useState('');
  const [confirmation, setConfirmation] = useState('');
  const [error, setError] = useState('');
  const [invalid, setInvalid] = useState(false);
  const [done, setDone] = useState(false);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // El fragmento no viaja al servidor; retirarlo del historial tras leerlo.
    window.history.replaceState(window.history.state, '', window.location.pathname + window.location.search);
  }, []);

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    if (loading) return;
    setError('');
    if (new TextEncoder().encode(password).length > 72) {
      setError('La contraseña es demasiado larga. Usa menos caracteres, especialmente si incluyen tildes o símbolos.');
      return;
    }
    if (password !== confirmation) {
      setError('Las contraseñas no coinciden.');
      return;
    }
    setLoading(true);
    try {
      await api.post('/auth/reset-password', { token, newPassword: password });
      setPassword('');
      setConfirmation('');
      setDone(true);
    } catch (err: unknown) {
      const status = isAxiosError(err) ? err.response?.status : undefined;
      if (status === 401) setInvalid(true);
      setError(status === 429 ? 'Has realizado demasiados intentos. Espera unos minutos e inténtalo de nuevo.'
        : status === 401 ? 'Este enlace venció o ya fue utilizado. Solicita uno nuevo.'
        : 'No pudimos cambiar tu contraseña. Revisa tu conexión e inténtalo de nuevo.');
    } finally {
      setLoading(false);
    }
  }

  return (
    <RecoveryLayout title={done ? 'Ya puedes volver' : 'Elige tu nueva contraseña'}
      description={done ? 'Tu contraseña se actualizó correctamente. Inicia sesión con ella para continuar.' : 'Usa al menos 8 caracteres. Este enlace funciona una sola vez y vence en 15 minutos.'}>
      {done ? (
        <div role="status" className="text-green-900">
          <CheckCircle2 aria-hidden="true" className="mb-4" />
          <Link to="/login" className="inline-block bg-[#123f48] text-white rounded-md px-5 py-3 font-semibold">Iniciar sesión</Link>
        </div>
      ) : !token || invalid ? (
        <div>
          <p role="alert" className="bg-amber-50 border border-amber-200 text-amber-900 p-4 mb-5">{error || 'El enlace está incompleto o no es válido. Solicita uno nuevo para recuperar tu acceso.'}</p>
          <Link to="/forgot-password" className="font-semibold text-[#123f48] underline underline-offset-4">Solicitar un nuevo enlace</Link>
        </div>
      ) : (
        <form onSubmit={handleSubmit} className="space-y-5" aria-busy={loading}>
          {error && <p role="alert" className="bg-red-50 border border-red-200 text-red-800 p-3 text-sm">{error}</p>}
          <div>
            <label htmlFor="new-password" className="block text-sm font-semibold mb-2">Nueva contraseña</label>
            <input id="new-password" type="password" autoComplete="new-password" required minLength={8} maxLength={72} value={password} disabled={loading}
              onChange={event => setPassword(event.target.value)} className="w-full border border-slate-300 rounded-md px-4 py-3 focus:outline-2 focus:outline-[#123f48] focus:outline-offset-2" />
          </div>
          <div>
            <label htmlFor="confirm-password" className="block text-sm font-semibold mb-2">Confirmar contraseña</label>
            <input id="confirm-password" type="password" autoComplete="new-password" required minLength={8} maxLength={72} value={confirmation} disabled={loading}
              onChange={event => setConfirmation(event.target.value)} className="w-full border border-slate-300 rounded-md px-4 py-3 focus:outline-2 focus:outline-[#123f48] focus:outline-offset-2" />
          </div>
          <button type="submit" disabled={loading} className="w-full flex items-center justify-center gap-2 bg-[#123f48] text-white rounded-md py-3 font-semibold hover:bg-[#205865] disabled:opacity-60 focus-visible:outline-2 focus-visible:outline-offset-4 cursor-pointer disabled:cursor-wait">
            <KeyRound size={18} aria-hidden="true" />{loading ? 'Guardando contraseña…' : 'Guardar nueva contraseña'}
          </button>
        </form>
      )}
    </RecoveryLayout>
  );
}
