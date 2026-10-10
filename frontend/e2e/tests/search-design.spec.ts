import { test, expect, type Page } from '@playwright/test';
import { join } from 'node:path';
import { tmpdir } from 'node:os';

const summary = { idBeca: "00000000-0000-4000-8000-000000000001", nombre: 'Beca de educación superior', descripcionCorta: 'Apoyo para continuar tus estudios en Chile.', estadoActiva: true,
  montoCobertura: 'Hasta $1.000.000 de arancel anual', fechaCierrePostulacion: '2030-12-31', nombreInstitucion: 'Institución de prueba', nombreTipoBeca: 'Arancel', nombreRegion: 'Nacional' };
const detail = { ...summary, fechaInicioPostulacion: '2030-01-01', institucion: { nombre: summary.nombreInstitucion }, tipoBeca: { nombre: 'Arancel' }, regiones: [],
  requisitoPerfil: { rshMaximoPorcentaje: 60, nemMinimo: 5.5, paesMinimo: null, esParaPrimerAnio: true }, documentosRequeridos: [],
  descripcionLarga: 'DOCUMENTOS REQUERIDOS:\n[OPCIONAL] Carta de motivación\n[OPCIONAL] Certificado de matrícula', urlOficial: 'https://example.com/convocatoria' };

async function prepare(page: Page) {
  const token = `e30.${Buffer.from(JSON.stringify({ sub: 'student@example.com', role: 'STUDENT', nombre: 'Estudiante', exp: 4_000_000_000 })).toString('base64url')}.test`;
  await page.addInitScript(token => localStorage.setItem('token', token), token);
  await page.route('**/api/**', route => {
    const path = new URL(route.request().url()).pathname;
    const data = path.endsWith('/buscar') ? { content: [summary, { ...summary, idBeca: "00000000-0000-4000-8000-000000000002", nombre: 'Beca de continuidad académica' }], totalElements: 2, totalPages: 1, number: 0 }
      : path.endsWith('/becas/00000000-0000-4000-8000-000000000001') ? detail : [];
    return route.fulfill({ json: { data } });
  });
}

test('filtros móviles se despliegan y quitar un filtro conserva el resto', async ({ page }) => {
  await prepare(page);
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto('/explorar?q=educación&rsh=60');
  await expect(page.getByLabel('Buscar', { exact: true })).toBeHidden();
  await page.getByRole('button', { name: 'Mostrar filtros' }).click();
  await expect(page.getByLabel('Buscar', { exact: true })).toHaveValue('educación');
  await page.getByRole('button', { name: 'Quitar filtro Texto: educación' }).click();
  await expect(page.getByLabel('Buscar', { exact: true })).toHaveValue('');
  await expect(page.getByLabel('RSH (%)')).toHaveValue('60');
  await expect(page).toHaveURL(/rsh=60/);
  await page.getByRole('button', { name: 'Ocultar filtros' }).click();
  await expect(page.getByLabel('Buscar', { exact: true })).toBeHidden();
});

test('favorito es independiente de abrir la tarjeta y el título funciona con teclado', async ({ page }) => {
  await prepare(page);
  await page.goto('/explorar');
  const save = page.getByRole('button', { name: 'Guardar en favoritos' }).first();
  await save.click();
  await expect(page.getByRole('button', { name: 'Quitar de favoritos' })).toHaveAttribute('aria-pressed', 'true');
  await expect(page).toHaveURL(/\/explorar$/);
  const title = page.getByRole('button', { name: summary.nombre, exact: true });
  await title.focus();
  await page.keyboard.press('Enter');
  await expect(page).toHaveURL(/\/becas\/00000000-0000-4000-8000-000000000001$/);
});

test('detalle fallido permite reintentar y abrir un enlace directo vuelve al buscador', async ({ page }) => {
  await prepare(page);
  let calls = 0;
  await page.route('**/api/becas/00000000-0000-4000-8000-000000000001', route => ++calls === 1 ? route.fulfill({ status: 500, json: { message: 'Error' } }) : route.fulfill({ json: { data: detail } }));
  await page.goto('/becas/00000000-0000-4000-8000-000000000001');
  await expect(page.getByRole('alert')).toContainText('No pudimos abrir');
  await expect(page).toHaveURL(/\/becas\/00000000-0000-4000-8000-000000000001$/);
  await page.getByRole('button', { name: 'Reintentar' }).click();
  await expect(page.getByRole('heading', { name: summary.nombre, exact: true })).toBeVisible();
  await page.getByRole('button', { name: 'Volver', exact: true }).click();
  await expect(page).toHaveURL(/\/explorar$/);
});

test('favorito fallido revierte el estado y bloquea escrituras mientras espera', async ({ page }) => {
  await prepare(page);
  let release!: () => void;
  const pending = new Promise<void>(resolve => { release = resolve; });
  let writes = 0;
  await page.route('**/api/favoritos/00000000-0000-4000-8000-000000000001', async route => {
    writes++;
    await pending;
    await route.fulfill({ status: 500, json: { message: 'Error' } });
  });
  await page.goto('/explorar');
  await page.getByRole('button', { name: 'Guardar en favoritos' }).first().click();
  await expect(page.getByRole('button', { name: 'Quitar de favoritos' })).toBeDisabled();
  expect(writes).toBe(1);
  release();
  await expect(page.getByRole('alert')).toContainText('No pudimos actualizar tus favoritos');
  await expect(page.getByRole('button', { name: 'Guardar en favoritos' }).first()).toBeEnabled();
  await expect(page.getByRole('button', { name: 'Quitar de favoritos' })).toHaveCount(0);
});

test('detalle muestra documentos solo opcionales y Escape cierra el menú sin salir', async ({ page }) => {
  await prepare(page);
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto('/becas/00000000-0000-4000-8000-000000000001');
  await expect(page.getByRole('heading', { name: 'Documentos Requeridos' })).toBeVisible();
  await expect(page.getByRole('listitem')).toHaveCount(2);
  await expect(page.getByRole('listitem').first()).toContainText('Carta de motivación');
  await expect(page.getByRole('listitem').first()).not.toContainText('Certificado de matrícula');
  await page.getByRole('button', { name: 'Abrir menú' }).click();
  await page.keyboard.press('Escape');
  await expect(page).toHaveURL(/\/becas\/00000000-0000-4000-8000-000000000001$/);
  await expect(page.getByRole('button', { name: 'Abrir menú' })).toBeFocused();
  await expect(page.getByRole('link', { name: 'Ver convocatoria oficial' })).toHaveAttribute('href', detail.urlOficial);
});

for (const width of [390, 1280]) {
  test(`buscador y detalle a ${width}px mantienen lectura sin desbordar`, async ({ page }) => {
    await prepare(page);
    await page.setViewportSize({ width, height: 900 });
    for (const [path, name] of [['/explorar', 'search'], ['/becas/00000000-0000-4000-8000-000000000001', 'detail']]) {
      await page.goto(path);
      await expect(page.getByText(summary.nombre, { exact: true })).toBeVisible();
      expect(await page.evaluate(() => document.documentElement.scrollWidth <= window.innerWidth)).toBe(true);
      await page.screenshot({ path: join(tmpdir(), `becasfind-${name}-phase9-${width}.png`), fullPage: true });
    }
  });
}
