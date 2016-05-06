import React from 'react';
import { mount, shallow } from 'enzyme';
import chai from 'chai';
var expect = chai.expect;
import sinon from 'sinon';
import sinonChai from 'sinon-chai';
import chaiEnzyme from 'chai-enzyme';
chai.use(sinonChai);
chai.use(chaiEnzyme());

module.exports = {
  expect: chai.expect,
  sinon: sinon,
  React: React,
  shallow: shallow,
  mount: mount
};