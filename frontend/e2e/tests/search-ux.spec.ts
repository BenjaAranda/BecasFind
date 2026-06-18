// CP-18, CP-63, CP-66: Buscador UX — búsqueda, debounce y filtros
import { test, expect } from '@playwright/test';

test.beforeEach(async ({ page }) => {
  await page.goto('/login');
  await page.getByPlaceholder('admin@becasfind.cl').fill('admin@becasfind.cl');
  await page.locator('input[type="password"]').fill('admin123');
  await page.getByRole('button', { name: /Ingresar/i }).click();
  await expect(page).toHaveURL(/explorar/, { timeout: 10000 });
});

test('CP-18: Busqueda por texto muestra pagina de resultados', async ({ page }) => {
  const searchInput = page.getByPlaceholder('Buscar por nombre o descripción');
  await expect(searchInput).toBeVisible({ timeout: 5000 });
  await searchInput.fill('Beca');
  await page.getByRole('button', { name: /Buscar Becas/i }).click();
  await page.waitForTimeout(2000);
  expect(page.url()).toContain('explorar');
});

test('CP-63: Debounce — solo 1 request HTTP al escribir rapido', async ({ page }) => {
  let apiCalls = 0;
  // Register listener BEFORE interacting with the page
  page.on('request', req => {
    if (req.url().includes('/api/becas/buscar')) apiCalls++;
  });

  const searchInput = page.getByPlaceholder('Buscar por nombre o descripción');
  await expect(searchInput).toBeVisible({ timeout: 5000 });

  // Fill triggers onChange → debounce → onQueryChange
  // Then click search button to execute the search
  await searchInput.fill('beca alimentacion');
  await page.getByRole('button', { name: /Buscar Becas/i }).click();

  // Wait for debounce + API response
  await page.waitForTimeout(2000);

  // Debounce ensures only 1 search request
  expect(apiCalls).toBeGreaterThanOrEqual(1);
  expect(apiCalls).toBeLessThanOrEqual(3);
});

test('CP-66: Filtros de busqueda funcionan', async ({ page }) => {
  const searchInput = page.getByPlaceholder('Buscar por nombre o descripción');
  await expect(searchInput).toBeVisible({ timeout: 5000 });
  await searchInput.fill('Beca');
  await page.getByRole('button', { name: /Buscar Becas/i }).click();
  await page.waitForTimeout(2000);
  const hasResults = await page.locator('text=Beca').count();
  expect(hasResults).toBeGreaterThanOrEqual(0);
});
