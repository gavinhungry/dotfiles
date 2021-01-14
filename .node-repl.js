#!/usr/bin/node

const os = require('os');
const path = require('path');
const repl = require('repl');

const CONTEXT_FILENAME = '.node-repl-context.js';
const CONTEXT_PATH = path.join(os.homedir(), CONTEXT_FILENAME);

let _repl = repl.start({
  preview: false,
  useGlobal: true
});

_repl.setupHistory(process.env.NODE_REPL_HISTORY, () => {
  Object.assign(_repl.context, {
    _repl,
    env: process.env
  });

  try {
    const context = require(CONTEXT_PATH);
    Object.assign(_repl.context, context);
  } catch(err) {
    // could not load local context
  }
});
