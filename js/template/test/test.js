'use strict';
var expect = require('chai').expect;
var dojoTemplate = require('../');

describe('dojo-template node module', function () {
  it('should do something', function () {
    var bar = dojoTemplate().foo();
    expect(bar).to.equal(1);
  });
});
