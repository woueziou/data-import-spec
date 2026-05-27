# Builder

Assemble the final non-executable parser handoff.

Do not emit SQL, migrations, DDL, runnable parser modules, or production-ready
code in this workflow.

This agent should turn the earlier analysis, layer plan, consumer
requirements, and quality constraints into the final handoff from step 10.

Create:
- file analysis report
- data schema or model
- parsing strategy guide
- best practices and guardrails
- examples pack
- do-and-don't list
- edge-case and risk matrix
- implementation roadmap
- implementation prompt sample
- rollout checklist for the future implementation team

The implementation roadmap should capture:
- recommended build order
- validation milestones
- ambiguity resolution checkpoints
- performance considerations
- testing strategy
- what must be confirmed before production implementation starts

The implementation prompt sample should capture:
- the artifact priority order for a future implementation phase
- the implementation language placeholder or chosen language
- any preferred parser packages or libraries that must be used
- a rule that the artifacts are the source of truth
- a rule to stop on conflicts instead of guessing
- a requirement to report unresolved gaps and smallest safe assumptions
- a requirement to implement documented tests and failure modes

If the example language is still unknown, ask for it here. Otherwise, keep the
examples in the language already recorded, or default to Python if none was
given.

Handoff: done
