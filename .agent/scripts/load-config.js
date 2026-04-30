#!/usr/bin/env node
/**
 * Autonomous Launcher - Config Loader (JSON version)
 * Reads .agent/workflows/autonomous.json and outputs JSON
 * Usage: node load-config.js [key]
 */

const fs = require('fs');
const path = require('path');

const configPath = path.resolve(process.cwd(), '.agent/workflows/autonomous.json');

try {
  const content = fs.readFileSync(configPath, 'utf-8');
  const config = JSON.parse(content);

  // Add derived values
  const now = new Date();
  config._derived = {
    date: now.toISOString().split('T')[0],
    timestamp: now.toISOString().replace(/[:.]/g, '-'),
  };

  // Output
  if (process.argv[2]) {
    const keys = process.argv[2].split('.');
    let value = config;
    for (const key of keys) {
      value = value?.[key];
      if (value === undefined) break;
    }
    console.log(typeof value === 'object' ? JSON.stringify(value, null, 2) : value);
  } else {
    console.log(JSON.stringify(config, null, 2));
  }
} catch (err) {
  if (err.code === 'ENOENT') {
    console.error('ERROR: Config file not found at .agent/workflows/autonomous.json');
    console.error('Create it first or use the default configuration.');
    process.exit(1);
  }
  throw err;
}
