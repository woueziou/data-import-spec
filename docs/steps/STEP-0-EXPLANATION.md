# Step 0 — Intake the Target

## What this step is

Before inventory or profiling, ask for the exact data location and any
up-front preferences that will affect schema structure later.

## What to capture

- Target path or location
- Target relational database
- Source name
- Access mode
- Sample path
- Owner
- Frequency
- Sensitivity
- Naming convention preferences
- Schema structure constraints

## Rule

If the user does not give a path, ask one direct question and wait.

If naming, entity, or schema conventions are likely to matter later, ask for
them during intake and save them as workflow decisions instead of rediscovering
them during modeling.

If the target database is unknown, ask for it during intake. Storage guidance
should adapt to the user's chosen relational database instead of assuming one.
