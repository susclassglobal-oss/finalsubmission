// API Configuration
// Uses environment variables in production, falls back to localhost for development
// 
// VITE_API_URL can be:
// - Empty string '' = Use same origin as frontend (recommended for Docker/Render single-service)
// - Full URL = Use specific backend URL (for separate frontend/backend deployments)
// - Undefined/missing = Defaults to http://localhost:5000 for local development

const apiUrlFromEnv = import.meta.env.VITE_API_URL;

// Check if VITE_API_URL is explicitly set (including empty string)
// In Vite, missing env vars are undefined, empty string means "use same origin"
export const API_URL = typeof apiUrlFromEnv === 'string'
  ? apiUrlFromEnv  // Use whatever is set (empty string = same origin)
  : 'http://localhost:5000';  // Default for local dev when not set

// Debug log in development
if (import.meta.env.DEV) {
  console.log('API_URL configured as:', API_URL || '(same origin)');
}

// Helper function to build API endpoint URLs
export const apiUrl = (endpoint) => `${API_URL}${endpoint}`;

export default API_URL;
