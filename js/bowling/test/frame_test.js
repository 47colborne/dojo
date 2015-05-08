'use strict';
var expect = require('chai').expect;
var frame = require('../frame');

describe('frame', function () {
  describe('non-bonus frame', function () {
    it('should add up the pins', function () {
      expect(frame([2, 3]).score()).to.equal(5);
    });
  });

  it('should return the next frame', function () {
    var nextFrame = frame([1, 1]);
    var f = frame([2, 3]);
    f.setNextFrame(nextFrame);
    expect(f.next()).to.eql(nextFrame);
  });

  describe('strike frame', function () {
    it('should include the next two rolls in the score', function () {
      var nextFrame = frame([1, 1]);
      var f = frame([10]);
      f.setNextFrame(nextFrame);
      expect(f.score()).to.eql(12);
    });
  });

  describe('spare frame', function () {
    it('should include the next roll in the score', function () {
      var nextFrame = frame([1, 1]);
      var f = frame([6, 4]);
      f.setNextFrame(nextFrame);
      expect(f.score()).to.eql(11);
    });
  });

  describe('getBonus', function () {
    it('should return the sum of next roll', function () {
      var f = frame([6, 4]);
      expect(f.getBonus(1)).to.eql(6);
    });

    it('should return the sum of next 2 rolls when frame has one', function () {
      var nextFrame = frame([1, 1]);
      var f = frame([10]);
      f.setNextFrame(nextFrame);
      expect(f.getBonus(2)).to.eql(11);
    });
  });
});
