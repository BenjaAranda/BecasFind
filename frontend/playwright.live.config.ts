import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e/live',
  workers: 1,
  retries: 0,
  reporter: 'list',
  use: { baseURL: process.env.LIVE_FRONTEND_URL, ...devices['Desktop Chrome'] },
});
