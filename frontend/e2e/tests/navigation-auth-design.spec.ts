import { test, expect, type Page } from '@playwright/test';
import { tmpdir } from 'node:os';
import { join } from 'node:path';

async function mockApi(page: Page) {
  await page.route('**/api/**', route => route.fulfill({ json: { data: new URL(route.request().url()).pathname.includes('/administracion') ? { content: [], totalPages: 0, totalElements: 0, number: 0 } : [] } }));
}

test('login permite mostrar contraseña y recuperarse de un rechazo', async ({ page }) => {
  await mockApi(page);
  await page.route('**/api/auth/login', route => route.fulfill({ status: 401, json: { message: 'Credenciales incorrectas' } }));
  await page.goto('/login');
  const password = page.getByLabel('Contraseña', { exact: true });
  await page.getByLabel('Correo electrónico').fill('maria@example.com');
  await password.fill('clave-segura');
  await page.getByRole('button', { name: 'Mostrar contraseña', exact: true }).click();
  await expect(password).toHaveAttribute('type', 'text');
  await expect(password).toHaveValue('clave-segura');
  await page.getByRole('button', { name: 'Ocultar contraseña', exact: true }).click();
  await expect(password).toHaveAttribute('type', 'password');
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('Credenciales incorrectas');
  await expect(password).toHaveValue('clave-segura');
  await expect(page.getByRole('button', { name: 'Ingresar', exact: true })).toBeEnabled();
});

test('registro valida coincidencia y controla visibilidad de cada contraseña', async ({ page }) => {
  await mockApi(page);
  let writes = 0;
  page.on('request', request => { if (request.url().includes('/auth/register')) writes++; });
  await page.goto('/register');
  await page.getByLabel('Nombre Completo').fill('María González');
  await page.getByLabel('Correo electrónico').fill('maria@example.com');
  await page.getByLabel('Contraseña', { exact: true }).fill('clave-segura');
  await page.getByLabel('Confirmar Contraseña', { exact: true }).fill('otra-segura');
  await page.getByRole('button', { name: 'Mostrar confirmación de contraseña' }).click();
  await expect(page.getByLabel('Confirmar Contraseña', { exact: true })).toHaveAttribute('type', 'text');
  await expect(page.getByLabel('Contraseña', { exact: true })).toHaveAttribute('type', 'password');
  await page.getByRole('button', { name: 'Crear Cuenta', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('Las contraseñas no coinciden');
  expect(writes).toBe(0);
});

test('menú público móvil cierra con Escape y al navegar', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto('/');
  const toggle = page.getByRole('button', { name: 'Abrir menú' });
  await toggle.click();
  await expect(page.getByRole('navigation', { name: 'Navegación principal' })).toBeVisible();
  await page.keyboard.press('Escape');
  await expect(toggle).toBeFocused();
  await expect(toggle).toHaveAttribute('aria-expanded', 'false');
  await toggle.click();
  await page.getByRole('navigation').getByRole('link', { name: 'Ingresar', exact: true }).click();
  await expect(page).toHaveURL(/\/login$/);
  await expect(page.getByRole('heading', { name: 'Iniciar Sesión' })).toBeVisible();
});

test('administración móvil navega y vuelve al buscador sin desbordamiento', async ({ page }) => {
  await mockApi(page);
  const token = `e30.${Buffer.from(JSON.stringify({ sub: 'admin@example.com', role: 'ADMIN', nombre: 'Administrador', exp: 4_000_000_000 })).toString('base64url')}.test`;
  await page.addInitScript(token => localStorage.setItem('token', token), token);
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto('/admin/becas');
  await page.getByRole('button', { name: 'Abrir navegación administrativa' }).click();
  await page.getByRole('link', { name: 'Usuarios', exact: true }).click();
  await expect(page).toHaveURL(/\/admin\/usuarios$/);
  await expect(page.getByRole('button', { name: 'Abrir navegación administrativa' })).toHaveAttribute('aria-expanded', 'false');
  expect(await page.evaluate(() => document.documentElement.scrollWidth <= window.innerWidth)).toBe(true);
  await page.screenshot({ path: join(tmpdir(), 'becasfind-admin-mobile.png'), fullPage: true });
  await page.getByRole('button', { name: 'Abrir navegación administrativa' }).click();
  await page.getByRole('link', { name: 'Volver al Buscador' }).click();
  await expect(page).toHaveURL(/\/explorar$/);
});

for (const width of [390, 1280]) {
  test(`autenticación adaptable a ${width}px sin desbordamiento`, async ({ page }) => {
    await page.setViewportSize({ width, height: 900 });
    for (const path of ['login', 'register']) {
      await page.goto(`/${path}`);
      await expect(page.locator('h1')).toBeVisible();
      expect(await page.evaluate(() => document.documentElement.scrollWidth <= window.innerWidth)).toBe(true);
      await page.screenshot({ path: join(tmpdir(), `becasfind-${path}-${width}.png`), fullPage: true });
    }
  });
}
