# Step 6 — Define Canonical Naming and Typing Rules

## What this step is

Before building the standardized layer, you define a single set of rules
that apply to every source. These rules resolve all the small inconsistencies
that will otherwise accumulate into a mess.

## Why it matters

Without canonical rules, each source ends up with its own conventions. You
get `created_at` in one table, `createDate` in another, and `date_creation`
in a third. Queries across sources become painful.

## Rules to define

### Date and time

- Always store timestamps as UTC.
- Use ISO 8601 format in transit: `2024-01-15T08:30:00Z`
- In the database: `TIMESTAMPTZ` for timestamps, `DATE` for date-only values
- Define a canonical parser for each date format you observe in the sources:
  `YYYYMMDD`, `DD/MM/YYYY`, `MM-DD-YY`, Unix epoch, etc.

### Booleans

- Canonical value: `true` / `false`
- Map source representations: `"Y"/"N"`, `"1"/"0"`, `"yes"/"no"`, `"TRUE"/"FALSE"`, `1/0`

### Null vs empty

- Empty string `""` and the string `"null"` or `"N/A"` are not the same as SQL NULL.
- Define which source representations become NULL in the standardized layer.
- Recommended: treat `""`, `"null"`, `"NULL"`, `"N/A"`, `"NA"`, `"none"` as NULL.

### Numbers and currencies

- Strip currency symbols and thousand separators before parsing.
- Define the base unit: store monetary values as integers in cents (or the
  smallest unit) to avoid floating-point errors, or use `NUMERIC(18,4)`.
- Define the canonical currency: store which currency alongside the amount.

### Enums

- Define a canonical vocabulary per enum type.
- Document the mapping from each source's representation to the canonical value.
- Store the canonical value in the standardized layer.
- Keep the original value in the raw layer.

### Identifiers

- Define an ID strategy: UUID v4 for system-generated IDs.
- Preserve source IDs as separate fields (e.g. `source_customer_id`).
- Create a canonical ID that is stable across sources for the same entity.

### Text encoding

- Normalize to UTF-8.
- Strip control characters.
- Define max lengths for VARCHAR fields.

## Output of this step

A `canonical-rules.md` file you'll reference when writing every parser
and transformation function.
