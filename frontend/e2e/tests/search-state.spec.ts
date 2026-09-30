import { test, expect, type Page } from '@playwright/test';

const scholarship = (name = 'Beca de prueba', close = '2030-01-01') => ({ idBeca: "00000000-0000-4000-8000-000000000001", nombre: name,
  estadoActiva: true, descripcionCorta: 'Una oportunidad para estudiar', montoCobertura: '$100.000',
  fechaCierrePostulacion: close, nombreInstitucion: 'Institución de prueba', nombreTipoBeca: 'Arancel', nombreRegion: 'Nacional', urlOficial: 'https://example.com/becas' });
const response = (name?: string, close?: string, page = 0, size = 12) => ({ status: 200, data: {
  content: [scholarship(name, close)], totalElements: 240, totalPages: Math.ceil(240 / size), number: page, size,
} });

async function prepare(page: Page) {
  const payload = Buffer.from(JSON.stringify({ sub: 'student@example.com', role: 'STUDENT', nombre: 'Estudiante de prueba', exp: 4_000_000_000 })).toString('base64url');
  await page.addInitScript(token => localStorage.setItem('token', token), `e30.${payload}.test`);
  await page.route('**/api/favoritos', route => route.fulfill({ json: { data: [] } }));
  for (const path of ['regiones', 'tipos-beca', 'instituciones', 'tipos-institucion']) {
    await page.route(`**/api/${path}`, route => route.fulfill({ json: { data: [] } }));
  }
}

test.beforeEach(async ({ page }) => { await prepare(page); });

test('escritura rápida dispara una búsqueda tras 400 ms con el texto final', async ({ page }) => {
  const queries: string[] = [];
  await page.route('**/api/becas/buscar', route => {
    queries.push(route.request().postDataJSON().query || '');
    return route.fulfill({ json: response() });
  });
  await page.goto('/explorar');
  await expect(page.getByRole('button', { name: 'Beca de prueba', exact: true })).toBeVisible();
  queries.length = 0;
  await page.getByLabel('Buscar', { exact: true }).pressSequentially('beca final', { delay: 20 });
  expect(queries).toEqual([]);
  await expect.poll(() => queries).toEqual(['beca final']);
  await page.waitForTimeout(500);
  expect(queries).toEqual(['beca final']);
});

test('buscar inmediatamente usa el texto actual y cancela la búsqueda pendiente', async ({ page }) => {
  const queries: string[] = [];
  await page.route('**/api/becas/buscar', route => {
    queries.push(route.request().postDataJSON().query || '');
    return route.fulfill({ json: response() });
  });
  await page.goto('/explorar');
  await expect(page.getByRole('button', { name: 'Beca de prueba', exact: true })).toBeVisible();
  queries.length = 0;
  await page.getByLabel('Buscar', { exact: true }).fill('texto nuevo');
  await page.getByRole('button', { name: 'Buscar Becas' }).click();
  await expect.poll(() => queries).toEqual(['texto nuevo']);
  await page.waitForTimeout(500);
  expect(queries).toEqual(['texto nuevo']);
});

test('reiniciar limpia URL, controles y petición sin reutilizar filtros', async ({ page }) => {
  const bodies: Record<string, unknown>[] = [];
  await page.route('**/api/becas/buscar', route => {
    bodies.push(route.request().postDataJSON());
    return route.fulfill({ json: response() });
  });
  await page.goto('/explorar?q=texto&rsh=60&nem=5.5&page=2');
  await expect(page.getByRole('button', { name: 'Beca de prueba', exact: true })).toBeVisible();
  await page.getByRole('button', { name: 'Reiniciar filtros' }).click();
  await expect(page.getByLabel('Buscar', { exact: true })).toHaveValue('');
  await expect(page.getByLabel('RSH (%)')).toHaveValue('');
  await expect(page).toHaveURL(/\/explorar$/);
  await expect.poll(() => bodies.at(-1)).toEqual({ sort: 'fechaAsc', page: 0, size: 12 });
});

test('recomendaciones mantienen su endpoint al cambiar tamaño y página', async ({ page }) => {
  let searches = 0;
  const recommended: string[] = [];
  await page.route('**/api/becas/buscar', route => { searches++; return route.fulfill({ json: response() }); });
  await page.route('**/api/becas/recomendadas?*', route => {
    const url = new URL(route.request().url());
    recommended.push(`${url.searchParams.get('page')}/${url.searchParams.get('size')}`);
    return route.fulfill({ json: response('Recomendada', undefined, Number(url.searchParams.get('page')), Number(url.searchParams.get('size'))) });
  });
  await page.goto('/explorar?mode=recomendar');
  await expect(page.getByRole('button', { name: 'Recomendada', exact: true })).toBeVisible();
  await page.getByLabel('Resultados por página').selectOption('50');
  await expect.poll(() => recommended).toContain('0/50');
  await page.getByLabel('Página siguiente').click();
  await expect.poll(() => recommended).toContain('1/50');
  expect(searches).toBe(0);
  await expect(page).toHaveURL(/mode=recomendar/);
});

test('volver del detalle restaura texto y página desde la URL', async ({ page }) => {
  const pages: number[] = [];
  await page.route('**/api/becas/buscar', route => {
    const body = route.request().postDataJSON();
    pages.push(body.page);
    return route.fulfill({ json: response('Beca de prueba', undefined, body.page, body.size) });
  });
  await page.route('**/api/becas/00000000-0000-4000-8000-000000000001', route => route.fulfill({ json: { data: {
    ...scholarship(), fechaInicioPostulacion: '2029-01-01', descripcionLarga: '', regiones: [], documentosRequeridos: [],
  } } }));
  await page.goto('/explorar?q=guardado&page=2');
  await page.getByRole('button', { name: 'Beca de prueba', exact: true }).click();
  await expect(page).toHaveURL(/\/becas\/00000000-0000-4000-8000-000000000001$/);
  await page.getByRole('button', { name: 'Volver', exact: true }).click();
  await expect(page.getByLabel('Buscar', { exact: true })).toHaveValue('guardado');
  await expect.poll(() => pages.at(-1)).toBe(2);
  await expect(page).toHaveURL(/page=2/);
});

test('una respuesta anterior lenta no reemplaza la búsqueda nueva', async ({ page }) => {
  let started = false;
  await page.route('**/api/becas/buscar', async route => {
    const query = route.request().postDataJSON().query;
    if (query === 'vieja') { started = true; await new Promise(resolve => setTimeout(resolve, 900)); }
    try { await route.fulfill({ json: response(query === 'nueva' ? 'Resultado nuevo' : 'Resultado anterior') }); } catch { /* Petición cancelada. */ }
  });
  await page.goto('/explorar?q=vieja');
  await expect.poll(() => started).toBe(true);
  await page.getByLabel('Buscar', { exact: true }).fill('nueva');
  await page.getByRole('button', { name: 'Buscar Becas' }).click();
  await expect(page.getByRole('button', { name: 'Resultado nuevo', exact: true })).toBeVisible();
  await page.waitForTimeout(1000);
  await expect(page.getByRole('button', { name: 'Resultado anterior', exact: true })).toHaveCount(0);
});

test('fallo de red muestra error y permite recuperar resultados', async ({ page }) => {
  let failed = true;
  await page.route('**/api/becas/buscar', route => failed ? route.fulfill({ status: 500, json: { status: 500 } }) : route.fulfill({ json: response() }));
  await page.goto('/explorar');
  await expect(page.getByRole('alert')).toContainText('No pudimos cargar');
  failed = false;
  await page.getByRole('button', { name: 'Reintentar', exact: true }).click();
  await expect(page.getByRole('button', { name: 'Beca de prueba', exact: true })).toBeVisible();
  await expect(page.getByRole('alert')).toHaveCount(0);
});

test('fecha de cierre no cambia de día y permanece vigente hoy en Chile', async ({ page }) => {
  await page.clock.setFixedTime(new Date('2030-01-02T01:00:00Z'));
  await page.route('**/api/becas/buscar', route => route.fulfill({ json: response('Cierra hoy', '2030-01-01') }));
  await page.goto('/explorar');
  await expect(page.getByText('Cierre: 1 de enero de 2030', { exact: true })).toBeVisible();
  await expect(page.getByText('Postulación cerrada', { exact: true })).toHaveCount(0);
  await page.clock.setFixedTime(new Date('2030-01-02T12:00:00Z'));
  await page.getByRole('button', { name: 'Buscar Becas' }).click();
  await expect(page.getByText('Postulación cerrada', { exact: true })).toBeVisible();
});

test('móvil permite usar filtros y no desborda la navegación', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.route('**/api/becas/buscar', route => route.fulfill({ json: response() }));
  await page.goto('/explorar');
  await expect(page.getByRole('button', { name: 'Beca de prueba', exact: true })).toBeVisible();
  expect(await page.evaluate(() => document.documentElement.scrollWidth <= window.innerWidth)).toBe(true);
});

test('selector de tamaño permanece disponible aunque quede una sola página', async ({ page }) => {
  await page.route('**/api/becas/buscar', route => {
    const size = route.request().postDataJSON().size;
    const result = response();
    result.data.totalElements = 24;
    result.data.totalPages = Math.ceil(24 / size);
    return route.fulfill({ json: result });
  });
  await page.goto('/explorar');
  await expect(page.getByLabel('Resultados por página')).toBeVisible();
  await page.getByLabel('Resultados por página').selectOption('100');
  await expect(page.getByLabel('Página siguiente')).toBeDisabled();
  await expect(page.getByLabel('Resultados por página')).toHaveValue('100');
  await page.getByLabel('Resultados por página').selectOption('12');
  await expect(page.getByLabel('Página siguiente')).toBeEnabled();
});
