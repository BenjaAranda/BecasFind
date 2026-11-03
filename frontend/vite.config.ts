import { defineConfig, loadEnv } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig(({ command, mode }) => {
  if (command === 'build') {
    const apiOrigin = (process.env.VITE_API_URL ?? loadEnv(mode, process.cwd(), 'VITE_').VITE_API_URL ?? '').trim()
    let valid = false
    try {
      const url = new URL(apiOrigin)
      valid = ['http:', 'https:'].includes(url.protocol) && [url.origin, url.origin + '/'].includes(apiOrigin)
    } catch { /* Invalid or missing origin is rejected before producing a bundle. */ }
    if (!valid) throw new Error('Configurar VITE_API_URL con un origen HTTP(S) válido antes de compilar el frontend.')
  }
  return {
  plugins: [tailwindcss(), react()],
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
      },
    },
  },
  }
})
