# Step 0 — AI Prompts

## Prompt A — Ask for the target location

```
I need to start a data import workflow.

Ask me for the exact target data path or location first.
If I only give a vague description, keep asking until you have:
- file/folder/bucket/URL/other source location
- source name
- access mode
- sample path

Then ask for any schema-shaping preferences that should be honored later, such as:
- naming convention for fields/artifacts
- singular vs plural entity naming
- timestamp/date format expectations
- ID/key naming style
- preferred language for illustrative examples
- preferred parser packages or libraries, such as date handling or CSV libraries

If I do not specify an example language, note that Python will be used by default.
```

---

## Prompt B — Turn the answer into an intake note

```
Using this target data information:

<paste the user's answer>

Create a short intake note with:
- source name
- target location
- access mode
- owner
- sample path
- schema preferences
- preferred example language
- preferred parser packages or libraries
- risks
- next agent to run
```

---

## Prompt C — Generate a handoff summary

```
Summarize this target source for the next DMP agent.

<paste intake notes>

Return:
- target location
- source type
- schema preferences
- preferred example language
- preferred parser packages or libraries
- known constraints
- missing info
- next step
```
