# Step 7 — Model Uncertainty Explicitly

## What this step is

Since you have no documentation, some fields will be well-understood and
others will be guesses. You track this formally in a data dictionary so
you never confuse "I know this" with "I think this".

## Why it matters

Ambiguous fields used in production cause silent data corruption. If a field
you thought was optional turns out to be required, or an enum you thought
had 3 values suddenly has a 4th, you need to catch that — not discover it
when something downstream breaks.

## The data dictionary

Maintain a central data dictionary with one row per field per source:

| Property | Description |
|----------|-------------|
| field_name | Canonical name |
| source | Which source this field comes from |
| raw_name | Original name or position in the source |
| meaning | Your best understanding of what this field represents |
| inferred_type | The type you've inferred |
| transformation | The rule applied to convert from raw to standardized |
| confidence | `confirmed` / `inferred` / `ambiguous` / `deprecated` |
| evidence | What evidence supports your understanding |
| open_questions | What you don't know or can't verify |
| last_seen | Date of the last sample that contained this field |
| first_seen | Date of the first sample |

## Confidence states

- **confirmed** — you have verified this with multiple samples and the
  meaning is clear and consistent
- **inferred** — you've reasoned from values and context but haven't confirmed
- **ambiguous** — you have competing hypotheses and can't decide without
  more information
- **deprecated** — this field appeared in older samples but not recent ones

## What to do with ambiguous fields

Don't guess and move on. Instead:
1. Document both hypotheses
2. Store the raw value and defer transformation
3. Add a flag in the standardized record: `is_<fieldname>_verified: false`
4. Return to it when more samples arrive or when a consumer needs the field

## Output of this step

A `data-dictionary.json` or `data-dictionary.md` file covering all sources.
