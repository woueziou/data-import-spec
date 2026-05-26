# Step 12 — Iterate

## What this step is

The methodology is not a one-time waterfall. It's a loop. After your first
pass, you have a working system with gaps. You refine it as you learn more.

## Why it matters

With undocumented sources, you will not get everything right on the first pass.
That is expected. The goal of the first pass is to build something that works
well enough, captures the raw data safely, and can be improved.

## The iteration loop

```
New data arrives
      │
      ▼
Run drift detection (step 8)
      │
   No drift ──────────────────────────────────────────► Ingest normally
      │
   Drift detected
      │
      ▼
Assess: Breaking or non-breaking?
      │
 Non-breaking (new field, new enum value)
      │
      ▼
Update schema, data dictionary, quality rules
Ingest normally
      │
 Breaking (type change, field disappears, column shift)
      │
      ▼
Halt ingestion for this source
Investigate root cause
Update parser and transformation rules
Test on sample
Resume ingestion
```

## When to revisit earlier steps

| Trigger | Return to |
|---------|-----------|
| New source added | Step 1 |
| New consumer identified | Step 9 |
| Ambiguous field now understood | Step 7 |
| Enum gets a new value | Step 6 and 11 |
| Column boundaries shift | Step 2 and 3 |
| Schema version mismatch detected | Step 8 |
| Quality rule fires repeatedly | Step 11 (adjust rule or fix source) |

## Signs your schema is stabilizing

- Drift detection fires rarely
- Quality rules pass on >99% of records
- Consumers can get what they need without workarounds
- The data dictionary has mostly `confirmed` fields

## Output of this step

No new artifact. The output is the continuous improvement of all previous
artifacts.

---

## Summary: What you build in total

| Artifact | Step |
|----------|------|
| Source catalog | 1 |
| Sample corpus | 1 |
| Profile reports | 2 |
| Provisional schemas (versioned) | 3 |
| Entity and relationship map | 4 |
| Layer architecture | 5 |
| Canonical rules (`canonical.ts`) | 6 |
| Data dictionary | 7 |
| Drift detector | 8 |
| Consumer requirements table | 9 |
| Relational storage plan | 10 |
| Quality rule engine | 11 |
| Quarantine table | 11 |
