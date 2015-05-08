'use strict';
var frame = require('./frame');

module.exports = function () {
  function buildFrames(frames) {
    var _frames = [],
      currentFrame,
      previousFrame;

    frames.forEach(function (pins) {
      currentFrame = frame(pins);
      _frames.push(currentFrame);

      if (previousFrame) {
        previousFrame.setNextFrame(currentFrame);
      }

      previousFrame = currentFrame;
    });

    return _frames;
  }

  return {
    score: function (frameArray) {
      var _frames = buildFrames(frameArray),
        total = 0;

      _frames.forEach(function (f) {
        total += f.score();
      });

      return total;
    }
  };
};
