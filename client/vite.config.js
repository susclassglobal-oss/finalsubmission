import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  // Expose environment variables to the client
  define: {
    // This ensures VITE_API_URL is available at runtime
    'import.meta.env.VITE_API_URL': JSON.stringify(process.env.VITE_API_URL)
  },
  // Build configuration
  build: {
    outDir: 'dist',
    sourcemap: false
  },
  // Development server
  server: {
    port: 5173,
    host: true
  }
})
