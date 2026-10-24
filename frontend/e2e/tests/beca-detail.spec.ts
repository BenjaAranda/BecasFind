import { test, expect } from '@playwright/test';

const beca = { idBeca: "00000000-0000-4000-8000-000000000001", nombre: 'Beca de educación', estadoActiva: true,
  fechaInicioPostulacion: '2026-01-01', fechaCierrePostulacion: '2026-12-31',
  descripcionCorta: 'Apoyo para estudiar', descripcionLarga: '', montoCobertura: '$100.000',
  urlOficial: 'https://example.com/becas', regiones: [], requisitoPerfil: null,
  institucion: { nombre: 'Institución de prueba' }, tipoBeca: { nombre: 'Arancel' },
  documentosRequeridos: [
    { idDocumento: 1, nombreDocumento: 'Certificado de matrícula', esObligatorio: true },
    { idDocumento: 2, nombreDocumento: 'Carta de motivación', esObligatorio: false },
  ] };

test('CP-61: detalle muestra documentos obligatorios y opcionales', async ({ page }) => {
  await page.route('**/api/becas/00000000-0000-4000-8000-000000000001', route => route.fulfill({ json: { data: beca } }));
  await page.goto('/becas/00000000-0000-4000-8000-000000000001');
  await expect(page.getByRole('heading', { name: beca.nombre, exact: true })).toBeVisible();
  await expect(page.getByRole('heading', { name: 'Documentos Requeridos' })).toBeVisible();
  const required = page.getByRole('listitem').filter({ hasText: 'Certificado de matrícula' });
  await expect(required).toContainText('(Obligatorio)');
  const optional = page.getByRole('listitem').filter({ hasText: 'Carta de motivación' });
  await expect(optional).toContainText('(Opcional)');
});

test('CP-62: detalle identifica una beca vencida', async ({ page }) => {
  await page.route('**/api/becas/00000000-0000-4000-8000-000000000006', route => route.fulfill({ json: { data: {
    ...beca, idBeca: "00000000-0000-4000-8000-000000000006", fechaCierrePostulacion: '2024-03-01',
  } } }));
  await page.goto('/becas/00000000-0000-4000-8000-000000000006');
  await expect(page.getByRole('heading', { name: beca.nombre, exact: true })).toBeVisible();
  await expect(page.getByText('Vencida', { exact: true })).toBeVisible();
  await expect(page.getByText('Vigente', { exact: true })).toHaveCount(0);
  await expect(page.getByText('1 de marzo de 2024', { exact: true })).toBeVisible();
});
