import { test, expect, type Page } from '@playwright/test';
import { join } from 'node:path';
import { tmpdir } from 'node:os';

const profile = { rshPorcentaje: 0, nemPromedio: 5.5, region: { idRegion: 1 }, institucion: { idInstitucion: 1 }, carreraInteres: 'Educación', esPrimerAnio: true, esCursoSuperior: false };
const beca = { idBeca: "00000000-0000-4000-8000-000000000001", nombre: 'Beca de educación', estadoActiva: true, descripcionCorta: 'Apoyo para estudiar', montoCobertura: '$100.000', fechaCierrePostulacion: '2030-12-31', nombreInstitucion: 'Institución de prueba', nombreTipoBeca: 'Arancel', nombreRegion: 'Nacional' };
async function prepare(page: Page) {
  const token = `e30.${Buffer.from(JSON.stringify({ sub: 'student@example.com', role: 'STUDENT', nombre: 'Estudiante', exp: 4_000_000_000 })).toString('base64url')}.test`;
  await page.addInitScript(token => localStorage.setItem('token', token), token);
  await page.route('**/api/**', route => {
    const path = new URL(route.request().url()).pathname;
    const data = path.endsWith('/perfil') ? profile : path.endsWith('/regiones') ? [{ idRegion: 1, nombre: 'Ñuble' }]
      : path.endsWith('/instituciones') ? [{ idInstitucion: 1, nombre: 'Institución de prueba' }] : path.endsWith('/favoritos') ? [beca]
        : path.endsWith('/recomendadas') ? { content: [], totalPages: 0, totalElements: 0 } : [];
    return route.fulfill({ json: { data } });
  });
}

test('perfil conserva RSH cero y vacía asociaciones explícitamente al guardar', async ({ page }) => {
  await prepare(page);
  let saved: Record<string, unknown> | undefined;
  await page.route('**/api/perfil', route => {
    if (route.request().method() === 'PUT') saved = route.request().postDataJSON();
    return route.fulfill({ json: { data: profile } });
  });
  await page.goto('/perfil');
  await expect(page.getByLabel('RSH (%)')).toHaveValue('0');
  await expect(page.getByLabel('NEM Promedio')).toHaveValue('5.5');
  await page.getByLabel('Región', { exact: true }).selectOption('');
  await page.getByLabel('Institución', { exact: true }).selectOption('');
  await page.getByLabel('Carrera de Interés').fill('   ');
  await page.getByRole('button', { name: 'Guardar Perfil' }).click();
  await expect(page.getByRole('status')).toContainText('Perfil guardado');
  expect(saved).toMatchObject({ rshPorcentaje: 0, nemPromedio: 5.5, idRegion: null, idInstitucion: null, carreraInteres: null });
});

test('error de perfil bloquea edición y el reintento recupera datos existentes', async ({ page }) => {
  await prepare(page);
  let failed = true;
  await page.route('**/api/perfil', route => failed ? route.fulfill({ status: 500, json: {} }) : route.fulfill({ json: { data: profile } }));
  await page.goto('/perfil');
  await expect(page.getByRole('alert')).toContainText('No pudimos cargar');
  await expect(page.getByRole('button', { name: 'Guardar Perfil' })).toHaveCount(0);
  failed = false;
  await page.getByRole('button', { name: 'Reintentar' }).click();
  await expect(page.getByLabel('Carrera de Interés')).toHaveValue('Educación');
});

test('fallo de catálogo también bloquea guardado y puede recuperarse', async ({ page }) => {
  await prepare(page);
  let failed = true;
  await page.route('**/api/regiones', route => failed ? route.fulfill({ status: 500, json: {} }) : route.fulfill({ json: { data: [{ idRegion: 1, nombre: 'Ñuble' }] } }));
  await page.goto('/perfil');
  await expect(page.getByRole('alert')).toBeVisible();
  failed = false;
  await page.getByRole('button', { name: 'Reintentar' }).click();
  await expect(page.getByLabel('Región', { exact: true })).toHaveValue('1');
});

test('perfil nuevo se carga vacío y el fallo de guardado conserva cambios', async ({ page }) => {
  await prepare(page);
  let writes = 0;
  await page.route('**/api/perfil', route => route.request().method() === 'PUT'
    ? (++writes === 1 ? route.fulfill({ status: 500, json: {} }) : route.fulfill({ json: { data: profile } }))
    : route.fulfill({ json: { data: null } }));
  await page.goto('/perfil');
  await expect(page.getByLabel('RSH (%)')).toHaveValue('');
  await page.getByLabel('Carrera de Interés').fill('Informática');
  await page.getByRole('button', { name: 'Guardar Perfil' }).click();
  await expect(page.getByRole('alert')).toBeVisible();
  await expect(page.getByLabel('Carrera de Interés')).toHaveValue('Informática');
  await page.getByRole('button', { name: 'Guardar Perfil' }).click();
  await expect(page.getByRole('status')).toContainText('Perfil guardado');
  await page.getByRole('link', { name: 'Ver recomendaciones con mi perfil guardado' }).click();
  await expect(page).toHaveURL(/mode=recomendar/);
});

test('perfil bloquea controles y envío mientras guarda', async ({ page }) => {
  await prepare(page);
  let release!: () => void;
  const pending = new Promise<void>(resolve => { release = resolve; });
  let writes = 0;
  await page.route('**/api/perfil', async route => {
    if (route.request().method() === 'PUT') { writes++; await pending; }
    await route.fulfill({ json: { data: profile } });
  });
  await page.goto('/perfil');
  await page.getByRole('button', { name: 'Guardar Perfil' }).click();
  await expect(page.getByLabel('RSH (%)')).toBeDisabled();
  await expect(page.getByRole('button', { name: 'Guardando...' })).toBeDisabled();
  expect(writes).toBe(1);
  release();
  await expect(page.getByRole('status')).toContainText('Perfil guardado');
});

test('favoritos conserva becas inactivas e informa su estado', async ({ page }) => {
  await prepare(page);
  await page.route('**/api/favoritos', route => route.fulfill({ json: { data: [{ ...beca, estadoActiva: false }] } }));
  await page.goto('/favoritos');
  await expect(page.getByText('Beca inactiva', { exact: true })).toBeVisible();
  await expect(page.getByRole('button', { name: 'Quitar de favoritos' })).toBeEnabled();
});

test('fallo al cargar favoritos no se presenta como lista vacía', async ({ page }) => {
  await prepare(page);
  let calls = 0;
  await page.route('**/api/favoritos', route => ++calls === 1 ? route.fulfill({ status: 500, json: {} }) : route.fulfill({ json: { data: [beca] } }));
  await page.goto('/favoritos');
  await expect(page.getByRole('alert')).toContainText('No pudimos cargar');
  await expect(page.getByText('No tienes becas guardadas')).toHaveCount(0);
  await page.getByRole('button', { name: 'Reintentar' }).click();
  await expect(page.getByRole('button', { name: beca.nombre, exact: true })).toBeVisible();
});

test('quitar favorito fallido conserva tarjeta y reintento exitoso muestra estado vacío', async ({ page }) => {
  await prepare(page);
  let calls = 0;
  await page.route('**/api/favoritos/00000000-0000-4000-8000-000000000001', route => ++calls === 1 ? route.fulfill({ status: 500, json: {} }) : route.fulfill({ json: { data: null } }));
  await page.goto('/favoritos');
  await page.getByRole('button', { name: 'Quitar de favoritos' }).click();
  await expect(page.getByRole('alert')).toContainText('Sigue guardada');
  await expect(page.getByRole('button', { name: beca.nombre, exact: true })).toBeVisible();
  await page.getByRole('button', { name: 'Quitar de favoritos' }).click();
  await expect(page.getByRole('heading', { name: 'No tienes becas guardadas' })).toBeVisible();
  await expect(page.getByRole('status')).toContainText('Beca quitada');
  await expect(page.getByRole('link', { name: 'Explorar becas disponibles' })).toHaveAttribute('href', '/explorar');
});

for (const width of [390, 1280]) {
  test(`perfil y favoritos a ${width}px sin desbordamiento`, async ({ page }) => {
    await prepare(page);
    await page.setViewportSize({ width, height: 900 });
    for (const path of ['perfil', 'favoritos']) {
      await page.goto(`/${path}`);
      await expect(page.getByRole('heading', { level: 1 })).toBeVisible();
      await expect(page.getByRole('status')).toHaveCount(0);
      expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
      await page.screenshot({ path: join(tmpdir(), `becasfind-${path}-phase12-${width}.png`), fullPage: true });
    }
  });
}
