# Landing AI invoice extraction (test)

Sends an invoice PDF straight to Landing AI's ADE extract endpoint with a generic invoice schema. Plain bash + curl, no other dependencies. Test use only.

```
LANDINGAI_API_KEY=... ./extract_invoice.sh path/to/invoice.pdf out/extraction.json
```

- `invoice_schema.json` is a generic invoice schema (header, seller, buyer, ship-to, line items, tax breakdown, totals, payment info). Nothing is required, so fields missing from a given invoice come back null.
- The PDF is uploaded in the `markdown` form field by default. Set `ADE_FILE_FIELD=document` to use a different field name.
- Keep the API key in the environment. PDFs and outputs under `out/` are git-ignored.
