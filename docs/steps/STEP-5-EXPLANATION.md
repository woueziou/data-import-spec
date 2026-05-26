# Step 5 — Separate Parsing Work into Layers

## What this step is

You should not jump straight from raw files to a finished parser design.
Instead, separate the work into clear analysis and transformation layers.

## Why it matters

If you mix discovery, normalization, and downstream assumptions in one step,
you make mistakes harder to detect. Layers keep evidence, interpretation,
and implementation guidance separate.

## The three layers

### Observation Layer

**Purpose**: Preserve what was actually observed in the sample.

Store:
- The full original record (as a string or blob)
- Source name
- File name and batch clues
- Record boundaries and offsets where relevant

**Do not interpret here.** This is your evidence base.

### Normalization Layer

**Purpose**: Describe how raw values become canonical values.

Transform:
- Trim whitespace from all string fields
- Parse dates into ISO 8601 format
- Convert strings to numbers where appropriate
- Normalize enums to canonical values (e.g. "Y" / "YES" / "1" → `true`)
- Standardize units (e.g. all amounts in the same currency)
- Assign canonical identifiers where justified

**This layer is where your provisional schema becomes operational guidance.**

### Handoff Layer

**Purpose**: Package the information an implementation team will need.

Examples:
- Formal schemas
- Parsing strategy guides
- Guardrails and validation rules
- Illustrative examples
- Implementation roadmap documents

**Only include what the implementation team can defend from evidence.**

## Output of this step

- A diagram or description of your three layers
- A definition of what belongs in each layer
- A note about what must stay ambiguous until more evidence arrives
