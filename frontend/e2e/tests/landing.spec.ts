// CP-60: Landing Page se renderiza correctamente
import { test, expect } from '@playwright/test';

test('CP-60: Landing Page muestra hero, features y footer', async ({ page }) => {
  await page.goto('/');
  
  // Hero section
  await expect(page.locator('text=Encuentra la beca')).toBeVisible({ timeout: 5000 });
  
  // Feature cards
  await expect(page.locator('text=Perfil Personalizado')).toBeVisible();
  await expect(page.locator('text=Cobertura Nacional')).toBeVisible();
  
  // Navbar with public links
  await expect(page.locator('text=Ingresar').first()).toBeVisible();
  await expect(page.locator('text=Registrarse').first()).toBeVisible();
  
  // Footer
  await expect(page.locator('text=BecasFind').first()).toBeVisible();
});
