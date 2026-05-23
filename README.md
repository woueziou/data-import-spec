# DMP Data Import Framework

This repo packages a reusable `dmp` workflow for undocumented data sources.

Current version: `0.1.0`

## Install

Run the installer from this repo and point it at the repo you want to equip:

```bash
./scripts/install.sh /path/to/target-repo
```

If the target repo already has `AGENTS.md` or `GEMINI.md`, re-run with
`--force` or merge those files manually first.

## What it installs

- `docs/` with the methodology and step docs
- `dmp/agents/` with shared agent specs
- `dmp/version.json` and `.dmp/install.json` for version tracking
- `AGENTS.md` and `GEMINI.md`
- tool surfaces for Copilot, Gemini CLI, Antigravity, Kilo, and `cmd`

## Entry points

- Start with `/dmp-intake`
- If the target path or location is missing, ask for it first
- Use [docs/framework.md](docs/framework.md) as the workflow map
- Use [docs/README.md](docs/README.md) as the docs index
