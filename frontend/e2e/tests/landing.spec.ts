// CP-60: Landing Page se renderiza correctamente
import { test, expect } from '@playwright/test';

test('CP-60: Landing Page muestra hero, features y footer', async ({ page }) => {
  await page.goto('/');
  
  // Hero section
  await expect(page.getByRole('heading', { level: 1 })).toContainText('estudiando');
  
  // Feature cards
  await expect(page.getByRole('heading', { name: 'Explora tus opciones', exact: true })).toBeVisible();
  await expect(page.getByRole('link', { name: 'Crear mi cuenta', exact: true })).toHaveAttribute('href', '/register');
  
  // Navbar with public links
  await expect(page.locator('text=Ingresar').first()).toBeVisible();
  await expect(page.locator('text=Registrarse').first()).toBeVisible();
  
  // Footer
  await expect(page.locator('text=BecasFind').first()).toBeVisible();
});
