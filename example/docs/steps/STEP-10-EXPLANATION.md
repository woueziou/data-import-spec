# Step 10 — Design the Database Model Pragmatically

## What this step is

You now have enough information to design the actual database. The goal is
a model that is faithful to the data, usable by consumers, and flexible
enough to evolve.

## Why it matters

Database design is hard to undo. Getting the core model right now saves
costly migrations later.

## Core design decisions

### 1. Which database?

| Use case | Good fit |
|----------|----------|
| Stable entities with relations | PostgreSQL, MySQL |
| Large volumes of append-only events | TimescaleDB, ClickHouse, BigQuery |
| Flexible/unknown schema | MongoDB (use carefully) |
| Mixed structured + blob | PostgreSQL with JSONB |

For most cases with undocumented sources: **PostgreSQL with JSONB columns**
for the unstable parts is a pragmatic default.

### 2. Relational tables for stable entities

Use normalized relational tables for entities that:
- Have a stable, well-understood structure
- Are referenced by other entities (foreign keys)
- Are queried individually by ID

### 3. JSONB column for unstable attributes

For fields that:
- Are poorly understood
- Vary across records
- Are not yet needed by any consumer

Store them in a `metadata JSONB` column alongside the typed columns.
This gives you fidelity without schema churn.

### 4. Event tables for temporal data

For activities, transactions, and state changes, use an event table:
- `entity_id` (FK to the entity)
- `event_type` (what happened)
- `occurred_at` (when)
- `payload JSONB` (event details)

This is append-only and naturally supports history.

### 5. Indexes

Add indexes for:
- All foreign keys
- Fields used in WHERE clauses frequently
- Fields used for ordering in time-series queries
- Full-text search fields (if using PostgreSQL `tsvector`)

## Output of this step

- Final DDL for all tables (raw, standardized, serving layer)
- Index definitions
- Foreign key constraints
- A brief justification for each major design decision
