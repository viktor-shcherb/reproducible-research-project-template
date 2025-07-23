#!/bin/bash
set -e

echo "Compiling dependencies inside Docker environment..."
docker-compose run --rm deps

echo "Rebuilding Docker Compose services..."
docker-compose build

echo "Restarting Docker Compose services..."
docker-compose up -d

echo "✅    Dependencies synced and Docker Compose environment updated."
