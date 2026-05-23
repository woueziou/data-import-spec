# DMP Data Import Framework

This repo packages a reusable `dmp` workflow for undocumented data sources.

Current version: `0.1.2`

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
- `dmp/bin/reinstall.sh` for re-running install from the target repo
- `dmp/version.json` and `.dmp/install.json` for version tracking
- `AGENTS.md` and `GEMINI.md`
- tool surfaces for Copilot, Gemini CLI, Antigravity, Kilo, and `cmd`

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
- Use [docs/framework.md](docs/framework.md) as the workflow map
- Use [docs/README.md](docs/README.md) as the docs index
