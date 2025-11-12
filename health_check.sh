#!/usr/bin/env bash
set -euo pipefail
URL="http://127.0.0.1:5000/health"
TIMEOUT=5

status_code=$(curl -sS -o /dev/null -w "%{http_code}" --max-time "${TIMEOUT}" "${URL}" || echo "000")

if [ "$status_code" != "200" ]; then
  echo "$(date -Iseconds) HEALTHCHECK FAILED: status=$status_code" >&2
  exit 1
fi

echo "$(date -Iseconds) HEALTHCHECK OK"
