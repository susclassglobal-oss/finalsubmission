# Environment Variables Setup Guide

This document lists all the environment variables that need to be configured for deployment.

## Required Variables (Must Be Set)

### Database
- `DATABASE_URL` - PostgreSQL connection string (Neon format: `postgresql://user:pass@host/db?sslmode=require`)

### Authentication
- `JWT_SECRET` - Secret key for JWT token signing (Render can auto-generate this)
- `ADMIN_EMAIL` - Admin account email address
- `ADMIN_PASSWORD` - Admin account password

### Cloudinary (Media Upload)
- `CLOUDINARY_CLOUD_NAME` - Your Cloudinary cloud name
- `CLOUDINARY_API_KEY` - Cloudinary API key
- `CLOUDINARY_API_SECRET` - Cloudinary API secret

### SMTP (Email Notifications)
- `SMTP_HOST` - SMTP server hostname (default: `smtp.gmail.com`)
- `SMTP_PORT` - SMTP port (default: `587`)
- `SMTP_USER` - Email address for sending notifications
- `SMTP_PASSWORD` or `SMTP_APP_PASSWORD` - App-specific password for email

## Optional Variables

### URLs (For Single-Service Deployment on Render)
- `FRONTEND_URL` - Used by backend to generate email links (Render will auto-provide `RENDER_EXTERNAL_URL`)
- `VITE_API_URL` - API URL for frontend. **Leave empty or unset** to use same origin (recommended)

**For Render deployment**: You only need to set `FRONTEND_URL` to your Render URL (e.g., `https://your-app.onrender.com`). The `VITE_API_URL` can be left empty since frontend and backend run on the same server.

### Application
- `NODE_ENV` - Set to `production` for deployment (default in Docker)
- `PORT` - Server port (default: `5000`)
- `ENABLE_DEV_ENDPOINTS` - Set to `true` to enable dev endpoints in production

## Docker Build Arguments

When building the Docker image, you can pass:
```bash
docker build --build-arg VITE_API_URL=https://your-api-url.com .
```

## Render.com Setup

1. Create a new Web Service
2. Connect to GitHub repository: `susclassglobal-oss/submission`
3. Select the `main` branch
4. Set environment to Docker
5. Configure all required environment variables above
6. Set `FRONTEND_URL` to your Render service URL (e.g., `https://your-app.onrender.com`)
7. Leave `VITE_API_URL` **empty** (frontend will use same origin)
8. Deploy!

**Note**: Render automatically provides `RENDER_EXTERNAL_URL` which the backend will use as fallback for `FRONTEND_URL` if not set.

## Local Development

Create a `.env` file in the `backend/` directory:

```env
DATABASE_URL=your_neon_connection_string
JWT_SECRET=your_local_secret_key
ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD=your_admin_password

CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret

SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your_email@gmail.com
SMTP_PASSWORD=your_app_password
```

⚠️ **Never commit `.env` files to git!**
