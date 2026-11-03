import { test, expect } from '@playwright/test';

const id = '00000000-0000-4000-8000-000000000001';
for (const width of [360, 1280]) test(`catálogo público sin fechas a ${width}px`, async ({ page }) => {
  await page.setViewportSize({ width, height: 900 });
  const calls: string[] = [];
  const scholarship = { idBeca: id, nombre: 'Beca con fechas pendientes', estadoActiva: false,
    estadoPostulacion: 'FECHAS_POR_CONFIRMAR', fechaCierrePostulacion: null,
    nombreInstitucion: 'Universidad de prueba', nombreTipoBeca: 'Arancel', nombreRegion: 'Nacional',
    descripcionCorta: 'Apoyo para continuar estudios.', descripcionLarga: '',
    institucion: { nombre: 'Universidad de prueba' }, regiones: [], documentosRequeridos: [],
    urlOficial: 'https://example.org/becas/programa' };
  await page.route('**/api/**', route => {
    const path = new URL(route.request().url()).pathname;
    calls.push(path);
    const data = path.endsWith('/buscar') ? { content: path.includes('/catalogo/') ? [scholarship] : [], totalElements: path.includes('/catalogo/') ? 1 : 0, totalPages: 1 }
      : path.endsWith(id) ? scholarship : [];
    return route.fulfill({ json: { data } });
  });
  await page.goto('/explorar');
  await expect(page.getByRole('button', { name: 'Catálogo completo', exact: true })).toHaveAttribute('aria-pressed', 'true');
  await expect(page.getByText('Fechas por confirmar', { exact: true })).toBeVisible();
  await page.getByRole('button', { name: scholarship.nombre, exact: true }).click();
  await expect(page.getByRole('heading', { name: scholarship.nombre, exact: true })).toBeVisible();
  await expect(page.getByText('Fechas por confirmar', { exact: true })).toBeVisible();
  await expect(page.getByRole('button', { name: 'Guardar en favoritos' })).toHaveCount(0);
  await page.goBack();
  await page.getByRole('button', { name: 'Postulaciones abiertas', exact: true }).click();
  await expect(page).toHaveURL(/vista=abiertas/);
  await expect(page.getByRole('button', { name: scholarship.nombre, exact: true })).toHaveCount(0);
  expect(calls).toContain('/api/becas/catalogo/buscar');
  expect(calls).toContain('/api/becas/buscar');
  expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
});
