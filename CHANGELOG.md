# Changelog

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
