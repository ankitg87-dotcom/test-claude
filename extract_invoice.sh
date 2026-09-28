#!/usr/bin/env bash
# Send an invoice PDF to Landing AI ADE extract with the generic invoice schema.
# Test use only. The API key is read from LANDINGAI_API_KEY and never stored.
#
# Usage: LANDINGAI_API_KEY=... ./extract_invoice.sh <invoice.pdf> [output.json]
set -euo pipefail

pdf="${1:?usage: $0 <invoice.pdf> [output.json]}"
out="${2:-out/extraction.json}"
schema="$(dirname "$0")/invoice_schema.json"
field="${ADE_FILE_FIELD:-markdown}"

: "${LANDINGAI_API_KEY:?set LANDINGAI_API_KEY}"
[ -f "$pdf" ] || { echo "no such file: $pdf" >&2; exit 1; }

mkdir -p "$(dirname "$out")"

status=$(curl -sS -o "$out" -w '%{http_code}' -X POST 'https://api.va.landing.ai/v1/ade/extract' \
  -H "Authorization: Bearer ${LANDINGAI_API_KEY}" \
  -F "${field}=@${pdf};type=application/pdf" \
  -F "schema=<${schema}" \
  -F 'model=extract-latest')

echo "HTTP ${status} -> ${out}"
[ "$status" = 200 ]
