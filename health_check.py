#!/usr/bin/env python3
import requests, sys, time

URL = "http://127.0.0.1:5000/health"
TIMEOUT = 5

try:
    r = requests.get(URL, timeout=TIMEOUT)
    if r.status_code != 200:
        print(f"{time.strftime('%Y-%m-%dT%H:%M:%S')} HEALTHCHECK FAILED status={r.status_code}", file=sys.stderr)
        sys.exit(1)
except Exception as e:
    print(f"{time.strftime('%Y-%m-%dT%H:%M:%S')} HEALTHCHECK ERROR: {e}", file=sys.stderr)
    sys.exit(1)

print(f"{time.strftime('%Y-%m-%dT%H:%M:%S')} HEALTHCHECK OK")
