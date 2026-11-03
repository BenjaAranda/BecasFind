import { test, expect, type Page } from '@playwright/test';

function token(claims: Record<string, unknown> = {}) {
  return `e30.${Buffer.from(JSON.stringify({ sub: 'admin@example.com', role: 'ADMIN', nombre: 'Administrador', exp: 4_000_000_000, ...claims })).toString('base64url')}.test`;
}

async function mockApi(page: Page) {
  await page.route('**/api/**', route => {
    const path = new URL(route.request().url()).pathname;
    const data = path.includes('/administracion') || path.includes('/buscar')
      ? { content: [], totalPages: 0, totalElements: 0, number: 0 } : [];
    return route.fulfill({ json: { data } });
  });
}

async function store(page: Page, value: string | null) {
  await page.addInitScript(value => {
    if (value) localStorage.setItem('token', value);
    localStorage.setItem('user', JSON.stringify({ rol: 'ADMIN', email: 'cache@example.com' }));
  }, value);
}

test('restaura sesión administrativa y Axios envía el token', async ({ page }) => {
  await mockApi(page);
  const jwt = token();
  await store(page, jwt);
  const request = page.waitForRequest('**/api/becas/administracion?*');
  await page.goto('/admin/becas');
  await expect(page.getByRole('heading', { name: 'Gestión de Becas' })).toBeVisible();
  expect((await request).headers().authorization).toBe(`Bearer ${jwt}`);
  expect(await page.evaluate(() => localStorage.getItem('user'))).toBeNull();
});

for (const [name, jwt] of [
  ['vencida', token({ exp: 1 })], ['mal formada', 'invalid-token'],
  ['sin identidad', token({ sub: null })], ['sin vencimiento numérico', token({ exp: '4000000000' })],
  ['con rol desconocido', token({ role: 'OTHER' })],
] as const) {
  test(`descarta sesión ${name} antes de abrir administración`, async ({ page }) => {
    await mockApi(page);
    await store(page, jwt);
    let administrativeRequests = 0;
    page.on('request', request => { if (request.url().includes('/administracion')) administrativeRequests++; });
    await page.goto('/admin/becas');
    await expect(page).toHaveURL(/\/login$/);
    await expect(page.getByRole('heading', { name: 'Iniciar Sesión' })).toBeVisible();
    expect(await page.evaluate(() => localStorage.getItem('token'))).toBeNull();
    expect(administrativeRequests).toBe(0);
  });
}

test('el caché de usuario no convierte a un estudiante en administrador', async ({ page }) => {
  await mockApi(page);
  await store(page, token({ role: 'STUDENT', nombre: 'Estudiante' }));
  await page.goto('/admin/becas');
  await expect(page).toHaveURL(/\/$/);
  await expect(page.getByRole('link', { name: 'Admin', exact: true })).toHaveCount(0);
});

test('vencimiento de sesión abierta redirige sin una petición adicional', async ({ page }) => {
  await mockApi(page);
  const now = new Date('2026-09-30T12:00:00Z');
  await page.clock.install({ time: now });
  await page.clock.pauseAt(new Date(now.getTime() + 1000));
  await store(page, token({ exp: now.getTime() / 1000 + 10 }));
  await page.goto('/admin/becas');
  await page.clock.runFor(10);
  await expect(page.getByRole('heading', { name: 'Gestión de Becas' })).toBeVisible();
  await page.clock.fastForward(10_000);
  await expect(page).toHaveURL(/\/login$/);
  expect(await page.evaluate(() => localStorage.getItem('token'))).toBeNull();
});

test('cerrar sesión se propaga a otra pestaña abierta', async ({ page, context }) => {
  await mockApi(page);
  await store(page, token());
  await page.goto('/admin/becas');
  const other = await context.newPage();
  await mockApi(other);
  await other.goto('/admin/becas');
  await expect(other.getByRole('heading', { name: 'Gestión de Becas' })).toBeVisible();
  await page.getByRole('button', { name: 'Cerrar Sesión' }).click();
  await expect(other).toHaveURL(/\/login$/);
  expect(await other.evaluate(() => localStorage.getItem('token'))).toBeNull();
});

test('login guarda identidad del servidor y restaura tras recargar', async ({ page }) => {
  await mockApi(page);
  const jwt = token();
  await page.route('**/api/auth/login', route => route.fulfill({ json: { data: { token: jwt } } }));
  await page.goto('/login');
  await page.getByLabel('Correo electrónico').fill('admin@example.com');
  await page.getByLabel('Contraseña', { exact: true }).fill('secure-pass-123');
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
  await expect(page).toHaveURL(/\/explorar$/);
  expect(await page.evaluate(() => localStorage.getItem('token'))).toBe(jwt);
  await page.goto('/admin/becas');
  await page.reload();
  await expect(page.getByRole('heading', { name: 'Gestión de Becas' })).toBeVisible();
});

test('registro guarda sesión estudiantil y no permite administración', async ({ page }) => {
  await mockApi(page);
  const jwt = token({ sub: 'new@example.com', role: 'STUDENT', nombre: 'Estudiante nuevo' });
  await page.route('**/api/auth/register', route => route.fulfill({ json: { data: { token: jwt } } }));
  await page.goto('/register');
  await page.getByPlaceholder('María González').fill('Estudiante nuevo');
  await page.getByPlaceholder('maria@email.com').fill('new@example.com');
  const passwords = page.locator('input[type="password"]');
  await passwords.nth(0).fill('secure-pass-123');
  await passwords.nth(1).fill('secure-pass-123');
  await page.getByRole('button', { name: 'Crear Cuenta', exact: true }).click();
  await expect(page).toHaveURL(/\/explorar$/);
  expect(await page.evaluate(() => localStorage.getItem('token'))).toBe(jwt);
  await page.goto('/admin/becas');
  await expect(page).toHaveURL(/\/$/);
});

test('sesión estudiantil abre perfil protegido y carga instituciones', async ({ page }) => {
  await mockApi(page);
  await store(page, token({ role: 'STUDENT', nombre: 'Estudiante' }));
  await page.route('**/api/instituciones', route => route.fulfill({ json: {
    data: [{ idInstitucion: 1, nombre: 'Institución de prueba' }],
  } }));
  await page.route('**/api/perfil', route => route.fulfill({ json: { data: null } }));
  await page.goto('/perfil');
  await expect(page.getByRole('heading', { name: 'Mi Perfil Académico' })).toBeVisible();
  await expect(page.getByRole('option', { name: 'Institución de prueba' })).toHaveCount(1);
});
