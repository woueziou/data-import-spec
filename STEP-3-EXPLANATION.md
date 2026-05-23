# Step 3 — Build a Provisional Schema

## What this step is

Using the profiling results from step 2, you now formalize your best current
understanding of each source into a provisional schema. "Provisional" means
it will change — and that is expected.

## Why it matters

A written schema forces you to commit to specific types, nullability, and
cardinality. This creates a baseline you can compare future data against.
Without it, your understanding stays informal and inconsistent.

## Schema fields to define per column

| Property | Description |
|----------|-------------|
| fieldName | Canonical name you'll use (snake_case) |
| rawName | Original name or position in the source |
| inferredType | `string`, `integer`, `decimal`, `boolean`, `date`, `enum`, `json` |
| nullable | `true` / `false` / `unknown` |
| required | Whether it's ever missing in practice |
| exampleValues | 3–5 representative values from the real data |
| cardinality | `one` (scalar), `enum` (fixed set), `many` (high cardinality) |
| confidence | `high` / `medium` / `low` |
| assumption | What you're assuming that might be wrong |

## Confidence levels

- **High** — consistent across all samples, type is unambiguous
- **Medium** — mostly consistent but a few anomalies, or inferred from few samples
- **Low** — only seen in a few rows, format varies, or meaning is unclear

## Versioning

Name your schema file with a date: `schema-source-name-2024-01-15.json`.
When you update it, create a new file rather than overwriting. This gives
you a history of how your understanding evolved.

## Output of this step

One JSON or Markdown schema file per source, containing all fields.
