import { test, expect } from '@playwright/test';
import { execFileSync } from 'node:child_process';
import { readFileSync } from 'node:fs';
import { join, resolve } from 'node:path';

test('el histórico completo se archiva sin publicar ni sobrescribir y repetir la carga no duplica', async ({ page }) => {
  const api = process.env.LIVE_API_URL;
  const port = process.env.LIVE_POSTGRES_PORT;
  const bin = process.env.LIVE_POSTGRES_BIN;
  if (!api || !port || !bin) throw new Error('Use the isolated PostgreSQL browser verifier.');
  test.setTimeout(90_000);
  const sql = (command: string) => execFileSync(join(bin, 'psql.exe'), ['-h', '127.0.0.1', '-p', port,
    '-U', 'browser_verify', '-d', 'browser_profile', '-v', 'ON_ERROR_STOP=1', '-t', '-A', '-c', command],
    { encoding: 'utf8', env: { ...process.env, PGCLIENTENCODING: 'UTF8' } }).trim();
  const before = sql('select coalesce(json_agg(b order by id_beca)::text,\'[]\') from becas b');
  const originalIds = JSON.parse(before).map((r: { id_beca: number }) => r.id_beca);
  const publicBefore = await (await page.request.get(`${api}/api/becas?size=100`)).json();
  const catalogBefore = await (await page.request.get(`${api}/api/instituciones`)).json();
  const corpus = resolve('../documentacion/auditoria_corpus/procesados');
  const count = JSON.parse(readFileSync(join(corpus, 'consolidacion.json'), 'utf8')).candidates;
  const csv = readFileSync(join(corpus, 'archivo_administrativo.csv'));
  await page.goto('/login');
  await page.getByLabel('Correo electrónico').fill('admin@becasfind.cl');
  await page.getByLabel('Contraseña', { exact: true }).fill('admin123');
  await page.getByRole('button', { name: 'Ingresar', exact: true }).click();
  await expect(page).not.toHaveURL(/\/login$/);
  const token = await page.evaluate(() => localStorage.getItem('token'));
  const headers = { Authorization: `Bearer ${token}` };
  const upload = async () => {
    const response = await page.request.post(`${api}/api/becas/importar-csv`, {
      headers, multipart: { file: { name: 'historico.csv', mimeType: 'text/csv', buffer: csv } },
    });
    expect(response.status()).toBe(200);
    return (await response.json()).data;
  };
  const first = await upload();
  expect(first.errores).toBe(0);
  expect(first.actualizadas).toBe(0);
  expect(first.creadas + first.omitidas).toBe(count);
  expect(sql(`select json_agg(b order by id_beca)::text from becas b where id_beca in (${originalIds.join(',')})`)).toBe(before);
  expect((await upload())).toMatchObject({ creadas: 0, actualizadas: 0, omitidas: count, errores: 0 });
  const publicAfter = await (await page.request.get(`${api}/api/becas?size=100`)).json();
  expect(publicAfter.data).toEqual(publicBefore.data);
  const catalogAfter = await (await page.request.get(`${api}/api/instituciones`)).json();
  expect(catalogAfter.data).toEqual(catalogBefore.data);
  const candidate = JSON.parse(sql("select row_to_json(b)::text from becas b where not estado_activa and descripcion_larga like '%candidato %' limit 1"));
  expect((await page.request.get(`${api}/api/becas/${candidate.public_id}`)).status()).toBe(404);
  expect(sql("select count(*) from becas where encode(convert_to(nombre,'UTF8'),'hex') ~ 'c383c2|c383e2|c382c2'")).toBe('0');
  await page.goto('/admin/becas');
  await page.getByRole('textbox', { name: 'Buscar beca' }).fill(candidate.nombre);
  const row = page.getByRole('row').filter({ hasText: candidate.nombre }).first();
  await expect(row).toBeVisible();
  await expect(row.getByText('Inactiva', { exact: true })).toBeVisible();
  await expect(row.getByRole('link', { name: `Ver detalle de ${candidate.nombre}` })).toHaveCount(0);
  await expect(row.getByRole('button', { name: `Editar ${candidate.nombre}`, exact: true })).toBeVisible();
});
