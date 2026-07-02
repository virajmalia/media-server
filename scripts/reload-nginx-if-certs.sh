#!/usr/bin/env bash
# Simple helper: check for Cloudflare origin cert files and reload nginx via docker compose.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CERT_DIR="$ROOT_DIR/data/ssl/jf.maliahome.org"

if [[ -f "$CERT_DIR/fullchain.pem" && -f "$CERT_DIR/privkey.pem" ]]; then
  echo "Found origin certs in $CERT_DIR — reloading nginx stack"
  docker compose up -d nginx
  echo "nginx reloaded."
else
  echo "Missing certs in $CERT_DIR"
  echo "Place fullchain.pem and privkey.pem there (see data/README-cloudflare-origin.md)"
  exit 1
fi
