# Changelog

## 0.1.6

- Renamed the npm package to `@data-import-spec/cli`
- Updated the documented `npx` install command to `npx @data-import-spec/cli@latest`
- Added `publishConfig.access=public` for package publishing

## 0.1.5

- Renamed the npm package to `data-import-spec`
- Updated the documented `npx` install command to `npx data-import-spec@latest`

## 0.1.4

- Added an npm package entrypoint for `npx @woueziou/data-import-spec@latest`
- Added `bin/dmp.js` as the publishable installer wrapper
- Prepared the repo for package publishing with `package.json`

## 0.1.3

- Added `_dmp_out/` as the shared workflow state folder in target repos
- Added `dmp/bin/init-state.sh` and `dmp/bin/start-workflow.sh`
- Added workflow templates for `context`, `searches`, `tasks`, `decisions`, and `next-step`
- Updated intake guidance so the first workflow step writes persistent handoff state

## 0.1.2

- Added `scripts/install-from-github.sh` for GitHub-hosted installs
- Persisted source mode, repo, and ref so GitHub installs can be updated in place
- Made `dmp/bin/reinstall.sh` work for both local-source and GitHub-source installs

## 0.1.1

- Allowed install to target the current repo by default
- Added `dmp/bin/reinstall.sh` for updates from inside the target repo
- Stored source repo metadata in `.dmp/install.json` and `.dmp/source-repo.txt`

## 0.1.0

- Added the DMP agent framework
- Added step 0 intake
- Added installable command surfaces
- Added versioning and install manifest
