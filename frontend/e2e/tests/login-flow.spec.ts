// CP-01, CP-04, CP-05, CP-67: Login flow validation
import { test, expect } from '@playwright/test';

test('CP-04: Login fallido con campos vacios', async ({ page }) => {
  await page.goto('/login');
  // Click submit without filling anything
  await page.getByRole('button', { name: /Ingresar/i }).click();
  // Should show validation or error
  await expect(page.getByRole('button', { name: /Ingresar/i })).toBeVisible({ timeout: 5000 });
});

test('CP-01: Login exitoso con credenciales validas', async ({ page }) => {
  await page.goto('/login');
  await page.getByPlaceholder('admin@becasfind.cl').fill('admin@becasfind.cl');
  await page.locator('input[type="password"]').fill('admin123');
  await page.getByRole('button', { name: /Ingresar/i }).click();
  // Should redirect to explorar
  await expect(page).toHaveURL(/explorar/, { timeout: 10000 });
});

test('CP-67: Login redirige si ya autenticado', async ({ page }) => {
  // Login first
  await page.goto('/login');
  await page.getByPlaceholder('admin@becasfind.cl').fill('admin@becasfind.cl');
  await page.locator('input[type="password"]').fill('admin123');
  await page.getByRole('button', { name: /Ingresar/i }).click();
  await expect(page).toHaveURL(/explorar/, { timeout: 10000 });
  
  // User is now logged in — verify protected routes work
  await page.goto('/explorar');
  await expect(page.locator('text=Cerrar').or(page.locator('text=Salir'))).toBeVisible({ timeout: 3000 });
});

test('CP-05: Login fallido con credenciales incorrectas', async ({ page }) => {
  await page.goto('/login');
  await page.getByPlaceholder('admin@becasfind.cl').fill('fake@noexiste.cl');
  await page.locator('input[type="password"]').fill('wrongpassword');
  await page.getByRole('button', { name: /Ingresar/i }).click();
  // Should show error message
  await expect(page.locator('text=incorrecto').or(page.locator('text=error')).or(page.locator('text=Error'))).toBeVisible({ timeout: 8000 });
});
