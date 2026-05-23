# Step 0 — AI Prompts

## Prompt A — Ask for the target location

```
I need to start a data import workflow.

Ask me for the exact target data path or location first.
If I only give a vague description, keep asking until you have:
- file/folder/bucket/URL/database location
- source name
- access mode
- sample path
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
- known constraints
- missing info
- next step
```
