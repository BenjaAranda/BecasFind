import {contrastFailures} from '../helpers/contrast';
import {test,expect} from '@playwright/test';
test('contraste de texto visible en portada y formularios públicos',async({page})=>{
 for(const path of ['/', '/login', '/register', '/forgot-password']) {
  await page.goto(path);
  await expect(page.locator('main')).toBeVisible();
  const failures=await contrastFailures(page);
  expect(failures,path).toEqual([]);
 }
});
