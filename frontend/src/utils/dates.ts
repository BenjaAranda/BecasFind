// Fechas de calendario: no convertir YYYY-MM-DD a medianoche del navegador.
export function formatCalendarDate(value: string | null, short = false): string {
  if (!value) return 'Fecha por confirmar';
  if (!/^\d{4}-\d{2}-\d{2}$/.test(value)) return 'Fecha no disponible';
  const date = new Date(`${value}T12:00:00Z`);
  if (Number.isNaN(date.getTime())) return 'Fecha no disponible';
  return date.toLocaleDateString('es-CL', {
    timeZone: 'UTC', day: 'numeric', month: short ? 'numeric' : 'long', year: 'numeric',
  });
}

export function todayInChile(now = new Date()): string {
  return new Intl.DateTimeFormat('en-CA', {
    timeZone: 'America/Santiago', year: 'numeric', month: '2-digit', day: '2-digit',
  }).format(now);
}

export function isClosingDateExpired(value: string | null): boolean {
  return value !== null && value < todayInChile();
}
