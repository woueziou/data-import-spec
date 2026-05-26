# Step 8 — Detect Evolution and Drift

## What this step is

Undocumented sources change without notice. A field disappears. A new field
appears. A date format changes. An enum gets a new value. You define a drift
plan so these changes are caught before they invalidate the parser design.

## Why it matters

If you do not plan for drift, you find out about it when:
- a field that used to be present is now missing
- a normalization rule starts producing wrong values
- a consumer says the outputs no longer match expectations

Planning for drift early means you can react before the handoff becomes stale.

## What to detect

| Change type | Risk level |
|-------------|-----------|
| New field appears | Low |
| Field disappears | High |
| Field type changes (e.g. string → integer) | High |
| Nullable changes | Medium |
| New enum value appears | Medium |
| Date format changes | High |
| Column widths change (fixed-width) | Critical |
| Record count drops significantly | Medium |
| Null rate increases for a previously dense field | Medium |

## How to plan drift detection

On each new batch of data:

1. Re-profile a representative sample
2. Compare the observed structure against the stored reference
3. Record the differences in a diff report
4. Classify changes as breaking, warning, or informational
5. Decide whether the reference artifacts need to be updated

## What counts as breaking

- A field that was expected is now missing
- A field's type is incompatible with the stored type
- Column boundaries shift (fixed-width)
- A required field now contains nulls

## Output of this step

- A drift detection plan
- A schema versioning policy
- A diff report format for breaking and non-breaking changes
