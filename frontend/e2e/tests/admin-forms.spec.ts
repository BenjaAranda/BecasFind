import { test, expect, type Page } from '@playwright/test';

test('edición de usuario conserva cambios tras error y envía solo nombre y correo', async ({ page }) => {
  await setup(page);
  let attempts = 0;
  let payload: Record<string, unknown> | undefined;
  await page.route('**/api/usuarios/2', async route => {
    payload = route.request().postDataJSON();
    attempts++;
    await new Promise(resolve => setTimeout(resolve, 150));
    await route.fulfill({ status: attempts === 1 ? 400 : 200, json: { message: 'Correo ya registrado', data: {} } });
  });
  await page.goto('/admin/usuarios');
  await page.getByRole('button', { name: 'Editar Estudiante', exact: true }).click();
  await expect(page.getByLabel('Nombre Completo *')).toHaveValue('Estudiante');
  await expect(page.getByLabel('Contraseña *')).toHaveCount(0);
  await expect(page.getByLabel('Rol *')).toHaveCount(0);
  await page.getByLabel('Nombre Completo *').fill('Educación actualizada');
  await page.getByLabel('Email *').fill('nuevo@example.com');
  await page.getByRole('button', { name: 'Guardar cambios' }).click();
  await expect(page.getByLabel('Email *')).toBeDisabled();
  await expect(page.getByRole('alert')).toHaveText('Correo ya registrado');
  await expect(page.getByLabel('Nombre Completo *')).toHaveValue('Educación actualizada');
  await expect(page.getByLabel('Email *')).toHaveValue('nuevo@example.com');
  await page.getByRole('button', { name: 'Guardar cambios' }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  expect(attempts).toBe(2);
  expect(payload).toEqual({ email: 'nuevo@example.com', nombreCompleto: 'Educación actualizada' });
});

test('diálogo mantiene foco y Escape devuelve el foco al botón de origen', async ({ page }) => {
  await setup(page);
  await page.goto('/admin/usuarios');
  const trigger = page.getByRole('button', { name: 'Nuevo Usuario', exact: true });
  await trigger.click();
  const dialog = page.getByRole('dialog', { name: 'Nuevo usuario' });
  await expect(dialog).toBeVisible();
  for (let i = 0; i < 12; i++) {
    await page.keyboard.press(i % 2 ? 'Shift+Tab' : 'Tab');
    expect(await dialog.evaluate(element => element.contains(document.activeElement))).toBe(true);
  }
  await page.keyboard.press('Escape');
  await expect(dialog).toHaveCount(0);
  await expect(trigger).toBeFocused();
});

test('Escape no interrumpe una creación pendiente y permite cerrar tras un error', async ({ page }) => {
  await setup(page);
  let release: (() => void) | undefined;
  const pending = new Promise<void>(resolve => { release = resolve; });
  await page.route('**/api/usuarios', async route => {
    if (route.request().method() !== 'POST') { await route.fallback(); return; }
    await pending;
    await route.fulfill({ status: 500, json: { message: 'No se pudo crear' } });
  });
  await page.goto('/admin/usuarios');
  await page.getByRole('button', { name: 'Nuevo Usuario', exact: true }).click();
  await page.getByLabel('Nombre Completo *').fill('Nombre de prueba');
  await page.getByLabel('Email *').fill('test@example.com');
  await page.getByLabel('Contraseña *').fill('password123');
  await page.getByRole('button', { name: 'Crear Usuario', exact: true }).click();
  await expect(page.getByRole('button', { name: 'Creando...' })).toBeDisabled();
  await page.keyboard.press('Escape');
  await expect(page.getByRole('dialog')).toBeVisible();
  release?.();
  await expect(page.getByRole('alert')).toHaveText('No se pudo crear');
  await page.keyboard.press('Escape');
  await expect(page.getByRole('dialog')).toHaveCount(0);
});

for (const width of [390, 1280]) {
  test(`administración y formulario no desbordan a ${width}px`, async ({ page }) => {
    await setup(page);
    await page.setViewportSize({ width, height: 850 });
    await page.goto('/admin/usuarios');
    await expect(page.getByText('Estudiante', { exact: true })).toBeVisible();
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    await page.getByRole('button', { name: 'Nuevo Usuario', exact: true }).click();
    const dialog = page.getByRole('dialog');
    await expect(dialog).toBeVisible();
    expect(await dialog.evaluate(element => element.scrollWidth <= element.clientWidth)).toBe(true);
    await page.screenshot({ path: `test-results/admin-dialog-${width}.png` });
    await page.keyboard.press('Escape');
    await page.goto('/admin/becas');
    await page.getByRole('button', { name: 'Importar CSV' }).click();
    await expect(page.getByRole('dialog', { name: 'Importar becas desde CSV' })).toBeVisible();
    await expect(page.getByLabel('Archivo CSV de becas')).toBeVisible();
    await page.keyboard.press('Escape');
    await expect(page.getByRole('dialog')).toHaveCount(0);
  });
}

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
    if (path.endsWith('/becas/administracion/1')) data = detail;
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

test('cobertura monetaria mantiene precisión, bloqueo y cambios tras error de campo', async ({ page }) => {
  await setup(page);
  const payloads: Record<string, unknown>[] = [];
  await page.route('**/api/becas/1', async route => {
    if (route.request().method() !== 'PUT') return route.fallback();
    payloads.push(route.request().postDataJSON());
    await route.fulfill({ status: payloads.length === 1 ? 400 : 200, json: payloads.length === 1
      ? { message: 'Datos inválidos', validationErrors: { 'cobertura.moneda': 'Moneda no válida' } }
      : { data: summary } });
  });
  await edit(page);
  await page.getByLabel('Tipo de cobertura', { exact: true }).selectOption('MONETARIA');
  await page.getByLabel('Importe confirmado', { exact: true }).fill('9999999999999999.99');
  await page.getByLabel('Moneda', { exact: true }).selectOption('CLP');
  await page.getByLabel('Periodicidad', { exact: true }).selectOption('ANUAL');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('Moneda no válida');
  await expect(page.getByLabel('Importe confirmado', { exact: true })).toHaveValue('9999999999999999.99');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  expect(payloads).toHaveLength(2);
  expect(payloads[1].cobertura).toEqual({ tipo: 'MONETARIA', importe: '9999999999999999.99', moneda: 'CLP', periodicidad: 'ANUAL' });
});

test('importe inválido o sin moneda y porcentaje fuera de rango no escriben', async ({ page }) => {
  await setup(page);
  let writes = 0;
  page.on('request', r => { if (r.method() === 'PUT') writes++; });
  await edit(page);
  await page.getByLabel('Tipo de cobertura', { exact: true }).selectOption('MONETARIA');
  await page.getByLabel('Importe confirmado', { exact: true }).fill('1.001');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('dos decimales');
  await page.getByLabel('Importe confirmado', { exact: true }).fill('0');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('Selecciona la moneda');
  await page.getByLabel('Tipo de cobertura', { exact: true }).selectOption('PORCENTUAL');
  await page.getByLabel('Porcentaje confirmado (%)').fill('101');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('entre 0 y 100');
  expect(writes).toBe(0);
});

test('cambiar de tipo descarta campos incompatibles y permite vaciado explícito', async ({ page }) => {
  await setup(page);
  let payload: Record<string, unknown> | undefined;
  await page.route('**/api/becas/1', async route => {
    if (route.request().method() !== 'PUT') return route.fallback();
    payload = route.request().postDataJSON();
    return route.fulfill({ json: { data: summary } });
  });
  await edit(page);
  await page.getByLabel('Tipo de cobertura', { exact: true }).selectOption('MONETARIA');
  await page.getByLabel('Importe confirmado', { exact: true }).fill('0');
  await page.getByLabel('Moneda', { exact: true }).selectOption('CLP');
  await page.getByLabel('Tipo de cobertura', { exact: true }).selectOption('PORCENTUAL');
  await expect(page.getByLabel('Importe confirmado', { exact: true })).toHaveCount(0);
  await page.getByLabel('Porcentaje confirmado (%)').fill('75.50');
  await page.getByRole('button', { name: 'Quitar datos confirmados' }).click();
  await expect(page.getByLabel('Porcentaje confirmado (%)')).toHaveCount(0);
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  expect(payload?.cobertura).toEqual({ tipo: 'DESCONOCIDA' });
});

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
