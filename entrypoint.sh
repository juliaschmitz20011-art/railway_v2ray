#!/bin/bash
set -e

UUID="${UUID:-bd522e31-a3bb-4aa4-a5cb-841352b68b9b}"
PORT="${PORT:-443}"
REALITY_PUBLIC_KEY="${REALITY_PUBLIC_KEY:-}"
REALITY_SHORT_ID="${REALITY_SHORT_ID:-}"
REALITY_SERVER_NAME="${REALITY_SERVER_NAME:-example.com}"

if [ -z "$REALITY_PUBLIC_KEY" ] || [ -z "$REALITY_SHORT_ID" ]; then
  echo "ERROR: REALITY_PUBLIC_KEY and REALITY_SHORT_ID must be provided as env variables."
  sleep 100000
fi

cat xray_config.template.json   | sed "s|{{UUID}}|${UUID}|g"   | sed "s|{{PORT}}|${PORT}|g"   | sed "s|{{REALITY_PUBLIC_KEY}}|${REALITY_PUBLIC_KEY}|g"   | sed "s|{{REALITY_SHORT_ID}}|${REALITY_SHORT_ID}|g"   | sed "s|{{REALITY_SERVER_NAME}}|${REALITY_SERVER_NAME}|g"   > /app/config.json

/usr/local/bin/xray -c /app/config.json
