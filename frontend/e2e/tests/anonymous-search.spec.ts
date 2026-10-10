import {test,expect} from '@playwright/test';
const id='00000000-0000-4000-8000-000000000001';
const scholarship={idBeca:id,nombre:'Beca pública',descripcionCorta:'Apoyo de matrícula.',nombreInstitucion:'Institución de prueba',nombreTipoBeca:'Arancel',nombreRegion:'Nacional',fechaCierrePostulacion:'2030-12-31',estadoActiva:true};
for(const width of [360,1280]) test(`visita sin sesión a ${width}px busca y abre detalles sin pedir datos privados`,async({page})=>{
 await page.setViewportSize({width,height:900});
 const privateCalls:string[]=[];
 await page.route('**/api/**',route=>{
  const path=new URL(route.request().url()).pathname;
  if(/favoritos|perfil|recomendadas|administracion/.test(path)){privateCalls.push(path);return route.fulfill({status:401,json:{data:null}});}
  const data=path.endsWith('/buscar')?{content:[scholarship],totalElements:1,totalPages:1,number:0}:path.endsWith('/becas/'+id)?{...scholarship,descripcionLarga:'Información de prueba.',institucion:{nombre:scholarship.nombreInstitucion},tipoBeca:{nombre:'Arancel'},regiones:[],documentosRequeridos:[],requisitoPerfil:null,urlOficial:'https://example.com/becas'}:[];
  return route.fulfill({json:{status:200,data}});
 });
 await page.goto('/');
 await page.getByRole('link',{name:'Explorar becas',exact:true}).last().click();
 await expect(page).toHaveURL(/\/explorar$/);
 await expect(page.getByRole('button',{name:'Beca pública',exact:true})).toBeVisible();
 await expect(page.getByRole('button',{name:'Guardar en favoritos'})).toHaveCount(0);
 await page.getByRole('button',{name:'Beca pública',exact:true}).click();
 await expect(page).toHaveURL('/becas/'+id);
 await expect(page.getByRole('heading',{name:'Beca pública',exact:true})).toBeVisible();
 await page.goto('/explorar?mode=recomendar');
 await expect(page.getByRole('button',{name:'Beca pública',exact:true})).toBeVisible();
 expect(privateCalls).toEqual([]);
 expect(await page.evaluate(()=>localStorage.getItem('token'))).toBeNull();
 await page.getByRole('button',{name:'Recomendadas',exact:true}).click();
 await expect(page).toHaveURL(/\/login$/);
});
for(const path of ['/perfil','/favoritos','/admin/becas'])test(`sin sesión ${path} conserva protección`,async({page})=>{
 await page.goto(path);await expect(page).toHaveURL(/\/login$/);
});
