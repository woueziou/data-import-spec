#!/usr/bin/env node
const { spawnSync } = require('child_process');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const installer = path.join(repoRoot, 'scripts', 'install.sh');
const args = process.argv.slice(2);

const result = spawnSync('bash', [installer, ...args], {
  stdio: 'inherit',
  cwd: process.cwd(),
  env: process.env,
});

if (result.error) {
  console.error(result.error.message);
  process.exit(1);
}

process.exit(result.status ?? 1);
