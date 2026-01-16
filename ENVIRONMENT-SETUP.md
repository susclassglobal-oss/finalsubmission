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

### Frontend URL
- `FRONTEND_URL` - Override frontend base URL for email links
- `VITE_API_URL` - API URL for frontend (set during Docker build)

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
6. Deploy!

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
