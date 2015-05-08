#!/usr/bin/env node
'use strict';
var meow = require('meow');
var dojoTemplate = require('./');

var cli = meow({
  help: [
    'Usage',
    '  dojo-template <input>',
    '',
    'Example',
    '  dojo-template Unicorn'
  ].join('\n')
});

dojoTemplate(cli.input[0]);
