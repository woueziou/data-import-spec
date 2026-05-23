# Example Target Repo

This folder is a sandbox target for the DMP framework.

## Contents

- `incoming/vendor-drop/` sample raw data
- `notes/` space for intake notes and handoff artifacts

## Try it

Use `/dmp-intake` and point it at:

- `incoming/vendor-drop/customers_2026-05.csv`
- `incoming/vendor-drop/orders_2026-05.log`

Start the workflow state folder with:

```bash
./dmp/bin/start-workflow.sh order_file "Order file parser"
```

The handoff files live in `_dmp_out/order_file/`.
