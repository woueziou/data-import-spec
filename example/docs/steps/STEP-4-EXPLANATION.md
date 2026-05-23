# Step 4 — Identify Entities and Relationships Across Sources

## What this step is

Now that you have per-source schemas, you look across all sources to find
the real business objects they describe. This is where you move from
"file structure" to "domain structure".

## Why it matters

Multiple sources often describe the same entity with different names, ID
formats, or granularity. Without this step, you end up with redundant tables,
broken joins, and confusion about which source is authoritative.

## What to look for

### Shared identifiers

Look for fields that could be foreign keys across sources:
- Same values appearing in multiple sources (e.g. `customer_id` in orders
  and in billing)
- Same format even with different names (`cust_no` vs `customer_code`)
- Numeric vs string encoding of the same ID

### Common entity types

Watch for these in any business dataset:

| Entity | Typical identifiers |
|--------|-------------------|
| Person / User / Customer | id, email, phone, national ID |
| Order / Transaction | order number, reference, invoice number |
| Product / SKU | product code, barcode, SKU |
| Location | address, geo coordinates, branch code |
| Event / Activity | timestamp + actor + action |
| Device / Asset | serial number, MAC address, hardware ID |

### Relationship patterns

- **One-to-many**: one customer has many orders
- **Many-to-many**: many products appear in many orders (via a line-item table)
- **Self-referencing**: an employee has a manager who is also an employee

### Duplicate concepts

Watch for the same concept appearing under different names:
- `status` in one source and `state` in another — might be the same field
- `amount` vs `total` vs `value` — may or may not refer to the same thing

## Output of this step

- Entity list: the distinct business objects found across all sources
- A relationship diagram (even a rough sketch)
- A join map: which fields in which sources link to which entity
