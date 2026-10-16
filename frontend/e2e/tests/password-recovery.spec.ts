import { test, expect } from '@playwright/test';

const token = '31a9bbbf-9b66-46d3-a69d-2e086fac63da';
const link = `/reset-password#token=${token}`;

test('solicitud muestra instrucciones sin pedir un token manual', async ({ page }) => {
  let requests = 0;
  await page.route('**/api/auth/forgot-password', async route => {
    requests++;
    expect(route.request().postDataJSON()).toEqual({ email: 'student@example.com' });
    await route.fulfill({ json: { status: 200, message: 'Si el correo está registrado…' } });
  });
  await page.goto('/forgot-password');
  await page.getByLabel('Correo electrónico').fill('student@example.com');
  await page.getByRole('button', { name: 'Enviar enlace de recuperación' }).click();
  await expect(page.getByRole('status')).toContainText('Revisa tu correo');
  await expect(page.getByRole('status')).toContainText('15 minutos');
  await expect(page.getByLabel('Token de recuperación')).toHaveCount(0);
  expect(requests).toBe(1);
});

test('envío sin configurar muestra un aviso y permite reintentar', async ({ page }) => {
  await page.route('**/api/auth/forgot-password', route => route.fulfill({ status: 503, json: { status: 503 } }));
  await page.goto('/forgot-password');
  await page.getByLabel('Correo electrónico').fill('student@example.com');
  await page.getByRole('button', { name: 'Enviar enlace de recuperación' }).click();
  await expect(page.getByRole('alert')).toContainText('aún no está disponible');
  await expect(page.getByRole('button', { name: 'Enviar enlace de recuperación' })).toBeEnabled();
});

test('enlace cambia la contraseña y limpia el token del historial', async ({ page }) => {
  await page.route('**/api/auth/reset-password', async route => {
    expect(route.request().postDataJSON()).toEqual({ token, newPassword: 'new-password123' });
    await route.fulfill({ json: { status: 200 } });
  });
  await page.goto(link);
  await expect(page.getByLabel('Nueva contraseña', { exact: true })).toBeVisible();
  expect(page.url()).not.toContain(token);
  await page.getByLabel('Nueva contraseña', { exact: true }).fill('new-password123');
  await page.getByLabel('Confirmar contraseña').fill('new-password123');
  await page.getByRole('button', { name: 'Guardar nueva contraseña' }).click();
  await expect(page.getByRole('heading', { level: 1 })).toHaveText('Ya puedes volver');
  await page.getByRole('link', { name: 'Iniciar sesión', exact: true }).click();
  await expect(page).toHaveURL(/\/login$/);
});

test('contraseñas diferentes no envían solicitudes', async ({ page }) => {
  let requests = 0;
  await page.route('**/api/auth/reset-password', route => { requests++; return route.fulfill({ json: { status: 200 } }); });
  await page.goto(link);
  await page.getByLabel('Nueva contraseña', { exact: true }).fill('new-password123');
  await page.getByLabel('Confirmar contraseña').fill('different-password123');
  await page.getByRole('button', { name: 'Guardar nueva contraseña' }).click();
  await expect(page.getByRole('alert')).toHaveText('Las contraseñas no coinciden.');
  expect(requests).toBe(0);
});

test('token vencido conserva la pantalla y ofrece un enlace nuevo', async ({ page }) => {
  await page.route('**/api/auth/reset-password', route => route.fulfill({ status: 401, json: { status: 401 } }));
  await page.goto(link);
  await page.getByLabel('Nueva contraseña', { exact: true }).fill('new-password123');
  await page.getByLabel('Confirmar contraseña').fill('new-password123');
  await page.getByRole('button', { name: 'Guardar nueva contraseña' }).click();
  await expect(page.getByRole('alert')).toContainText('venció o ya fue utilizado');
  await expect(page).toHaveURL(/\/reset-password$/);
  await expect(page.getByRole('link', { name: 'Solicitar un nuevo enlace' })).toBeVisible();
});

test('límite de intentos explica la espera y no declara éxito', async ({ page }) => {
  await page.route('**/api/auth/reset-password', route => route.fulfill({ status: 429, headers: { 'Retry-After': '120' }, json: { status: 429 } }));
  await page.goto(link);
  await page.getByLabel('Nueva contraseña', { exact: true }).fill('new-password123');
  await page.getByLabel('Confirmar contraseña').fill('new-password123');
  await page.getByRole('button', { name: 'Guardar nueva contraseña' }).click();
  await expect(page.getByRole('alert')).toContainText('demasiados intentos');
  await expect(page.getByRole('button', { name: 'Guardar nueva contraseña' })).toBeEnabled();
  await expect(page.getByRole('heading', { level: 1 })).toHaveText('Elige tu nueva contraseña');
});

test('enlace incompleto en móvil no muestra el formulario ni desborda', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto('/reset-password');
  await expect(page.getByRole('alert')).toContainText('no es válido');
  await expect(page.getByLabel('Nueva contraseña', { exact: true })).toHaveCount(0);
  expect(await page.evaluate(() => document.documentElement.scrollWidth <= window.innerWidth)).toBe(true);
});
