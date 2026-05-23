# Data Archaeology Methodology

A step-by-step methodology for reverse-engineering undocumented data sources
(fixed-width text files, CSV, logs, etc.) and storing them in a database.

## Folder Structure

| Step | Folder | Goal |
|------|--------|------|
| 1 | `01-inventory` | Catalog every source |
| 2 | `02-profile` | Sample and inspect raw data |
| 3 | `03-schema` | Build a provisional schema per source |
| 4 | `04-entities` | Find shared entities across sources |
| 5 | `05-layers` | Design raw / standardized / serving layers |
| 6 | `06-naming` | Define canonical naming and typing rules |
| 7 | `07-uncertainty` | Track confidence and ambiguity |
| 8 | `08-drift` | Detect schema evolution over time |
| 9 | `09-validate` | Validate with downstream consumers |
| 10 | `10-database` | Design the final database model |
| 11 | `11-quality` | Add data quality rules |
| 12 | `12-iterate` | Iterative refinement loop |

## How to use this guide

Each folder contains:
- `EXPLANATION.md` — what the step is, why it matters, how to do it
- `PROMPTS.md` — ready-to-use AI prompts to generate TypeScript parsing scripts

Start at step 1 and work forward. You can loop back to earlier steps as you
learn more about your data.
