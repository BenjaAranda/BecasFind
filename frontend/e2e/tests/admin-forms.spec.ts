import { test, expect, type Page } from '@playwright/test';

const summary = { idBeca: 1, nombre: 'Beca de prueba', estadoActiva: true,
  fechaCierrePostulacion: '2026-12-31', nombreInstitucion: 'Institución de prueba', nombreTipoBeca: 'Arancel' };
const detail = { ...summary, tipoBeca: { idTipoBeca: 1 }, institucion: { idInstitucion: 1 },
  fechaInicioPostulacion: '2026-01-01', regiones: [{ idRegion: 1, nombre: 'Ñuble' }],
  requisitoPerfil: { rshMaximoPorcentaje: 0, nemMinimo: 5.25 },
  documentosRequeridos: [{ idDocumento: 99, nombreDocumento: 'Certificado', esObligatorio: true }] };

async function setup(page: Page) {
  const encoded = Buffer.from(JSON.stringify({ sub: 'admin@example.com', role: 'ADMIN', nombre: 'Admin', exp: 4_000_000_000 })).toString('base64url');
  await page.addInitScript(token => localStorage.setItem('token', token), `e30.${encoded}.test`);
  await page.route('**/api/**', async route => {
    const path = new URL(route.request().url()).pathname;
    let data: unknown = [];
    if (path.endsWith('/administracion')) data = { content: [summary], totalPages: 1, totalElements: 101, number: 0 };
    if (path.endsWith('/becas/1')) data = detail;
    if (path.endsWith('/regiones')) data = [{ idRegion: 1, nombre: 'Ñuble' }];
    if (path.endsWith('/tipos-beca')) data = [{ idTipoBeca: 1, nombre: 'Arancel' }];
    if (path.endsWith('/instituciones')) data = [{ idInstitucion: 1, nombre: 'Institución de prueba' }];
    if (path.endsWith('/usuarios')) data = [{ idUsuario: 2, nombreCompleto: 'Estudiante', email: 'student@example.com', rol: 'STUDENT', activo: true }];
    await route.fulfill({ json: { status: 200, data } });
  });
}

async function edit(page: Page) {
  await page.goto('/admin/becas');
  await page.getByRole('button', { name: 'Editar Beca de prueba' }).click();
  await expect(page.getByRole('button', { name: 'Actualizar', exact: true })).toBeEnabled();
}

test('editar permite vaciar regiones y documentos sin perder RSH cero', async ({ page }) => {
  await setup(page);
  let payload: Record<string, unknown> | undefined;
  await page.route('**/api/becas/1', async route => {
    if (route.request().method() !== 'PUT') { await route.fallback(); return; }
    payload = route.request().postDataJSON();
    await route.fulfill({ json: { status: 200, data: summary } });
  });
  await edit(page);
  await expect(page.getByLabel('RSH Máximo')).toHaveValue('0');
  await page.getByRole('button', { name: 'Ñuble', exact: true }).click();
  await page.getByRole('button', { name: 'Eliminar documento 1' }).click();
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  expect(payload).toMatchObject({ regionesIds: [], documentosRequeridos: [], rshMaximoPorcentaje: 0, nemMinimo: 5.25 });
  await expect(page.getByText('101 becas en total')).toBeVisible();
});

test('guardado fallido conserva datos y permite un único reintento', async ({ page }) => {
  await setup(page);
  let attempts = 0;
  await page.route('**/api/becas/1', async route => {
    if (route.request().method() !== 'PUT') { await route.fallback(); return; }
    attempts++;
    await new Promise(resolve => setTimeout(resolve, 250));
    await route.fulfill({ status: attempts === 1 ? 500 : 200, json: { message: 'No se pudo guardar', data: summary } });
  });
  await edit(page);
  await page.getByLabel('Nombre *', { exact: true }).fill('Nueva descripción');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('button', { name: 'Guardando...' })).toBeDisabled();
  await expect(page.getByLabel('Nombre *', { exact: true })).toBeDisabled();
  await expect(page.getByRole('alert')).toHaveText('No se pudo guardar');
  await expect(page.getByLabel('Nombre *', { exact: true })).toHaveValue('Nueva descripción');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  expect(attempts).toBe(2);
});

test('valida fechas y rangos antes de enviar', async ({ page }) => {
  await setup(page);
  let writes = 0;
  page.on('request', request => { if (request.method() === 'PUT') writes++; });
  await edit(page);
  await page.getByLabel('Inicio Postulación').fill('2027-01-01');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('posterior al inicio');
  await page.getByLabel('Inicio Postulación').fill('2026-01-01');
  await page.getByLabel('RSH Máximo').fill('101');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  expect(await page.getByLabel('RSH Máximo').evaluate((input: HTMLInputElement) => input.validity.rangeOverflow)).toBe(true);
  expect(writes).toBe(0);
});

test('catálogos fallidos bloquean el envío y se recuperan sin borrar campos', async ({ page }) => {
  await setup(page);
  let fail = true;
  await page.route('**/api/regiones', route => fail ? route.fulfill({ status: 500, json: {} }) : route.fallback());
  await page.goto('/admin/becas');
  await page.getByRole('button', { name: 'Nueva Beca', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('catálogos');
  await page.getByLabel('Nombre *', { exact: true }).fill('Beca nueva');
  await expect(page.getByRole('button', { name: 'Crear Beca', exact: true })).toBeDisabled();
  fail = false;
  await page.getByRole('button', { name: 'Reintentar catálogos' }).click();
  await expect(page.getByRole('button', { name: 'Crear Beca', exact: true })).toBeEnabled();
  await expect(page.getByLabel('Nombre *', { exact: true })).toHaveValue('Beca nueva');
});

test('crear beca envía documentos y valida URL en pantalla móvil', async ({ page }) => {
  await setup(page);
  await page.setViewportSize({ width: 390, height: 844 });
  let payload: Record<string, unknown> | undefined;
  await page.route('**/api/becas', async route => {
    payload = route.request().postDataJSON();
    await route.fulfill({ status: 201, json: { data: summary } });
  });
  await page.goto('/admin/becas');
  await page.getByRole('button', { name: 'Nueva Beca', exact: true }).click();
  await expect(page.getByRole('button', { name: 'Crear Beca', exact: true })).toBeEnabled();
  await page.getByLabel('Nombre *', { exact: true }).fill('  Beca Ñuble  ');
  await page.getByLabel('Tipo Beca').selectOption('1');
  await page.getByLabel('Institución').selectOption('1');
  await page.getByLabel('Cierre Postulación').fill('2026-12-31');
  await page.getByLabel('URL Oficial').fill('ftp://example.com/beca');
  await page.getByRole('button', { name: 'Crear Beca', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('https://');
  expect(payload).toBeUndefined();
  await page.getByLabel('URL Oficial').fill('https://example.com/beca');
  await page.getByRole('button', { name: 'Agregar', exact: true }).click();
  await page.getByLabel('Nombre del documento 1').fill('  Matrícula  ');
  const dialog = page.getByRole('dialog');
  expect(await dialog.evaluate(el => el.scrollWidth <= el.clientWidth)).toBe(true);
  await page.screenshot({ path: `${process.env.TEMP}/becasfind-admin-form-mobile.png` });
  await page.getByRole('button', { name: 'Crear Beca', exact: true }).click();
  await expect(dialog).toHaveCount(0);
  expect(payload).toMatchObject({ nombre: 'Beca Ñuble', regionesIds: [],
    documentosRequeridos: [{ nombreDocumento: 'Matrícula', esObligatorio: true }] });
});

test('eliminar muestra errores y conserva la confirmación para reintentar', async ({ page }) => {
  await setup(page);
  let attempts = 0;
  await page.route('**/api/becas/1', async route => {
    attempts++;
    await route.fulfill({ status: attempts === 1 ? 500 : 200, json: { data: null } });
  });
  await page.goto('/admin/becas');
  await page.getByRole('button', { name: 'Eliminar Beca de prueba' }).click();
  await page.getByRole('dialog').getByRole('button', { name: 'Eliminar', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('No se pudo eliminar');
  await page.getByRole('dialog').getByRole('button', { name: 'Eliminar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  expect(attempts).toBe(2);
});

test('crear usuario valida bytes de contraseña y conserva datos ante error', async ({ page }) => {
  await setup(page);
  let writes = 0;
  await page.route('**/api/usuarios', async route => {
    if (route.request().method() !== 'POST') { await route.fallback(); return; }
    writes++;
    await route.fulfill({ status: writes === 1 ? 409 : 201, json: { message: 'El email ya está registrado', data: {} } });
  });
  await page.goto('/admin/usuarios');
  await page.getByRole('button', { name: 'Nuevo Usuario', exact: true }).click();
  await page.getByLabel('Nombre Completo').fill('Usuario nuevo');
  await page.getByLabel('Email').fill('new@example.com');
  await page.getByLabel('Contraseña').fill('ñ'.repeat(40));
  await page.getByRole('button', { name: 'Crear Usuario' }).click();
  await expect(page.getByRole('alert')).toContainText('72 bytes');
  expect(writes).toBe(0);
  await page.getByLabel('Contraseña').fill('secure-pass-123');
  await page.getByRole('button', { name: 'Crear Usuario' }).click();
  await expect(page.getByRole('alert')).toContainText('ya está registrado');
  await expect(page.getByLabel('Email')).toHaveValue('new@example.com');
  await page.getByRole('button', { name: 'Crear Usuario' }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  expect(writes).toBe(2);
});

test('desactivar usuario permite reintentar y el listado recupera fallos', async ({ page }) => {
  await setup(page);
  let failList = true;
  await page.route('**/api/usuarios', route => failList ? route.fulfill({ status: 500, json: {} }) : route.fallback());
  let attempts = 0;
  await page.route('**/api/usuarios/2', async route => {
    attempts++;
    await route.fulfill({ status: attempts === 1 ? 500 : 200, json: { data: null } });
  });
  await page.goto('/admin/usuarios');
  await expect(page.getByRole('alert')).toContainText('cargar los usuarios');
  failList = false;
  await page.getByRole('button', { name: 'Reintentar', exact: true }).click();
  await page.getByRole('button', { name: 'Desactivar Estudiante' }).click();
  await page.getByRole('dialog').getByRole('button', { name: 'Desactivar', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('No se pudo desactivar');
  await page.getByRole('dialog').getByRole('button', { name: 'Desactivar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
});

test('búsqueda administrativa no duplica carga inicial ni muestra respuestas antiguas', async ({ page }) => {
  await setup(page);
  const queries: string[] = [];
  await page.route('**/api/becas/administracion?*', async route => {
    const query = new URL(route.request().url()).searchParams.get('query') || '';
    queries.push(query);
    if (query === 'vieja') await new Promise(resolve => setTimeout(resolve, 1100));
    await route.fulfill({ json: { data: { content: [{ ...summary, nombre: query || summary.nombre }], totalPages: 1, totalElements: 1 } } });
  });
  await page.goto('/admin/becas');
  await expect(page.getByText('Beca de prueba', { exact: true })).toBeVisible();
  await page.waitForTimeout(500);
  expect(queries).toEqual(['']);
  await page.getByRole('textbox', { name: 'Buscar beca', exact: true }).fill('vieja');
  await expect.poll(() => queries.includes('vieja')).toBe(true);
  await page.getByRole('textbox', { name: 'Buscar beca', exact: true }).fill('nueva');
  await expect(page.getByText('nueva', { exact: true })).toBeVisible();
  await page.waitForTimeout(1200);
  await expect(page.getByText('vieja', { exact: true })).toHaveCount(0);
});
