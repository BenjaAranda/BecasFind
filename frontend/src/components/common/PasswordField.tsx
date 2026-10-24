import { useState } from 'react';
import { Eye, EyeOff } from 'lucide-react';

export default function PasswordField({ id, label, value, onChange, disabled, newPassword = false, placeholder, help, visibilityLabel = 'contraseña' }: {
  id: string; label: string; value: string; onChange: (value: string) => void; disabled?: boolean;
  newPassword?: boolean; placeholder?: string; help?: string; visibilityLabel?: string;
}) {
  const [visible, setVisible] = useState(false);
  return (
    <div>
      <label htmlFor={id} className="block text-sm font-medium text-[#16324f] mb-2">{label}</label>
      <div className="relative">
        <input id={id} required disabled={disabled} type={visible ? 'text' : 'password'} value={value}
          onChange={event => onChange(event.target.value)} autoComplete={newPassword ? 'new-password' : 'current-password'}
          minLength={newPassword ? 8 : undefined} maxLength={72}
          aria-describedby={help ? `${id}-help` : undefined} placeholder={placeholder}
          className="w-full min-h-12 px-3 pr-14 py-3 border border-[#94a3b8] rounded-sm text-slate-900 placeholder:text-slate-400 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#0b3c75] disabled:bg-slate-50" />
        <button type="button" disabled={disabled} aria-label={`${visible ? 'Ocultar' : 'Mostrar'} ${visibilityLabel}`} aria-pressed={visible}
          onClick={() => setVisible(current => !current)} className="absolute inset-y-0 right-0 w-12 flex items-center justify-center text-[#375b80] hover:text-[#0b3c75] rounded-sm focus-visible:outline-2 focus-visible:outline-offset-2">
          {visible ? <EyeOff size={19} aria-hidden="true" /> : <Eye size={19} aria-hidden="true" />}
        </button>
      </div>
      {help && <p id={`${id}-help`} className="mt-2 text-xs text-slate-600 leading-relaxed">{help}</p>}
    </div>
  );
}
