import { test, expect } from '@playwright/test';

test('panel consulta el endpoint administrativo y muestra becas inactivas', async ({ page }) => {
  const encoded = Buffer.from(JSON.stringify({ sub: 'admin@example.com', role: 'ADMIN', nombre: 'Admin de prueba', exp: 4_000_000_000 })).toString('base64url');
  await page.addInitScript(token => localStorage.setItem('token', token), `e30.${encoded}.test`);
  const queries: string[] = [];
  await page.route('**/api/becas/administracion?*', async route => {
    const url = new URL(route.request().url());
    queries.push(url.searchParams.get('query') || '');
    await route.fulfill({ json: { status: 200, data: {
      content: [{ idBeca: "00000000-0000-4000-8000-000000000001", nombre: 'Beca inactiva de prueba', estadoActiva: false,
        fechaCierrePostulacion: '2020-01-01', nombreInstitucion: 'Institución de prueba', nombreTipoBeca: 'Arancel' }],
      number: 0, totalPages: 1, totalElements: 1,
    } } });
  });
  await page.goto('/admin/becas');
  await expect(page.getByText('Beca inactiva de prueba', { exact: true })).toBeVisible();
  await expect(page.getByText('Inactiva', { exact: true })).toBeVisible();
  await page.getByPlaceholder('Buscar beca...').fill('inactiva');
  await expect.poll(() => queries.includes('inactiva')).toBe(true);
});
