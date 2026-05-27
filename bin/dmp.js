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

const providerCatalog = [
  { id: 'copilot', label: 'Copilot', path: '.github/agents/' },
  { id: 'gemini', label: 'Gemini CLI', path: '.gemini/commands/' },
  { id: 'claude', label: 'Claude/cmd', path: '.claude/commands/' },
  { id: 'kilo', label: 'Kilo', path: '.kilo/skills/' },
  { id: 'antigravity', label: 'Antigravity CLI', path: '.agents/workflows/' },
];

const providerAliases = new Map([
  ['agy', 'antigravity'],
]);

function parseArgs(argv) {
  let force = false;
  let agents = null;
  let providers = null;
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
    if (arg === '--providers' && argv[i + 1]) {
      providers = argv[i + 1];
      i += 1;
      continue;
    }
    if (arg.startsWith('--providers=')) {
      providers = arg.split('=', 2)[1];
      continue;
    }
    if (arg === '--help' || arg === '-h') {
      printHelp();
      process.exit(0);
    }
    target = arg;
  }

  return { force, agents, providers, target };
}

function printHelp() {
  console.log('Usage: dmp [--force] [--agents intake,discover,...] [--providers copilot,gemini,...] [target-repo]');
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

function normalizeProviders(input) {
  if (!input || input.toLowerCase() === 'all') {
    return providerCatalog.map((provider) => provider.id);
  }

  const indexMap = new Map(providerCatalog.map((provider, index) => [String(index + 1), provider.id]));
  const allowed = new Set(providerCatalog.map((provider) => provider.id));

  const selected = input
    .split(',')
    .map((part) => part.trim().toLowerCase())
    .filter(Boolean)
    .map((part) => {
      const normalized = indexMap.get(part) || part;
      return providerAliases.get(normalized) || normalized;
    })
    .filter((part) => allowed.has(part));

  if (selected.length === 0) {
    return null;
  }

  return [...new Set(selected)];
}

async function chooseProviders(parsed) {
  if (parsed.providers) {
    const selected = normalizeProviders(parsed.providers);
    if (!selected) {
      throw new Error('No valid providers were selected.');
    }
    return selected;
  }

  console.log('Select the provider surfaces to install:');
  providerCatalog.forEach((provider, index) => {
    console.log(`${index + 1}. ${provider.label} ${provider.path}`);
  });
  console.log('Enter comma-separated numbers or ids. Press Enter for all.');

  const answer = await prompt('Providers: ');
  const selected = normalizeProviders(answer || 'all');
  if (!selected) {
    throw new Error('No valid providers were selected.');
  }
  return selected;
}

async function main() {
  const parsed = parseArgs(args);
  const selectedAgents = await chooseAgents(parsed);
  const selectedProviders = await chooseProviders(parsed);

  const env = {
    ...process.env,
    DMP_SELECTED_AGENTS: selectedAgents.join(','),
    DMP_SELECTED_PROVIDERS: selectedProviders.join(','),
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
