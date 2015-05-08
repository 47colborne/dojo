'use strict';
var expect = require('chai').expect;
var bowling = require('../game');

describe('game', function () {
  var game = bowling();

  it('should score the frames', function () {
    expect(game.score([[5, 0], [2, 2]])).to.eql(9);
  });

  it('should score a spare', function () {
    expect(game.score([[5, 5], [2, 2]])).to.eql(16);
  });

  it('should score the end of the game', function () {
    expect(game.score([[10], [10], [5, 5, 5]])).to.eql(60);
  });
});
