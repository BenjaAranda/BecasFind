import { test, expect, type Page } from '@playwright/test';

const scholarships = [
  { idBeca: "00000000-0000-4000-8000-000000000001", nombre: 'Beca de alimentación Ñuble', descripcionCorta: 'Apoyo para alimentación.', estadoActiva: true,
    montoCobertura: '$100.000', fechaCierrePostulacion: '2030-12-31', nombreInstitucion: 'Institución de prueba', nombreTipoBeca: 'Alimentación', nombreRegion: 'Ñuble' },
  { idBeca: "00000000-0000-4000-8000-000000000002", nombre: 'Beca de matrícula nacional', descripcionCorta: 'Apoyo para matrícula.', estadoActiva: true,
    montoCobertura: '$200.000', fechaCierrePostulacion: '2030-11-30', nombreInstitucion: 'Institución de prueba', nombreTipoBeca: 'Arancel', nombreRegion: 'Nacional' },
];

for (const width of [390, 1280]) {
  test(`orden monetario a ${width}px explica grupos y cambia con teclado`, async ({ page }) => {
    await page.setViewportSize({ width, height: 900 });
    const bodies = await prepare(page);
    if (width === 390) await page.getByRole('button', { name: 'Mostrar filtros' }).click();
    const select = page.getByLabel('Ordenar por', { exact: true });
    await select.focus();
    await select.press('End');
    await expect(select).toHaveValue('montoDesc');
    await expect(page.getByRole('note')).toContainText('por moneda y periodicidad');
    await expect(page.getByRole('note')).toContainText('sin importe confirmado aparecen al final');
    await expect(select).toHaveAttribute('aria-describedby', 'coverage-order-note');
    await expect.poll(() => bodies.at(-1)?.sort).toBe('montoDesc');
    await select.press('ArrowUp');
    await expect(select).toHaveValue('montoAsc');
    await expect.poll(() => bodies.at(-1)?.sort).toBe('montoAsc');
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    await select.selectOption('fechaAsc');
    await expect(page.getByRole('note')).toHaveCount(0);
  });
}

async function prepare(page: Page) {
  const token = `e30.${Buffer.from(JSON.stringify({ sub: 'student@example.com', role: 'STUDENT', nombre: 'Estudiante', exp: 4_000_000_000 })).toString('base64url')}.test`;
  await page.addInitScript(token => localStorage.setItem('token', token), token);
  const bodies: Record<string, unknown>[] = [];
  await page.route('**/api/**', route => {
    const path = new URL(route.request().url()).pathname;
    if (path.endsWith('/buscar')) {
      const body = route.request().postDataJSON();
      bodies.push(body);
      const content = body.query || body.regionId ? scholarships.slice(0, 1) : scholarships;
      return route.fulfill({ json: { status: 200, data: { content, totalElements: content.length, totalPages: 1, number: body.page, size: body.size } } });
    }
    const data = path.endsWith('/regiones') ? [{ idRegion: 16, nombre: 'Ñuble', abreviatura: 'NU' }]
      : path.endsWith('/tipos-beca') ? [{ idTipoBeca: 1, nombre: 'Alimentación' }]
      : path.endsWith('/instituciones') ? [{ idInstitucion: 1, nombre: 'Institución de prueba' }]
      : path.endsWith('/tipos-institucion') ? [{ idTipoInst: 1, nombre: 'Universidad' }] : [];
    return route.fulfill({ json: { status: 200, data } });
  });
  await page.goto('/explorar');
  await expect(page.getByRole('heading', { name: '2 becas encontradas', exact: true })).toBeVisible();
  await expect(page.getByRole('button', { name: scholarships[1].nombre, exact: true })).toBeVisible();
  bodies.length = 0;
  return bodies;
}

test('CP-18: buscar texto envía el valor actual y muestra únicamente la respuesta filtrada', async ({ page }) => {
  const bodies = await prepare(page);
  await page.getByLabel('Buscar', { exact: true }).fill('alimentación Ñuble');
  await page.getByRole('button', { name: 'Buscar Becas', exact: true }).click();
  await expect(page.getByRole('heading', { name: '1 beca encontrada', exact: true })).toBeVisible();
  await expect(page.getByRole('button', { name: scholarships[0].nombre, exact: true })).toBeVisible();
  await expect(page.getByRole('button', { name: scholarships[1].nombre, exact: true })).toHaveCount(0);
  expect(bodies.at(-1)).toEqual({ query: 'alimentación Ñuble', sort: 'fechaAsc', page: 0, size: 12 });
  expect(new URL(page.url()).searchParams.get('q')).toBe('alimentación Ñuble');
});

test('CP-63: escribir varias veces envía exactamente una petición después de 400 ms', async ({ page }) => {
  await page.clock.install({ time: new Date('2029-01-01T00:00:00Z') });
  const bodies = await prepare(page);
  await page.clock.pauseAt(new Date('2029-01-01T01:00:00Z'));
  for (const text of ['a', 'ali', 'alimentación', 'alimentación Ñuble']) {
    await page.getByLabel('Buscar', { exact: true }).fill(text);
  }
  await page.clock.runFor(399);
  expect(bodies).toEqual([]);
  await page.clock.runFor(1);
  await expect(page.getByRole('heading', { name: '1 beca encontrada', exact: true })).toBeVisible();
  expect(bodies).toEqual([{ query: 'alimentación Ñuble', sort: 'fechaAsc', page: 0, size: 12 }]);
  await page.clock.runFor(1000);
  expect(bodies).toHaveLength(1);
});

test('CP-66: filtros envían todos los valores y reiniciar restaura resultados y URL', async ({ page }) => {
  const bodies = await prepare(page);
  await page.getByLabel('RSH (%)').fill('60');
  await page.getByLabel('Tu promedio NEM').fill('5.5');
  await page.getByLabel('Región', { exact: true }).selectOption('16');
  await page.getByLabel('Tipo de Beca', { exact: true }).selectOption('1');
  await page.getByLabel('Institución', { exact: true }).selectOption('1');
  await page.getByLabel('Categoría', { exact: true }).selectOption('1');
  await page.getByLabel('Ordenar por').selectOption('fechaDesc');
  await page.getByRole('button', { name: 'Buscar Becas', exact: true }).click();
  await expect(page.getByRole('heading', { name: '1 beca encontrada', exact: true })).toBeVisible();
  expect(bodies.at(-1)).toEqual({ rsh: 60, nem: 5.5, regionId: 16, idTipoBeca: 1, idInstitucion: 1, idTipoInstitucion: 1, sort: 'fechaDesc', page: 0, size: 12 });
  await expect(page.getByRole('button', { name: scholarships[1].nombre, exact: true })).toHaveCount(0);
  await page.getByRole('button', { name: 'Reiniciar filtros', exact: true }).click();
  await expect(page.getByRole('heading', { name: '2 becas encontradas', exact: true })).toBeVisible();
  await expect(page.getByRole('button', { name: scholarships[1].nombre, exact: true })).toBeVisible();
  await expect(page.getByLabel('RSH (%)')).toHaveValue('');
  await expect(page.getByLabel('Región', { exact: true })).toHaveValue('');
  expect(bodies.at(-1)).toEqual({ sort: 'fechaAsc', page: 0, size: 12 });
  await expect(page).toHaveURL(/\/explorar$/);
});
