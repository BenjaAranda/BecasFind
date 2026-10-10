import {test,expect} from '@playwright/test';
test('visitante busca y consulta detalle con API real sin sesión',async({page,request})=>{
 const response=await request.post(process.env.LIVE_API_URL+'/api/becas/buscar',{data:{query:'Nuevo Milenio'}});
 expect(response.status()).toBe(200);
 const data=(await response.json()).data;
 expect(data.content.length).toBeGreaterThan(0);
 const scholarship=data.content.find((b:{nombre:string})=>b.nombre==='Beca Nuevo Milenio');
 expect(scholarship.idBeca).toMatch(/^[0-9a-f-]{36}$/);
 await page.goto('/explorar');
 await expect(page.getByRole('button',{name:'Beca Nuevo Milenio',exact:true})).toBeVisible();
 await expect(page.getByRole('button',{name:'Guardar en favoritos'})).toHaveCount(0);
 await page.getByRole('button',{name:'Beca Nuevo Milenio',exact:true}).click();
 await expect(page).toHaveURL('/becas/'+scholarship.idBeca);
 await expect(page.getByRole('heading',{name:'Beca Nuevo Milenio',exact:true})).toBeVisible();
 expect(await page.evaluate(()=>localStorage.getItem('token'))).toBeNull();
});
