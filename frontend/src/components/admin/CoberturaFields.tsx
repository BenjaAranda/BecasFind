import type { Cobertura } from '../../types';

const currencies = Intl.supportedValuesOf('currency');
const inputClass = 'w-full min-h-11 px-3 py-2 border border-[#94a3b8] rounded-sm text-sm bg-[#ffffff] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#0b3c75]';

export default function CoberturaFields({ value, onChange }: { value: Cobertura; onChange: (value: Cobertura) => void }) {
  const update = (field: keyof Cobertura, text: string) => onChange({ ...value, [field]: text || null });
  return (
    <fieldset className="border-t pt-4 space-y-3 min-w-0" aria-describedby="coverage-help">
      <legend className="font-semibold text-sm text-[#16324f]">Datos del beneficio</legend>
      <p id="coverage-help" className="text-sm text-slate-600">Registra solo lo indicado por la fuente. Conserva el texto original; deja vacíos los datos desconocidos. No conviertas porcentajes ni monedas.</p>
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <div>
          <label htmlFor="coverage-type" className="block text-sm mb-1">Tipo de cobertura</label>
          <select id="coverage-type" value={value.tipo} onChange={e => onChange({ tipo: e.target.value as Cobertura['tipo'] })} className={inputClass}>
            <option value="DESCONOCIDA">Sin información confirmada</option>
            <option value="MONETARIA">Importe monetario</option>
            <option value="PORCENTUAL">Porcentaje de cobertura</option>
            <option value="NO_MONETARIA">Beneficio no monetario</option>
          </select>
        </div>
        {value.tipo === 'MONETARIA' && <>
          <div>
            <label htmlFor="coverage-amount" className="block text-sm mb-1">Importe confirmado</label>
            <input id="coverage-amount" inputMode="decimal" value={value.importe ?? ''} onChange={e => update('importe', e.target.value)} placeholder="600000.00" maxLength={19} className={inputClass} />
          </div>
          <div>
            <label htmlFor="coverage-currency" className="block text-sm mb-1">Moneda</label>
            <select id="coverage-currency" value={value.moneda ?? ''} onChange={e => update('moneda', e.target.value)} className={inputClass}>
              <option value="">Desconocida</option>
              {value.moneda && !currencies.includes(value.moneda) && <option value={value.moneda}>{value.moneda}</option>}
              {currencies.map(currency => <option key={currency} value={currency}>{currency}</option>)}
            </select>
          </div>
          <div>
            <label htmlFor="coverage-period" className="block text-sm mb-1">Periodicidad</label>
            <select id="coverage-period" value={value.periodicidad ?? ''} onChange={e => update('periodicidad', e.target.value)} className={inputClass}>
              <option value="">Desconocida</option><option value="UNICA">Pago único</option><option value="MENSUAL">Mensual</option><option value="SEMESTRAL">Semestral</option><option value="ANUAL">Anual</option><option value="DESCONOCIDA">No confirmada por la fuente</option>
            </select>
          </div>
        </>}
        {value.tipo === 'PORCENTUAL' && <div>
          <label htmlFor="coverage-percentage" className="block text-sm mb-1">Porcentaje confirmado (%)</label>
          <input id="coverage-percentage" inputMode="decimal" value={value.porcentaje ?? ''} onChange={e => update('porcentaje', e.target.value)} placeholder="75.50" maxLength={6} className={inputClass} />
        </div>}
      </div>
      <button type="button" onClick={() => onChange({ tipo: 'DESCONOCIDA' })} className="text-sm underline text-[#0b3c75] min-h-11 focus-visible:outline-2 focus-visible:outline-offset-2">Quitar datos confirmados</button>
    </fieldset>
  );
}
