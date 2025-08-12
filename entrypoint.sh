#!/bin/bash
set -e

# Required envs:
# UUID, REALITY_PUBLIC_KEY, REALITY_SHORT_ID, REALITY_SERVER_NAME (SNI), PORT

UUID="${UUID:-bd522e31-a3bb-4aa4-a5cb-841352b68b9b}"
PORT="${PORT:-443}"
REALITY_PUBLIC_KEY="${REALITY_PUBLIC_KEY:-}"
REALITY_SHORT_ID="${REALITY_SHORT_ID:-}"
REALITY_SERVER_NAME="${REALITY_SERVER_NAME:-example.com}"

if [ -z "$REALITY_PUBLIC_KEY" ] || [ -z "$REALITY_SHORT_ID" ]; then
  echo "ERROR: REALITY_PUBLIC_KEY and REALITY_SHORT_ID must be provided as env variables."
  echo "See README for generating Reality keypair."
  sleep 100000
fi

# generate config from template by simple replacements
cat xray_config.template.json \
  | sed "s|{{UUID}}|${UUID}|g" \
  | sed "s|{{PORT}}|${PORT}|g" \
  | sed "s|{{REALITY_PUBLIC_KEY}}|${REALITY_PUBLIC_KEY}|g" \
  | sed "s|{{REALITY_SHORT_ID}}|${REALITY_SHORT_ID}|g" \
  | sed "s|{{REALITY_SERVER_NAME}}|${REALITY_SERVER_NAME}|g" \
  > /app/config.json

echo "----- final config -----"
cat /app/config.json
echo "------------------------"

# run xray
/usr/local/bin/xray -c /app/config.json
