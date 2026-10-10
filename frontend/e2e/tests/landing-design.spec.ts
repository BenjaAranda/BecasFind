import { test, expect } from '@playwright/test';
import { join } from 'node:path';
import { tmpdir } from 'node:os';

test('portada anónima explica acceso y ofrece registro y login', async ({ page }) => {
  await page.goto('/');
  await expect(page.getByRole('heading', { level: 1 })).toContainText('estudiando');
  await expect(page.getByText('Explora gratis y sin cuenta. Inicia sesión solo para guardar tu perfil y favoritas o acceder como administrador.')).toBeVisible();
  await expect(page.locator('main')).not.toContainText('cientos de becas');
  await expect(page.locator('main')).not.toContainText('realmente puedes obtener');
  await page.getByRole('link', { name: 'Explorar becas', exact: true }).last().click();
  await expect(page).toHaveURL(/\/explorar$/);
  await page.goto('/');
  await page.getByRole('link', { name: 'Ya tengo cuenta' }).click();
  await expect(page).toHaveURL(/\/login$/);
});

test('portada de estudiante abre búsqueda y perfil con su sesión', async ({ page }) => {
  const token = `e30.${Buffer.from(JSON.stringify({ sub: 'student@example.com', role: 'STUDENT', nombre: 'Estudiante', exp: 4_000_000_000 })).toString('base64url')}.test`;
  await page.addInitScript(token => localStorage.setItem('token', token), token);
  await page.route('**/api/**', route => route.fulfill({ json: { data: route.request().url().includes('/buscar') ? { content: [], totalPages: 0, totalElements: 0 } : [] } }));
  await page.goto('/');
  await expect(page.getByRole('link', { name: 'Crear mi cuenta' })).toHaveCount(0);
  await page.getByRole('link', { name: 'Explorar becas', exact: true }).last().click();
  await expect(page).toHaveURL(/\/explorar$/);
  await page.goto('/');
  await page.getByRole('link', { name: 'Completar mi perfil' }).click();
  await expect(page).toHaveURL(/\/perfil$/);
});

test('teclado puede saltar navegación y la portada informa límites de recomendaciones', async ({ page }) => {
  await page.goto('/');
  await page.keyboard.press('Tab');
  await expect(page.getByRole('link', { name: 'Saltar al contenido' })).toBeFocused();
  await page.keyboard.press('Enter');
  await expect(page.locator('main')).toBeFocused();
  await expect(page.getByText(/una coincidencia con tu perfil no garantiza/)).toBeVisible();
  await expect(page.getByRole('listitem')).toHaveCount(3);
});

for (const width of [360, 390, 768, 1440]) {
  test(`portada a ${width}px conserva acciones y no desborda`, async ({ page }) => {
    await page.setViewportSize({ width, height: 900 });
    await page.goto('/');
    await expect(page.getByRole('link', { name: 'Explorar becas', exact: true }).last()).toBeVisible();
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    await page.screenshot({ path: join(tmpdir(), `becasfind-landing-${width}.png`), fullPage: true });
  });
}
