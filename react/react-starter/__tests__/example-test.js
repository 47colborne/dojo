'use strict';

require('jest-cli');

jest.dontMock('../app/example'); // unmock to use the actual implementation of example

describe('sum', () => {
  it('adds 1 + 2 to equal 3', () => {
    const sum = require('../app/example.js');
    console.log(sum)
    expect(sum(1, 2)).toBe(3);
  });
});