import { test, expect } from '@playwright/test';

test('búsqueda real combina RSH NEM región tipo y orden y muestra ausencia de resultados', async ({ page }) => {
  const api = process.env.LIVE_API_URL;
  if (!api) throw new Error('Use infra/verify-profile-browser.ps1');
  await page.goto('/login');
  await page.getByLabel('Correo electrónico').fill('estudiante@duoc.cl');
  await page.getByLabel('Contraseña', { exact: true }).fill('admin123');
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
  await expect(page).toHaveURL(/\/explorar$/);
  const search = page.waitForResponse(response => response.url() === `${api}/api/becas/buscar`
    && response.request().postDataJSON()?.query === 'arancel');
  await page.goto('/explorar?q=arancel&rsh=60&nem=5.5&region=2&tipo=1&sort=fechaDesc');
  const response = await search;
  expect(response.status()).toBe(200);
  expect(response.request().postDataJSON()).toEqual({ query: 'arancel', rsh: 60, nem: 5.5,
    regionId: 2, idTipoBeca: 1, sort: 'fechaDesc', page: 0, size: 12 });
  const result = (await response.json()).data;
  expect(result.totalElements).toBe(2);
  expect(result.content.map((beca: { idBeca: number }) => beca.idBeca)).toEqual([1, 3]);
  await expect(page.getByRole('heading', { name: '2 becas encontradas', exact: true })).toBeVisible();
  const titles = page.getByRole('button', { name: /^Beca (Nuevo Milenio|PUCV Arancel)$/ });
  await expect(titles).toHaveText(['Beca Nuevo Milenio', 'Beca PUCV Arancel']);
  await expect(page.getByRole('button', { name: 'Beca Excelencia', exact: true })).toHaveCount(0);
  await expect(page.getByRole('button', { name: 'Beca Alimentacion DUOC', exact: true })).toHaveCount(0);
  const rshRejected = page.waitForResponse(response => response.url() === `${api}/api/becas/buscar`
    && response.request().postDataJSON()?.rsh === 61);
  await page.getByLabel('RSH (%)').fill('61');
  await page.getByRole('button', { name: 'Buscar Becas', exact: true }).click();
  expect((await (await rshRejected).json()).data.content).toEqual([]);
  await expect(page.getByText('No se encontraron becas con esos filtros', { exact: true })).toBeVisible();
  const nemFiltered = page.waitForResponse(response => response.url() === `${api}/api/becas/buscar`
    && response.request().postDataJSON()?.nem === 5.4);
  await page.getByLabel('RSH (%)').fill('60');
  await page.getByLabel('Tu promedio NEM').fill('5.4');
  await page.getByRole('button', { name: 'Buscar Becas', exact: true }).click();
  expect((await (await nemFiltered).json()).data.content.map((beca: { idBeca: number }) => beca.idBeca)).toEqual([1]);
  await expect(page.getByRole('heading', { name: '1 beca encontrada', exact: true })).toBeVisible();
  await expect(page.getByRole('button', { name: 'Beca Nuevo Milenio', exact: true })).toBeVisible();
  await expect(page.getByRole('button', { name: 'Beca PUCV Arancel', exact: true })).toHaveCount(0);
  const empty = page.waitForResponse(response => response.url() === `${api}/api/becas/buscar`
    && response.request().postDataJSON()?.query === 'sin-coincidencias-prueba-9');
  await page.getByLabel('Buscar', { exact: true }).fill('sin-coincidencias-prueba-9');
  await page.getByRole('button', { name: 'Buscar Becas', exact: true }).click();
  const emptyResult = (await (await empty).json()).data;
  expect(emptyResult.totalElements).toBe(0);
  expect(emptyResult.content).toEqual([]);
  await expect(page.getByText('No se encontraron becas con esos filtros', { exact: true })).toBeVisible();
  await expect(titles).toHaveCount(0);
});
