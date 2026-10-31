import { fileURLToPath } from 'node:url';
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e/tests',
  timeout: 30000,
  expect: { timeout: 10000 },
  fullyParallel: false,
  retries: 0,
  reporter: [['html', { outputFolder: 'playwright-report' }], ['list']],
  use: {
    baseURL: 'http://127.0.0.1:5198',
    headless: true,
    viewport: { width: 1280, height: 720 },
  },
  webServer: { cwd: fileURLToPath(new URL('.', import.meta.url)), command: 'node node_modules/vite/bin/vite.js preview --host 127.0.0.1 --port 5198 --strictPort', url: 'http://127.0.0.1:5198', reuseExistingServer: false },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
  ],
});
