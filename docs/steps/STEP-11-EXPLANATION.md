# Step 11 — Add Data Quality Rules

## What this step is

Data quality rules are checks that run on every record, either at ingestion
or on a schedule, to catch problems before they propagate downstream.

## Why it matters

With undocumented sources, you will inevitably encounter:
- Duplicate records sent twice
- Required fields suddenly empty
- Values outside expected ranges
- Foreign keys pointing to nothing
- Enum values you've never seen before

Without quality rules, these silently corrupt your data. With rules, you
catch them and can route bad records into a documented review path.

## Types of rules

| Rule type | Example |
|-----------|---------|
| Required field | `customer_id` must not be null |
| Uniqueness | No two records with the same `transaction_id` |
| Valid range | `amount` must be between 0 and 10,000,000 |
| Enum constraint | `status` must be one of `active`, `inactive`, `suspended` |
| Referential integrity | `customer_id` must exist in the reference source |
| Format check | `email` must match email pattern |
| Duplicate detection | Same `transaction_id` + `date` seen before → flag as duplicate |
| Temporal sanity | `created_at` must not be in the future, must not be before 2000 |
| Null rate alert | If > 20% of records have null for a normally-dense field, alert |

## What to do with failing records

Don't silently drop them. Instead:

1. Write the failing record to a quarantine or review artifact
2. Record which rule(s) failed
3. Record the original raw content
4. Allow manual review and reprocessing

## Output of this step

- A quality rules definition
- A quarantine and review contract
- A validation approach description
