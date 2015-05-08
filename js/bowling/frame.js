'use strict';

module.exports = function (rolls) {
  var nextFrame;

  function frameBonus() {
    if (!nextFrame){
      return 0;
    }

    if (isStrike()) {
      return nextFrame.getBonus(2);
    } else if (isSpare()) {
      return nextFrame.getBonus(1);
    } else {
      return 0;
    }
  }

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

      total += frameBonus();

      return total;
    },

    setNextFrame: function (frame) {
      nextFrame = frame;
    },

    next: function () {
      return nextFrame;
    },

    getBonus: function (n) {
      var total = 0,
        slicedRolls = rolls.slice(0, n),
        remainingRolls = n - slicedRolls.length;

      slicedRolls.forEach(function (roll) {
        total += roll;
      });

      if (remainingRolls > 0 && nextFrame) {
        total += nextFrame.getBonus(remainingRolls);
      }

      return total;
    }
  };
};
