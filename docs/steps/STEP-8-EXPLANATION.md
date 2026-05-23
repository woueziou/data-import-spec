# Step 8 — Detect Evolution and Drift

## What this step is

Undocumented sources change without notice. A field disappears. A new field
appears. A date format changes. An enum gets a new value. You build a
detection system so these changes are caught before they corrupt your data.

## Why it matters

If you don't detect drift, you find out about it when:
- A query returns NULL for a field that used to have values
- A transformation silently fails and stores wrong data
- A consumer reports that reports look wrong

Detecting drift early means you can react before data is corrupted.

## What to detect

| Change type | Risk level |
|-------------|-----------|
| New field appears | Low — just add it |
| Field disappears | High — may be required downstream |
| Field type changes (e.g. string → integer) | High |
| Nullable changes (field becomes non-null or vice versa) | Medium |
| New enum value appears | Medium |
| Date format changes | High |
| Column widths change (fixed-width) | Critical |
| Record count drops significantly | Medium |
| Null rate increases for a previously dense field | Medium |

## How to implement drift detection

On each new batch of data:

1. Parse a sample of the new records
2. Infer the schema from this sample (same as step 3)
3. Compare this inferred schema against the stored reference schema
4. Generate a diff report
5. Alert if any BREAKING changes are detected
6. Update the reference schema if the change is intentional

## What counts as breaking

- A field that was present in 95%+ of records is now missing
- A field's type is incompatible with the stored type
- Column boundaries shift (fixed-width)
- A required field now contains nulls

## Output of this step

- A drift detection script that runs on each new file
- A schema version store (one JSON file per version, named by date)
- An alerting rule or log message for breaking changes
