import { test, expect, type Page } from '@playwright/test';

async function login(page: Page, email: string) {
  await page.goto('/login');
  await page.getByLabel('Correo electrónico').fill(email);
  await page.getByLabel('Contraseña', { exact: true }).fill('admin123');
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
  await expect(page).not.toHaveURL(/\/login$/);
  const token = await page.evaluate(() => localStorage.getItem('token'));
  expect(token).toBeTruthy();
  return { Authorization: `Bearer ${token}` };
}

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
  await page.getByRole('button', { name: 'Crear Beca', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await expect(page.getByText('Beca de educación CRUD real', { exact: true })).toBeVisible();
  await page.reload();
  await page.getByRole('button', { name: 'Editar Beca de educación CRUD real' }).click();
  await expect(page.getByLabel('RSH Máximo (%)')).toHaveValue('0');
  await expect(page.getByLabel('NEM Mínimo')).toHaveValue('5.5');
  await page.getByLabel('Nombre *', { exact: true }).fill('Beca de educación CRUD actualizada');
  await page.getByRole('button', { name: 'Actualizar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await expect(page.getByText('Beca de educación CRUD actualizada', { exact: true })).toBeVisible();
  const listing = await page.request.get(`${api}/api/becas/administracion?query=CRUD%20actualizada`, { headers });
  expect(listing.status()).toBe(200);
  const records = (await listing.json()).data.content;
  expect(records).toHaveLength(1);
  const id = records[0].idBeca;
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
  const auth = await page.request.post(`${api}/api/auth/login`, { data: { email: 'crud-real@example.com', password: 'password123' } });
  expect(auth.status()).toBe(200);
  const userHeaders = { Authorization: `Bearer ${(await auth.json()).data.token}` };
  expect((await page.request.get(`${api}/api/perfil`, { headers: userHeaders })).status()).toBe(200);
  await page.getByRole('button', { name: 'Desactivar Usuario de verificación real' }).click();
  await page.getByRole('dialog').getByRole('button', { name: 'Desactivar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await page.reload();
  await expect(page.getByRole('button', { name: 'Nuevo Usuario', exact: true })).toBeVisible();
  await expect(page.getByRole('row').filter({ hasText: 'Usuario de verificación real' })).toHaveCount(0);
  const users = await page.request.get(`${api}/api/usuarios`, { headers });
  expect(users.status()).toBe(200);
  // The existing entity filter excludes inactive users from administration.
  expect((await users.json()).data.find((user: { email: string }) => user.email === 'crud-real@example.com')).toBeUndefined();
  expect((await page.request.get(`${api}/api/perfil`, { headers: userHeaders })).status()).toBe(403);
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
