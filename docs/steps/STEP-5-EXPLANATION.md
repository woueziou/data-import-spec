# Step 5 — Separate Storage into Layers

## What this step is

You don't go straight from raw files to a final database schema. Instead,
you design distinct storage layers, each with a clear responsibility.

## Why it matters

If you transform data immediately on ingestion and the transformation is
wrong, you lose the original. If you only store raw blobs, you can't query
efficiently. Layers give you the best of both.

## The three layers

### Raw Layer

**Purpose**: Preserve the original data exactly as received.

Store:
- The full original record (as a string or blob)
- Source name
- Ingestion timestamp
- Source record ID if one exists
- File name and batch ID

**Never transform here.** This is your audit trail and your fallback.

### Standardized Layer

**Purpose**: Clean, typed, normalized records you can query reliably.

Transform:
- Trim whitespace from all string fields
- Parse dates into ISO 8601 format
- Convert strings to numbers where appropriate
- Normalize enums to canonical values (e.g. "Y" / "YES" / "1" → `true`)
- Standardize units (e.g. all amounts in the same currency)
- Assign a canonical entity ID

**This layer is where your provisional schema lives in practice.**

### Serving Layer

**Purpose**: Optimized, purpose-specific models built on top of the
standardized layer.

Examples:
- Analytics tables (wide, denormalized, fast to aggregate)
- Operational lookup tables (indexed by ID, fast single-record reads)
- Search documents (flat, text-optimized)
- Feature tables for ML (numeric, no nulls, normalized)
- Audit/history tables (append-only, timestamped)

**Build serving layer tables only when you know the use case.** Don't
build them speculatively.

## Output of this step

- A diagram or description of your three layers
- A storage definition for the raw and standardized layers
- A list of serving layer candidates for later

Only generate SQL if the user explicitly asks for SQL.
