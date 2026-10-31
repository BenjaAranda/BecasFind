import type { Cobertura } from '../../types';

export function coverageError(coverage: Cobertura): string | null {
  const amount = coverage.importe;
  if (coverage.tipo === 'MONETARIA') {
    if (amount && !/^\d{1,16}(\.\d{1,2})?$/.test(amount)) return 'El importe admite hasta 16 dígitos enteros y dos decimales. Usa punto decimal y no incluyas separadores de miles.';
    if (amount && !coverage.moneda) return 'Selecciona la moneda del importe indicado por la fuente.';
  }
  if (coverage.tipo === 'PORCENTUAL' && coverage.porcentaje
      && (!/^\d{1,3}(\.\d{1,2})?$/.test(coverage.porcentaje) || Number(coverage.porcentaje) > 100)) {
    return 'El porcentaje debe estar entre 0 y 100 y admite hasta dos decimales.';
  }
  return null;
}
