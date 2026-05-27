# Step 9 — Validate with Downstream Consumers

## What this step is

Before finalizing your schema and parser design, you talk to the people
or systems that will use the data. You show them what you've found and ask
whether it meets their needs.

## Why it matters

It is easy to over-optimize for ingestion convenience and under-optimize
for the downstream uses the data will serve. A schema that preserves the data
but cannot support the intended parser behavior or consumer expectations is a
bad schema.

Do this step early — not after you've built everything.

## Who the consumers are

| Consumer type | What they need |
|---------------|---------------|
| Reporting / BI | Aggregatable fields, consistent types, date dimensions |
| Operational lookup | Stable identifiers and predictable field semantics |
| Audit / compliance | Full history, timestamps, provenance notes |
| ML / feature engineering | Numeric features, no nulls, normalized values |
| Search | Full-text fields, denormalized labels |
| API / product | Specific fields by entity, consistent naming |

## What to validate

For each consumer:

1. **Can they get the data they need?** Are the fields they require present
   in your schema?

2. **Is the granularity right?** Do they need one row per event, or one row
   per entity with the latest state?

3. **Are the types right?** Does a BI tool expect ISO dates? Does a numeric
   model expect no string nulls?

4. **Are identifiers compatible?** Can they join your data to their existing
   data using the IDs you've chosen?

5. **Is the update strategy right?** Do they need the latest snapshot, the
   full history, or a change feed?

## Output of this step

- A consumer requirements table: one row per consumer, columns for each
  requirement
- A gap analysis: requirements that your current schema doesn't yet satisfy
- Updates to the handoff layer plan from step 5
