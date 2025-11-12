#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="/opt/flask-auto-redeploy"  # Update path as needed
SERVICE_NAME="web"

cd "$PROJECT_DIR"
echo "$(date -Iseconds) Redeploying container..."

docker-compose build --pull "$SERVICE_NAME"
docker-compose up -d --no-deps --build "$SERVICE_NAME"

docker image prune -f
echo "$(date -Iseconds) Redeploy complete."
