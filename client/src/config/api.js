// API Configuration
// Uses environment variables in production, falls back to localhost for development
// Set VITE_API_URL in your deployment environment (e.g., Render)

export const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:5000';

// Helper function to build API endpoint URLs
export const apiUrl = (endpoint) => `${API_URL}${endpoint}`;

export default API_URL;
