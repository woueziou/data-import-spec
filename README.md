# DMP Data Import Framework

This repo packages a reusable `dmp` workflow for undocumented data sources.

Current version: `0.1.3`

## Install

Install directly from the GitHub repo:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/woueziou/data-import-spec/main/scripts/install-from-github.sh) --repo woueziou/data-import-spec --ref main .
```

If the target repo already has `AGENTS.md` or `GEMINI.md`, re-run with
`--force` or merge those files manually first.

## What it installs

- `docs/` with the methodology and step docs
- `dmp/agents/` with shared agent specs
- `_dmp_out/` as the shared workflow state folder
- `dmp/bin/init-state.sh` and `dmp/bin/start-workflow.sh`
- `dmp/bin/reinstall.sh` for re-running install from the target repo
- `dmp/version.json` and `.dmp/install.json` for version tracking
- `AGENTS.md` and `GEMINI.md`
- tool surfaces for Copilot, Gemini CLI, Antigravity, Kilo, and `cmd`

## Start A Workflow

From the target repo, create a workflow state folder before deeper analysis:

```bash
./dmp/bin/start-workflow.sh order_file "Order file parser"
```

That creates `_dmp_out/order_file/` with:
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
- If the target path or location is missing, ask for it first
- Use `_dmp_out/<workflow-id>/` as the source of truth for handoff and resume
- Use [docs/framework.md](docs/framework.md) as the workflow map
- Use [docs/README.md](docs/README.md) as the docs index

## Example Sandbox

- [example/README.md](example/README.md)
- The `example/` folder is a ready-to-use target repo for experimenting with the framework
