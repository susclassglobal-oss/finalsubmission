#!/bin/bash
# Render.com build script for Node.js runtime
# This builds the frontend and copies it to backend/public

echo "=== Building Frontend ==="
cd client
npm ci
VITE_API_URL="" npm run build

echo "=== Copying frontend to backend/public ==="
mkdir -p ../backend/public
cp -r dist/* ../backend/public/

echo "=== Installing Backend Dependencies ==="
cd ../backend
npm ci

echo "=== Build Complete ==="
ls -la public/
