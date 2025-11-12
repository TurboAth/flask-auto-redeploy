#!/usr/bin/env bash
set -euo pipefail

LOG="/var/log/flask_auto_health.log"
BASE_DIR="/opt/flask-auto-redeploy"
HEALTH="$BASE_DIR/health_check.sh"
REDEPLOY="$BASE_DIR/redeploy.sh"
LOCK="/tmp/flask_auto_watch.lock"

exec 9>"$LOCK"
if ! flock -n 9; then
  echo "$(date -Iseconds) Another check is running, exiting." >> "$LOG"
  exit 0
fi

if ! "$HEALTH" >> "$LOG" 2>&1; then
  echo "$(date -Iseconds) Health check failed. Redeploying..." | tee -a "$LOG"
  "$REDEPLOY" >> "$LOG" 2>&1 && echo "$(date -Iseconds) Redeploy done." >> "$LOG"
else
  echo "$(date -Iseconds) App healthy." >> "$LOG"
fi
