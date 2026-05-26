# Step 1 — Inventory the Sources

## What this step is

Before touching the data itself, you need a complete map of every source:
where it comes from, how it arrives, how often, and how large it is.

This is your source catalog. Without it, you'll lose track of what you've
seen, duplicate work, or miss a source entirely.

## Why it matters

- Forces you to enumerate all inputs before making schema decisions.
- Reveals delivery patterns (batch vs. stream) that affect ingestion design.
- Identifies trust levels: internal system exports are reliable; third-party
  dumps are not.
- Helps determine the likely nature of the data before parser design starts.
- Creates a reference document you'll update throughout the project.

## How to do it

For each file or feed you receive, fill in:

| Field | What to capture |
|-------|----------------|
| Source name | A short stable identifier you'll use throughout, e.g. `billing_export` |
| File name | The exact file name; it may contain dates, entity names, versions, or partition hints |
| Nature of data | What the data appears to represent, e.g. customers, orders, events, telemetry, ledger lines |
| Format | fixed-width, CSV, JSON, XML, binary, log line… |
| Delivery mode | manual drop, SFTP batch, API pull, email attachment… |
| Frequency | one-time, daily, per event… |
| Volume | approximate row count and file size |
| Ownership | who produces it; internal team or external vendor |
| Trust level | high (own system), medium (partner), low (scrape/unknown) |
| Sample file path | where you saved a representative sample |

## Output of this step

- `source-catalog.md` or a spreadsheet with one row per source
- A `samples/` folder containing at least one raw file per source, untouched
- A note of how many rows the submitted sample contains, since parser
  confidence depends on sample size
- A note of what the file name itself suggests about the data, such as date,
  entity, region, partition, or version
- A confidence rating for the inferred nature of the data, plus open questions
  if the classification is weak

## Important rule

Never modify the original files. Save a copy and work from that.

If the sample is too ambiguous to classify confidently, stop and ask the user
for additional context before locking in downstream assumptions.
