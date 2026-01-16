// API Configuration
// Uses environment variables in production, falls back to localhost for development
// 
// VITE_API_URL can be:
// - Empty string '' = Use same origin as frontend (recommended for Render single-service)
// - Full URL = Use specific backend URL (for separate frontend/backend deployments)
// - Undefined = Defaults to http://localhost:5000 for local development

const apiUrlFromEnv = import.meta.env.VITE_API_URL;

export const API_URL = apiUrlFromEnv !== undefined 
  ? apiUrlFromEnv  // Use whatever is set (even empty string)
  : 'http://localhost:5000';  // Default for local dev

// Helper function to build API endpoint URLs
export const apiUrl = (endpoint) => `${API_URL}${endpoint}`;

export default API_URL;
