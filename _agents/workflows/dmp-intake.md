# Name: dmp-intake
# Description: Capture the target source location, sample path, and workflow constraints before deeper analysis begins.

## Objective
Initialize or continue the DMP intake step using the repository's shared workflow rules and intake guidance.

## Instructions
1. Read `dmp/AGENTS.md`, `dmp/framework.md`, and `dmp/agents/intake.md` before responding.
2. If the target path or location is missing, ask for it first and stop. If `_dmp_output/<workflow-id>/` is missing, create it with `./dmp/bin/start-workflow.sh <workflow-id> "<title>"` before continuing.
3. Treat `_dmp_output/<workflow-id>/` as the source of truth and update `context.md`, `searches.md`, `decisions.md`, `tasks.md`, and `next-step.md` according to the intake spec.
4. Keep the response structured, handoff-ready, and non-executable. End by handing off to `/dmp-discover` when intake is complete.
