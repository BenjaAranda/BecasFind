import { test, expect, type Page } from '@playwright/test';

async function login(page: Page, email: string) {
  await page.goto('/login');
  await page.getByLabel('Correo electrónico').fill(email);
  await page.getByLabel('Contraseña', { exact: true }).fill('admin123');
  const favorites = page.waitForResponse(response => response.url().endsWith('/api/favoritos') && response.status() === 200);
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
  await expect(page).not.toHaveURL(/\/login$/);
  await favorites;
  await expect(page.getByRole('region', { name: 'Resultados de búsqueda' })).toHaveAttribute('aria-busy', 'false');
  const token = await page.evaluate(() => localStorage.getItem('token'));
  expect(token).toBeTruthy();
  return { Authorization: `Bearer ${token}` };
}

test('sesión con firma inválida recibe 401 y la interfaz vuelve al login', async ({ page }) => {
  await login(page, 'estudiante@duoc.cl');
  const invalidToken = await page.evaluate(() => {
    const token = localStorage.getItem('token');
    if (!token) throw new Error('No existe sesión');
    const parts = token.split('.');
    parts[2] = (parts[2][0] === 'A' ? 'B' : 'A') + parts[2].slice(1);
    const invalid = parts.join('.');
    localStorage.setItem('token', invalid);
    return invalid;
  });
  const api = process.env.LIVE_API_URL;
  if (!api) throw new Error('Use infra/verify-profile-browser.ps1');
  const apiDenied = await page.request.get(`${api}/api/perfil`, {
    headers: { Authorization: `Bearer ${invalidToken}` },
  });
  expect(apiDenied.status()).toBe(401);
  expect(await apiDenied.json()).toMatchObject({ status: 401, data: null });
  const denied = page.waitForResponse(response =>
    response.url().endsWith('/api/perfil') && response.status() === 401);
  await page.goto('/perfil');
  await denied;
  await expect(page).toHaveURL(/\/login$/);
  await expect(page.getByRole('button', { name: 'Ingresar', exact: true })).toBeVisible();
  expect(await page.evaluate(() => localStorage.getItem('token'))).toBeNull();
});

test('administrador crea edita y elimina beca con persistencia real', async ({ page }) => {
  const api = process.env.LIVE_API_URL;
  if (!api) throw new Error('Use infra/verify-profile-browser.ps1');
  const headers = await login(page, 'admin@becasfind.cl');
  await page.goto('/admin/becas');
  await page.getByRole('button', { name: 'Nueva Beca', exact: true }).click();
  await page.getByLabel('Nombre *', { exact: true }).fill('Beca de educación CRUD real');
  await page.getByLabel('Tipo Beca *').selectOption('1');
  await page.getByLabel('Institución *').selectOption('1');
  await page.getByLabel('Cierre Postulación *').fill('2027-12-31');
  await page.getByLabel('RSH Máximo (%)').fill('0');
  await page.getByLabel('NEM Mínimo').fill('5.5');
  await page.getByLabel('Monto Cobertura').fill('Importe según fuente de prueba');
  await page.getByLabel('Tipo de cobertura', { exact: true }).selectOption('MONETARIA');
  await page.getByLabel('Importe confirmado', { exact: true }).fill('9999999999999999.99');
  await page.getByLabel('Moneda', { exact: true }).selectOption('CLP');
  await page.getByLabel('Periodicidad', { exact: true }).selectOption('ANUAL');
  await page.getByRole('button', { name: 'Crear Beca', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await expect(page.getByText('Beca de educación CRUD real', { exact: true })).toBeVisible();
  await page.reload();
  await page.getByRole('button', { name: 'Editar Beca de educación CRUD real' }).click();
  await expect(page.getByLabel('RSH Máximo (%)')).toHaveValue('0');
  await expect(page.getByLabel('NEM Mínimo')).toHaveValue('5.5');
  await expect(page.getByLabel('Importe confirmado', { exact: true })).toHaveValue('9999999999999999.99');
  await expect(page.getByLabel('Moneda', { exact: true })).toHaveValue('CLP');
  await expect(page.getByLabel('Periodicidad', { exact: true })).toHaveValue('ANUAL');
  await page.getByLabel('Tipo de cobertura', { exact: true }).selectOption('PORCENTUAL');
  await page.getByLabel('Porcentaje confirmado (%)').fill('75.50');
  await page.getByLabel('Nombre *', { exact: true }).fill('Beca de educación CRUD actualizada');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await expect(page.getByText('Beca de educación CRUD actualizada', { exact: true })).toBeVisible();
  const listing = await page.request.get(`${api}/api/becas/administracion?query=CRUD%20actualizada`, { headers });
  expect(listing.status()).toBe(200);
  const records = (await listing.json()).data.content;
  expect(records).toHaveLength(1);
  const id = records[0].idBeca;
  expect(records[0].cobertura).toMatchObject({ tipo: 'PORCENTUAL', porcentaje: '75.50' });
  expect(records[0].cobertura.importe ?? null).toBeNull();
  await page.getByRole('button', { name: 'Editar Beca de educación CRUD actualizada' }).click();
  await expect(page.getByLabel('Porcentaje confirmado (%)')).toHaveValue('75.50');
  await page.getByRole('button', { name: 'Quitar datos confirmados' }).click();
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  const cleared = await page.request.get(`${api}/api/becas/${id}`, { headers });
  expect((await cleared.json()).data.cobertura.tipo).toBe('DESCONOCIDA');
  await page.getByRole('button', { name: 'Eliminar Beca de educación CRUD actualizada' }).click();
  await page.getByRole('dialog').getByRole('button', { name: 'Eliminar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await expect(page.getByText('Beca de educación CRUD actualizada', { exact: true })).toHaveCount(0);
  expect((await page.request.get(`${api}/api/becas/${id}`, { headers })).status()).toBe(404);
});

test('crear y desactivar usuario bloquea su sesión existente y nuevos accesos', async ({ page }) => {
  const api = process.env.LIVE_API_URL;
  if (!api) throw new Error('Use infra/verify-profile-browser.ps1');
  const headers = await login(page, 'admin@becasfind.cl');
  await page.goto('/admin/usuarios');
  await page.getByRole('button', { name: 'Nuevo Usuario', exact: true }).click();
  await page.getByLabel('Nombre Completo *').fill('Usuario de verificación real');
  await page.getByLabel('Email *').fill('crud-real@example.com');
  await page.getByLabel('Contraseña *').fill('password123');
  await page.getByRole('button', { name: 'Crear Usuario', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await expect(page.getByText('Usuario de verificación real', { exact: true })).toBeVisible();
  await page.getByRole('button', { name: 'Editar Usuario de verificación real' }).click();
  await expect(page.getByLabel('Email *')).toHaveValue('crud-real@example.com');
  await expect(page.getByLabel('Contraseña *')).toHaveCount(0);
  await expect(page.getByLabel('Rol *')).toHaveCount(0);
  await page.getByLabel('Nombre Completo *').fill('Usuario real actualizado');
  await page.getByRole('button', { name: 'Guardar cambios', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await page.reload();
  await expect(page.getByText('Usuario real actualizado', { exact: true })).toBeVisible();
  const auth = await page.request.post(`${api}/api/auth/login`, { data: { email: 'crud-real@example.com', password: 'password123' } });
  expect(auth.status()).toBe(200);
  const userHeaders = { Authorization: `Bearer ${(await auth.json()).data.token}` };
  expect((await page.request.get(`${api}/api/perfil`, { headers: userHeaders })).status()).toBe(200);
  await page.getByRole('button', { name: 'Desactivar Usuario real actualizado' }).click();
  await page.getByRole('dialog').getByRole('button', { name: 'Desactivar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await page.reload();
  await expect(page.getByRole('button', { name: 'Nuevo Usuario', exact: true })).toBeVisible();
  const row = page.getByRole('row').filter({ hasText: 'Usuario real actualizado' });
  await expect(row.getByText('Inactivo', { exact: true })).toBeVisible();
  await expect(row.getByRole('button', { name: /Desactivar/ })).toHaveCount(0);
  const users = await page.request.get(`${api}/api/usuarios`, { headers });
  expect(users.status()).toBe(200);
  expect((await users.json()).data.find((user: { email: string }) => user.email === 'crud-real@example.com').activo).toBe(false);
  expect((await page.request.get(`${api}/api/perfil`, { headers: userHeaders })).status()).toBe(401);
  expect((await page.request.post(`${api}/api/auth/login`, { data: { email: 'crud-real@example.com', password: 'password123' } })).status()).toBe(401);
});

test('estudiante no accede a administración ni puede escribir por API', async ({ page }) => {
  const api = process.env.LIVE_API_URL;
  if (!api) throw new Error('Use infra/verify-profile-browser.ps1');
  const headers = await login(page, 'estudiante@duoc.cl');
  for (const path of ['/admin/becas', '/admin/usuarios']) {
    await page.goto(path);
    await expect(page).toHaveURL(/\/$/);
    await expect(page.getByRole('heading', { name: /Gestión de/ })).toHaveCount(0);
  }
  expect((await page.request.get(`${api}/api/becas/administracion`, { headers })).status()).toBe(403);
  expect((await page.request.get(`${api}/api/usuarios`, { headers })).status()).toBe(403);
  const scholarship = { nombre: 'Beca no autorizada', idInstitucion: 1, idTipoBeca: 1, fechaCierrePostulacion: '2027-12-31' };
  expect((await page.request.post(`${api}/api/becas`, { headers, data: scholarship })).status()).toBe(403);
  expect((await page.request.put(`${api}/api/becas/1`, { headers, data: scholarship })).status()).toBe(403);
  expect((await page.request.delete(`${api}/api/becas/1`, { headers })).status()).toBe(403);
  expect((await page.request.delete(`${api}/api/usuarios/1`, { headers })).status()).toBe(403);
});
