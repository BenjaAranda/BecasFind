import { test, expect, type Page } from '@playwright/test';
import { execFileSync } from 'node:child_process';
import { join } from 'node:path';

const header = 'nombre,institucion,tipo_beca,monto,fecha_inicio,fecha_cierre,rsh_maximo,nem_minimo,regiones,descripcion,descripcion_larga,url';
const name = 'CSV educación Ñuble real';
const row = (title: string, amount = '100000', region = 'RM') =>
  `${title},DUOC UC,Beca de Arancel,${amount},2026-01-01,2027-12-31,60,5.5,${region},Educación,Enseñanza. DOCUMENTOS REQUERIDOS: [OBLIGATORIO] Certificado,https://example.com/becas/csv`;

function verifyEncoding() {
  const port = process.env.LIVE_POSTGRES_PORT;
  const bin = process.env.LIVE_POSTGRES_BIN;
  if (!port || !bin) throw new Error('Run the isolated PostgreSQL browser verifier.');
  const sql = "SELECT count(*) FROM becas WHERE encode(convert_to(nombre,'UTF8'),'hex') ~ 'c383c2|c383e2|c382c2'; SELECT count(*) FROM instituciones WHERE encode(convert_to(nombre,'UTF8'),'hex') ~ 'c383c2|c383e2|c382c2';";
  const output = execFileSync(join(bin, 'psql.exe'), ['-h', '127.0.0.1', '-p', port, '-U', 'browser_verify',
    '-d', 'browser_profile', '-v', 'ON_ERROR_STOP=1', '-t', '-A', '-c', sql], { encoding: 'utf8' });
  expect(output.trim().split(/\s+/)).toEqual(['0', '0']);
  const hex = Buffer.from(name, 'utf8').toString('hex');
  const stored = execFileSync(join(bin, 'psql.exe'), ['-h', '127.0.0.1', '-p', port, '-U', 'browser_verify',
    '-d', 'browser_profile', '-v', 'ON_ERROR_STOP=1', '-t', '-A', '-c',
    `SELECT encode(convert_to(nombre,'UTF8'),'hex') FROM becas WHERE nombre=convert_from(decode('${hex}','hex'),'UTF8')`], { encoding: 'utf8' });
  expect(stored.trim()).toBe(hex);
}

async function upload(page: Page, csv: string, status: number) {
  await page.getByRole('button', { name: 'Importar CSV', exact: true }).click();
  await page.getByLabel('Archivo CSV de becas').setInputFiles({ name: 'becas-utf8.csv', mimeType: 'text/csv', buffer: Buffer.from(csv, 'utf8') });
  const completed = page.waitForResponse(response => response.url().endsWith('/api/becas/importar-csv') && response.request().method() === 'POST');
  await page.getByRole('dialog').getByRole('button', { name: 'Importar', exact: true }).click();
  const response = await completed;
  expect(response.status()).toBe(status);
  await expect(page.getByRole('dialog').getByRole('button', { name: 'Cerrar', exact: true })).toBeVisible();
  verifyEncoding();
  const result = await response.json();
  await page.getByRole('dialog').getByRole('button', { name: 'Cerrar', exact: true }).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
  return result;
}

test('CSV real crea actualiza sin duplicar y rechaza filas inválidas con rollback y UTF-8 intacto', async ({ page }) => {
  const api = process.env.LIVE_API_URL;
  if (!api) throw new Error('Use infra/verify-profile-browser.ps1');
  await page.goto('/login');
  await page.getByLabel('Correo electrónico').fill('admin@becasfind.cl');
  await page.getByLabel('Contraseña', { exact: true }).fill('admin123');
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
  await expect(page).not.toHaveURL(/\/login$/);
  const token = await page.evaluate(() => localStorage.getItem('token'));
  const headers = { Authorization: `Bearer ${token}` };
  await page.goto('/admin/becas');
  const created = await upload(page, `${header}\n${row(name)}`, 200);
  expect(created.data).toMatchObject({ creadas: 1, actualizadas: 0, errores: 0 });
  await expect(page.getByText(name, { exact: true })).toBeVisible();
  const updated = await upload(page, `${header}\n${row(name, '250000')}`, 200);
  expect(updated.data).toMatchObject({ creadas: 0, actualizadas: 1, errores: 0 });
  let listing = await page.request.get(`${api}/api/becas/administracion?query=${encodeURIComponent(name)}`, { headers });
  let records = (await listing.json()).data.content;
  expect(records).toHaveLength(1);
  expect(records[0].montoCobertura).toBe('250000');
  const before = await page.request.get(`${api}/api/becas/administracion`, { headers });
  const count = (await before.json()).data.totalElements;
  const rejected = await upload(page, `${header}\n${row('CSV debe revertirse real')}\n${row('CSV inválida real', '100000', 'NO_EXISTE')}`, 200);
  expect(rejected.data.creadas).toBe(0);
  expect(rejected.data.actualizadas).toBe(0);
  expect(rejected.data.errores).toBeGreaterThan(0);
  expect(rejected.data.mensajesError.join(' ')).toContain('región no encontrada');
  listing = await page.request.get(`${api}/api/becas/administracion?query=CSV%20debe%20revertirse%20real`, { headers });
  records = (await listing.json()).data.content;
  expect(records).toHaveLength(0);
  const after = await page.request.get(`${api}/api/becas/administracion`, { headers });
  expect((await after.json()).data.totalElements).toBe(count);
});
