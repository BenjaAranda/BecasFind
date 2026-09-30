import {contrastFailures} from '../helpers/contrast';
import { test, expect } from '@playwright/test';

const id = '00000000-0000-4000-8000-000000000001';
const summary = { idBeca: id, nombre: 'Beca de educación', descripcionCorta: 'Apoyo de matrícula.', estadoActiva: true, fechaCierrePostulacion: '2030-12-31', nombreInstitucion: 'Universidad de prueba', nombreTipoBeca: 'Arancel', nombreRegion: 'Nacional' };
const routes = ['/', '/login', '/register', '/forgot-password', '/reset-password#token='+id, '/becas/'+id, '/explorar', '/perfil', '/favoritos', '/admin/becas', '/admin/usuarios'];
for (const width of [360,390,768,1440,720]) {
  test(`todos los flujos: teclado, etiquetas y reflujo a ${width}px${width===720 ? ' con ampliación 200%' : ''}`, async ({ page }) => {
    await page.setViewportSize({ width, height: 1000 });
    const errors: string[] = [];
    page.on('pageerror', error => errors.push(error.message));
    const token = `e30.${Buffer.from(JSON.stringify({sub:'admin@example.com',role:'ADMIN',nombre:'Admin',exp:4_000_000_000})).toString('base64url')}.test`;
    await page.route('**/api/**', route => {
      const path = new URL(route.request().url()).pathname;
      let data: unknown = [];
      if (path.endsWith('/buscar') || path.endsWith('/administracion')) data={content:[path.endsWith('/administracion') ? {...summary,idBeca:1,publicId:id,version:0}:summary],totalElements:1,totalPages:1,number:0};
      else if (path.endsWith('/becas/'+id)) data={...summary,institucion:{nombre:summary.nombreInstitucion},tipoBeca:{nombre:'Arancel'},regiones:[],documentosRequeridos:[],requisitoPerfil:null,urlOficial:'https://example.com/becas'};
      else if (path.endsWith('/favoritos')) data=[summary];
      else if (path.endsWith('/perfil')) data=null;
      else if (path.endsWith('/regiones')) data=[{idRegion:1,nombre:'Ñuble',abreviatura:'NB'}];
      else if (path.endsWith('/tipos-beca')) data=[{idTipoBeca:1,nombre:'Arancel'}];
      else if (path.endsWith('/instituciones')) data=[{idInstitucion:1,nombre:'Universidad de prueba'}];
      return route.fulfill({json:{status:200,data}});
    });
    for (const path of routes) {
      await page.goto('/');
      const publicRoute = ['/', '/login', '/register', '/forgot-password'].includes(path) || path.startsWith('/reset-password') || path.startsWith('/becas/');
      await page.evaluate(value => value ? localStorage.setItem('token',value) : localStorage.removeItem('token'), publicRoute ? '' : token);
      await page.goto(path);
      await expect(page.locator('main')).toBeVisible();
      if (width===720) await page.evaluate(() => {document.documentElement.style.zoom='2';});
      await page.waitForTimeout(200);
      const problems = await page.evaluate(() => {
        const visible=(e:Element) => e.getBoundingClientRect().width>0 && e.getBoundingClientRect().height>0;
        return {
          overflow: document.documentElement.scrollWidth > window.innerWidth+2,
          unnamed: [...document.querySelectorAll('button,input:not([type=hidden]),select,textarea')].filter(visible).filter(e=>!e.getAttribute('aria-label')&&!e.getAttribute('aria-labelledby')&&!(e as HTMLInputElement).labels?.length&&!(e.textContent||'').trim()).map(e=>e.outerHTML.slice(0,150)),
          main: document.querySelectorAll('main').length,
        };
      });
      expect(problems, path).toEqual({overflow:false,unnamed:[],main:1});
      expect(await contrastFailures(page),path).toEqual([]);
      if(path==='/admin/becas') await expect(page.getByRole('link',{name:'Ver detalle de Beca de educación'})).toHaveAttribute('href','/becas/'+id);
      await page.screenshot({path:test.info().outputPath(`route-${path.split('#')[0].replaceAll('/','_')}-${width}.png`),fullPage:true});
      await page.keyboard.press('Tab');
      expect(await page.evaluate(()=>document.activeElement!==document.body),path).toBe(true);
      await page.keyboard.press('Enter');
      expect(errors,path).toEqual([]);
    }
  });
}
