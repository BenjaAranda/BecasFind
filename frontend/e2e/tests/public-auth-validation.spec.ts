import { test, expect } from '@playwright/test';
import { tmpdir } from 'node:os';
import { join } from 'node:path';

const resetToken = '31a9bbbf-9b66-46d3-a69d-2e086fac63da';
const resetLink = `/reset-password#token=${resetToken}`;

for (const width of [390, 1280]) {
  test(`recuperación a ${width}px permite mostrar contraseña por teclado sin desbordamiento`, async ({ page }) => {
    await page.setViewportSize({ width, height: 900 });
    await page.goto(resetLink);
    const password = page.getByLabel('Nueva contraseña', { exact: true });
    await expect(password).toHaveAttribute('aria-describedby', 'new-password-help');
    await password.fill('educación-ñuble');
    await password.focus();
    await page.keyboard.press('Tab');
    await expect(page.getByRole('button', { name: 'Mostrar contraseña', exact: true })).toBeFocused();
    await page.keyboard.press('Space');
    await expect(password).toHaveAttribute('type', 'text');
    await expect(page.getByLabel('Confirmar contraseña', { exact: true })).toHaveAttribute('type', 'password');
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    await page.screenshot({ path: join(tmpdir(), `becasfind-reset-phase8-${width}.png`), fullPage: true });
  });
}

for (const form of ['login', 'register', 'reset'] as const) {
  test(`${form}: contraseña UTF-8 excesiva no envía solicitudes`, async ({ page }) => {
    let writes = 0;
    await page.route('**/api/auth/**', route => { writes++; return route.fulfill({ json: {} }); });
    await page.goto(form === 'reset' ? resetLink : `/${form}`);
    if (form !== 'reset') await page.getByLabel('Correo electrónico').fill('maria@example.com');
    if (form === 'register') await page.getByLabel('Nombre Completo').fill('María Ñuble');
    const password = page.getByLabel(form === 'reset' ? 'Nueva contraseña' : 'Contraseña', { exact: true });
    await password.fill('ñ'.repeat(37));
    if (form !== 'login') await page.getByLabel(form === 'reset' ? 'Confirmar contraseña' : 'Confirmar Contraseña', { exact: true }).fill('ñ'.repeat(37));
    await page.getByRole('button', { name: form === 'login' ? 'Ingresar' : form === 'register' ? 'Crear Cuenta' : 'Guardar nueva contraseña', exact: true }).click();
    await expect(page.getByRole('alert')).toContainText('longitud permitida');
    await expect(password).toHaveValue('ñ'.repeat(37));
    expect(writes).toBe(0);
  });
}

test('registro acota campos, conserva datos y permite reintentar errores por campo', async ({ page }) => {
  const pageErrors: string[] = [];
  page.on('pageerror', error => pageErrors.push(error.message));
  await page.route('**/api/**', route => route.fulfill({ json: {
    data: new URL(route.request().url()).pathname.includes('/becas')
      ? { content: [], totalPages: 0, totalElements: 0, number: 0 } : [],
  } }));
  let writes = 0;
  let release!: () => void;
  const gate = new Promise<void>(resolve => { release = resolve; });
  const token = `e30.${Buffer.from(JSON.stringify({ sub: 'maria@example.com', role: 'STUDENT', nombre: 'María Ñuble', exp: 4_000_000_000 })).toString('base64url')}.test`;
  await page.route('**/api/auth/register', async route => {
    writes++;
    expect(route.request().postDataJSON()).toEqual({ nombreCompleto: 'María Ñuble', email: 'maria@example.com', password: 'ñ'.repeat(36) });
    if (writes === 1) {
      await gate;
      await route.fulfill({ status: 400, json: { status: 400, message: 'Error de validación', data: null, validationErrors: { nombreCompleto: 'Revisa el nombre completo' } } });
    } else await route.fulfill({ status: 201, json: { data: { token } } });
  });
  await page.goto('/register');
  await expect(page.getByLabel('Nombre Completo')).toHaveAttribute('maxlength', '255');
  await expect(page.getByLabel('Correo electrónico')).toHaveAttribute('maxlength', '254');
  await page.getByLabel('Nombre Completo').fill('María Ñuble');
  await page.getByLabel('Correo electrónico').fill('maria@example.com');
  await page.getByLabel('Contraseña', { exact: true }).fill('ñ'.repeat(36));
  await page.getByLabel('Confirmar Contraseña', { exact: true }).fill('ñ'.repeat(36));
  await page.getByRole('button', { name: 'Crear Cuenta', exact: true }).click();
  await expect(page.getByRole('button', { name: 'Creando cuenta...' })).toBeDisabled();
  await expect(page.getByLabel('Nombre Completo')).toBeDisabled();
  release();
  await expect(page.getByRole('alert')).toHaveText('Revisa el nombre completo');
  await expect(page.getByLabel('Nombre Completo')).toHaveValue('María Ñuble');
  await expect(page.getByLabel('Contraseña', { exact: true })).toHaveValue('ñ'.repeat(36));
  await page.getByRole('button', { name: 'Crear Cuenta', exact: true }).click();
  await expect(page).toHaveURL(/\/explorar$/);
  await expect(page.getByRole('heading', { name: 'Tu próximo paso empieza aquí.' })).toBeVisible();
  await expect(page.getByLabel('Región', { exact: true })).toBeVisible();
  expect(pageErrors).toEqual([]);
  expect(writes).toBe(2);
});

test('recuperación conserva el enlace y contraseñas tras validación del servidor', async ({ page }) => {
  let writes = 0;
  await page.route('**/api/auth/reset-password', async route => {
    writes++;
    expect(route.request().postDataJSON()).toEqual({ token: resetToken, newPassword: 'ñ'.repeat(36) });
    await route.fulfill(writes === 1 ? { status: 400, json: { message: 'Error de validación', validationErrors: { newPassword: 'Revisa tu nueva contraseña' }, data: null } } : { json: { status: 200, data: null } });
  });
  await page.goto(resetLink);
  await page.getByLabel('Nueva contraseña', { exact: true }).fill('ñ'.repeat(36));
  await page.getByLabel('Confirmar contraseña', { exact: true }).fill('ñ'.repeat(36));
  await page.getByRole('button', { name: 'Mostrar contraseña', exact: true }).click();
  await expect(page.getByLabel('Nueva contraseña', { exact: true })).toHaveAttribute('type', 'text');
  await expect(page.getByLabel('Confirmar contraseña', { exact: true })).toHaveAttribute('type', 'password');
  await page.getByRole('button', { name: 'Guardar nueva contraseña' }).click();
  await expect(page.getByRole('alert')).toHaveText('Revisa tu nueva contraseña');
  await expect(page.getByLabel('Nueva contraseña', { exact: true })).toHaveValue('ñ'.repeat(36));
  await page.getByRole('button', { name: 'Guardar nueva contraseña' }).click();
  await expect(page.getByRole('heading', { name: 'Ya puedes volver' })).toBeVisible();
  expect(writes).toBe(2);
});

test('solicitud de enlace muestra validación específica y mantiene correo para reintentar', async ({ page }) => {
  let writes = 0;
  await page.route('**/api/auth/forgot-password', async route => {
    writes++;
    await route.fulfill(writes === 1 ? { status: 400, json: { message: 'Error de validación', validationErrors: { email: 'Revisa el correo electrónico' }, data: null } } : { json: { status: 200, data: null } });
  });
  await page.goto('/forgot-password');
  await page.getByLabel('Correo electrónico').fill('maria@example.com');
  await page.getByRole('button', { name: 'Enviar enlace de recuperación' }).click();
  await expect(page.getByRole('alert')).toHaveText('Revisa el correo electrónico');
  await expect(page.getByLabel('Correo electrónico')).toHaveValue('maria@example.com');
  await page.getByRole('button', { name: 'Enviar enlace de recuperación' }).click();
  await expect(page.getByRole('status')).toContainText('Revisa tu correo');
  expect(writes).toBe(2);
});

test('login distingue fallo de conexión y conserva credenciales', async ({ page }) => {
  await page.route('**/api/auth/login', route => route.abort('failed'));
  await page.goto('/login');
  await expect(page.getByLabel('Contraseña', { exact: true })).toHaveAttribute('maxlength', '72');
  await page.getByLabel('Correo electrónico').fill('maria@example.com');
  await page.getByLabel('Contraseña', { exact: true }).fill('password123');
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('Error de conexión');
  await expect(page.getByLabel('Contraseña', { exact: true })).toHaveValue('password123');
  await expect(page.getByRole('button', { name: 'Ingresar', exact: true })).toBeEnabled();
});
