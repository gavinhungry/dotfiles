#!/usr/bin/node

const os = require('os');
const path = require('path');
const repl = require('repl');

const CONTEXT_FILENAME = '.node-repl-context.js';
const CONTEXT_PATH = path.join(os.homedir(), CONTEXT_FILENAME);

let _repl = repl.start({
  preview: false,
  useGlobal: true,
  ignoreUndefined: true
});

let replEval = cmd => _repl.eval(cmd, null, '', Function.prototype);
// replEval("require('@std/esm');");

_repl.setupHistory(process.env.NODE_REPL_HISTORY, () => {
  Object.assign(_repl.context, {
    _repl,
    env: process.env
  });

  try {
    const context = require(CONTEXT_PATH);

    Object.keys(context).forEach(key => {
      Object.defineProperty(_repl.context, key, {
        get() {
          return context[key];
        }
      });
    });
  } catch(err) {
    // could not load local context
  }
});
