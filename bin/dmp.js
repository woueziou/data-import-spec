#!/usr/bin/env node
const { spawnSync } = require('child_process');
const path = require('path');
const readline = require('readline');

const repoRoot = path.resolve(__dirname, '..');
const installer = path.join(repoRoot, 'scripts', 'install.sh');
const args = process.argv.slice(2);

const agentCatalog = [
  { id: 'intake', label: 'Pathfinder', command: '/dmp-intake' },
  { id: 'discover', label: 'Cataloger', command: '/dmp-discover' },
  { id: 'model', label: 'Mapper', command: '/dmp-model' },
  { id: 'guard', label: 'Sentinel', command: '/dmp-guard' },
  { id: 'serve', label: 'Builder', command: '/dmp-serve' },
];

function parseArgs(argv) {
  let force = false;
  let agents = null;
  let target = null;

  for (let i = 0; i < argv.length; i += 1) {
    const arg = argv[i];
    if (arg === '--force') {
      force = true;
      continue;
    }
    if (arg === '--agents' && argv[i + 1]) {
      agents = argv[i + 1];
      i += 1;
      continue;
    }
    if (arg.startsWith('--agents=')) {
      agents = arg.split('=', 2)[1];
      continue;
    }
    if (arg === '--help' || arg === '-h') {
      printHelp();
      process.exit(0);
    }
    target = arg;
  }

  return { force, agents, target };
}

function printHelp() {
  console.log('Usage: dmp [--force] [--agents intake,discover,...] [target-repo]');
}

function prompt(question) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  return new Promise((resolve) => {
    rl.question(question, (answer) => {
      rl.close();
      resolve(answer.trim());
    });
  });
}

function normalizeAgents(input) {
  if (!input || input.toLowerCase() === 'all') {
    return agentCatalog.map((agent) => agent.id);
  }

  const indexMap = new Map(agentCatalog.map((agent, index) => [String(index + 1), agent.id]));
  const allowed = new Set(agentCatalog.map((agent) => agent.id));

  const selected = input
    .split(',')
    .map((part) => part.trim().toLowerCase())
    .filter(Boolean)
    .map((part) => indexMap.get(part) || part)
    .filter((part) => allowed.has(part));

  if (selected.length === 0) {
    return null;
  }

  return [...new Set(selected)];
}

async function chooseAgents(parsed) {
  if (parsed.agents) {
    const selected = normalizeAgents(parsed.agents);
    if (!selected) {
      throw new Error('No valid agents were selected.');
    }
    return selected;
  }

  console.log('Select the agents to install:');
  agentCatalog.forEach((agent, index) => {
    console.log(`${index + 1}. ${agent.label} ${agent.command}`);
  });
  console.log('Enter comma-separated numbers or ids. Press Enter for all.');

  const answer = await prompt('Agents: ');
  const selected = normalizeAgents(answer || 'all');
  if (!selected) {
    throw new Error('No valid agents were selected.');
  }
  return selected;
}

async function main() {
  const parsed = parseArgs(args);
  const selectedAgents = await chooseAgents(parsed);

  const env = {
    ...process.env,
    DMP_SELECTED_AGENTS: selectedAgents.join(','),
  };

  const installerArgs = [];
  if (parsed.force) {
    installerArgs.push('--force');
  }
  if (parsed.target) {
    installerArgs.push(parsed.target);
  }

  const result = spawnSync('bash', [installer, ...installerArgs], {
    stdio: 'inherit',
    cwd: process.cwd(),
    env,
  });

  if (result.error) {
    console.error(result.error.message);
    process.exit(1);
  }

  process.exit(result.status ?? 1);
}

main().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
