# Step 0 — Intake the Target

## What this step is

Before inventory or profiling, ask for the exact data location and any
up-front preferences that will affect schema structure later.

## What to capture

- Target path or location
- Source name
- Access mode
- Sample path
- Owner
- Frequency
- Sensitivity
- Naming convention preferences
- Schema structure constraints
- Preferred language for illustrative examples
- Preferred parser packages or libraries, if the user already has standards

## Rule

If the user does not give a path, ask one direct question and wait.

If naming, entity, or schema conventions are likely to matter later, ask for
them during intake and save them as workflow decisions instead of rediscovering
them during modeling.

If the example language is unknown, ask for it during intake when it matters.
If the user does not specify one, default to Python and state that default
explicitly in later artifacts.

If the user already knows which packages or libraries should be used in the
future parser utility, capture them during intake and treat them as downstream
implementation constraints.
