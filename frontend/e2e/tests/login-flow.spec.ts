import { test, expect, type Page } from '@playwright/test';

// Controlled tokens exercise the interface; the live suite verifies server signatures.
const token = `e30.${Buffer.from(JSON.stringify({ sub: 'student@example.com', role: 'STUDENT', nombre: 'Estudiante de prueba', exp: 4_000_000_000 })).toString('base64url')}.test`;

async function mockApi(page: Page, status = 200) {
  const submissions: unknown[] = [];
  await page.route('**/api/**', route => {
    const path = new URL(route.request().url()).pathname;
    if (path === '/api/auth/login') {
      submissions.push(route.request().postDataJSON());
      return route.fulfill({ status, json: status === 200
        ? { data: { token, nombreCompleto: 'Estudiante de prueba', nombreRol: 'STUDENT' } }
        : { status: 401, message: 'Correo electrónico o contraseña incorrectos', data: null } });
    }
    const data = path.includes('/buscar') ? { content: [], totalPages: 0, totalElements: 0, number: 0 } : [];
    return route.fulfill({ json: { data } });
  });
  return submissions;
}

async function login(page: Page) {
  await page.goto('/login');
  await page.getByLabel('Correo electrónico').fill('student@example.com');
  await page.getByLabel('Contraseña', { exact: true }).fill('password123');
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
}

async function expectStudent(page: Page) {
  await expect(page).toHaveURL(/\/explorar$/);
  await expect(page.getByRole('heading', { name: 'Tu próximo paso empieza aquí.' })).toBeVisible();
  await expect(page.getByRole('region', { name: 'Resultados de búsqueda' })).toHaveAttribute('aria-busy', 'false');
  await expect(page.getByText('Estudiante de prueba', { exact: true })).toBeVisible();
  await expect(page.getByRole('button', { name: 'Salir', exact: true })).toBeVisible();
  await expect(page.getByRole('link', { name: 'Admin', exact: true })).toHaveCount(0);
  expect(await page.evaluate(() => localStorage.getItem('token'))).toBe(token);
}

test('CP-04: campos vacíos o correo inválido no envían credenciales', async ({ page }) => {
  const submissions = await mockApi(page);
  await page.goto('/login');
  const email = page.getByLabel('Correo electrónico');
  const password = page.getByLabel('Contraseña', { exact: true });
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
  expect(await email.evaluate((input: HTMLInputElement) => input.validity.valueMissing)).toBe(true);
  expect(await password.evaluate((input: HTMLInputElement) => input.validity.valueMissing)).toBe(true);
  await email.fill('correo-inválido');
  await password.fill('password123');
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
  expect(await email.evaluate((input: HTMLInputElement) => input.validity.typeMismatch)).toBe(true);
  await expect(page).toHaveURL(/\/login$/);
  expect(submissions).toEqual([]);
  expect(await page.evaluate(() => localStorage.getItem('token'))).toBeNull();
});

test('CP-01: login guarda la sesión y muestra el buscador y la identidad', async ({ page }) => {
  const submissions = await mockApi(page);
  const errors: string[] = [];
  page.on('pageerror', error => errors.push(error.message));
  await login(page);
  await expectStudent(page);
  expect(submissions).toEqual([{ email: 'student@example.com', password: 'password123' }]);
  expect(errors).toEqual([]);
});

test('CP-67: la sesión persistida restaura la ruta protegida sin otro login', async ({ page }) => {
  const submissions = await mockApi(page);
  await login(page);
  await expectStudent(page);
  await page.reload();
  await expectStudent(page);
  expect(submissions).toHaveLength(1);
});

test('CP-05: credenciales rechazadas conservan los campos y permiten reintentar', async ({ page }) => {
  const submissions = await mockApi(page, 401);
  await login(page);
  await expect(page.getByRole('alert')).toHaveText('Correo electrónico o contraseña incorrectos');
  await expect(page).toHaveURL(/\/login$/);
  await expect(page.getByLabel('Correo electrónico')).toHaveValue('student@example.com');
  await expect(page.getByLabel('Contraseña', { exact: true })).toHaveValue('password123');
  await expect(page.getByRole('button', { name: 'Ingresar', exact: true })).toBeEnabled();
  expect(submissions).toHaveLength(1);
  expect(await page.evaluate(() => localStorage.getItem('token'))).toBeNull();
});
