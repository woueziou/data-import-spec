# DMP Data Import Framework

This repo packages a reusable `dmp` workflow for undocumented data sources.

Current version: `0.1.7`

## Install

Install with `npx`:

```bash
npx @petadata/parser@latest
```

Run it from inside the target repo, or pass a target path as the last argument.
The installer asks which agents you want and only installs those selections.

If the target repo already has `AGENTS.md` or `GEMINI.md`, re-run with
`--force` or merge those files manually first.

## What it installs

- `dmp/framework.md`
- selected `dmp/agents/` specs
- `dmp/bin/init-state.sh` and `dmp/bin/start-workflow.sh`
- `dmp/bin/reinstall.sh` for re-running install from the target repo
- `dmp/version.json` and `dmp/install.json` for version tracking
- `AGENTS.md` and `GEMINI.md`
- selected tool surfaces for Copilot, Gemini CLI, Antigravity, Kilo, and `cmd`

## What it does not install

- `docs/`
- `example/`
- `.dmp/`
- `_dmp_output/`

`_dmp_output/` is created on first use of `/dmp-intake`.

## Start A Workflow

Start with `/dmp-intake`.

On first use, it should create `_dmp_output/` and `_dmp_output/<workflow-id>/`
before deeper analysis.

If you want to create the workflow folder manually, you can still run:

```bash
./dmp/bin/start-workflow.sh order_file "Order file parser"
```

That creates `_dmp_output/order_file/` with:
- `context.md`
- `searches.md`
- `tasks.md`
- `decisions.md`
- `next-step.md`
- `workflow.json`
- `artifacts/`

## Update From Target Repo

After the first install, you can re-run the install directly from the target
repo with:

```bash
./dmp/bin/reinstall.sh
```

That path is intended for updates of an existing DMP install.

## Entry points

- Start with `/dmp-intake`
- `/dmp-intake` should create `_dmp_output/<workflow-id>/` if it does not exist yet
- If the target path or location is missing, ask for it first
- Use `_dmp_output/<workflow-id>/` as the source of truth for handoff and resume
- Use `dmp/framework.md` as the workflow map inside installed repos

## Example Sandbox

- [example/README.md](example/README.md)
- The `example/` folder is a ready-to-use target repo for experimenting with the framework
