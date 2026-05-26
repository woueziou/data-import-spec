# Step 6 — Define Canonical Naming and Typing Rules

## What this step is

Before building the final handoff pack, define one consistent set of rules
that applies to every source. These rules resolve the small inconsistencies
that otherwise turn into parser bugs later.

## Why it matters

Without canonical rules, each source ends up with its own conventions. You
get `created_at` in one artifact, `createDate` in another, and `date_creation`
in a third. Cross-source reasoning becomes painful.

## Rules to define

### Date and time

- Always normalize timestamps to UTC.
- Use ISO 8601 format in artifacts: `2024-01-15T08:30:00Z`
- Define a canonical parser for each date format you observe in the sources:
  `YYYYMMDD`, `DD/MM/YYYY`, `MM-DD-YY`, Unix epoch, etc.

### Booleans

- Canonical value: `true` / `false`
- Map source representations: `"Y"/"N"`, `"1"/"0"`, `"yes"/"no"`, `"TRUE"/"FALSE"`, `1/0`

### Null vs empty

- Empty string `""` and the string `"null"` or `"N/A"` are not the same as a missing value.
- Define which source representations become NULL in the normalized layer.
- Recommended: treat `""`, `"null"`, `"NULL"`, `"N/A"`, `"NA"`, `"none"` as NULL.

### Numbers and currencies

- Strip currency symbols and thousand separators before parsing.
- Define the base unit and rounding expectations.
- Record the canonical currency separately when currency values appear.

### Enums

- Define a canonical vocabulary per enum type.
- Document the mapping from each source representation to the canonical value.
- Preserve the original raw value in evidence notes when helpful.

### Identifiers

- Preserve source IDs as separate fields.
- Create a canonical ID only when the evidence supports it.
- Record low-confidence identifier joins explicitly.

### Text encoding

- Normalize to UTF-8.
- Strip control characters.
- Define sensible max lengths for downstream implementations.

## Output of this step

A `canonical-rules.md` file you'll reference when designing the future parser
implementation.
