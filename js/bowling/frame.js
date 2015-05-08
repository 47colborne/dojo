'use strict';

module.exports = function (rolls) {
  var nextFrame;

  function isStrike() {
    return rolls[0] === 10;
  }

  function isSpare() {
    return rolls[0] + rolls[1] === 10;
  }

  return {
    score: function () {
      var total = 0;

      rolls.forEach(function (roll) {
        total += roll;
      });

      if (isStrike()) {
        total += this.getBonus(2);
      } else if (isSpare()) {
        total += this.getBonus(1);
      }

      return total;
    },

    setNextFrame: function (frame) {
      nextFrame = frame;
    },

    next: function () {
      return nextFrame;
    },

    getBonus: function (n) {
      var total = 0;
      var slicedRolls = rolls.slice(0, n);
      var remainingRolls = n - slicedRolls.length;

      if (remainingRolls > 0 && nextFrame) {
        total += nextFrame.getBonus(remainingRolls);
      }

      slicedRolls.forEach(function (roll) {
        total += roll;
      });

      return total;
    }
  };
};
