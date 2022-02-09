#!/usr/bin/node

const os = require('os');
const path = require('path');
const repl = require('repl');

const CONTEXT_FILENAME = '.node-context.js';
const CONTEXT_PATH = path.join(os.homedir(), CONTEXT_FILENAME);

const EMPTY = Symbol('EMPTY');

const request = moduleName => {
  try {
    return require(moduleName);
  } catch(err) {
    return err;
  }
};

const _repl = repl.start({
  preview: false,
  useGlobal: true,
  ignoreUndefined: true
});

const replEval = cmd => _repl.eval(cmd, null, '', Function.prototype);
// replEval("require('@std/esm');");

_repl.setupHistory(process.env.NODE_REPL_HISTORY, () => {
  Object.assign(_repl.context, {
    _repl,
    env: process.env
  });

  try {
    const context = require(CONTEXT_PATH);

    Object.keys(context).forEach(key => {
      let cache = EMPTY;

      Object.defineProperty(_repl.context, key, {
        get() {
          let value = context[key];

          if (typeof value === 'string') {
            return request(value);
          }

          if (typeof value === 'function') {
            if (cache === EMPTY) {
              cache = value();
            }

            return cache;
          }

          return null;
        },

        enumerable: true
      });
    });
  } catch(err) {
    // could not load local context
  }
});
