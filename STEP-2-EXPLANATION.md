# Step 2 — Profile the Raw Data

## What this step is

You open the actual files and inspect what is really inside them — not what
you expect, but what is actually there. This is data profiling.

## Why it matters

Field names lie. A column called `amount` might contain strings like "N/A",
or a column called `date` might have three different date formats depending
on the batch. You cannot design a schema from field names alone. You must
look at the values.

## What to inspect

For each column or field position, collect:

| Property | What to check |
|----------|--------------|
| Name / position | Column header or character offset |
| Value types observed | string, integer, decimal, boolean, date, empty |
| Null / empty rate | How often is this field blank or missing? |
| Distinct value count | Is this an enum (few values) or free text (many)? |
| Min / max length | For strings |
| Min / max value | For numbers |
| Format patterns | Dates: YYYYMMDD vs DD/MM/YYYY. IDs: numeric vs UUID |
| Anomalies | Values that don't fit the pattern |

## Special attention for fixed-width files

Fixed-width files have no delimiter. You must discover the column boundaries
yourself. Look for:
- Repeating column-width patterns across rows
- All-space padding on the right
- Runs of a specific character (like `0`) used as padding
- Header rows (if any) that label fields with consistent spacing

Start with a character-position frequency analysis: for each position, what
characters appear? Spaces always appearing in a position usually mean a
column boundary or padding zone.

## Output of this step

- A profile report per source: one row per field with all the properties above
- A list of anomalies and questions to resolve in step 7
