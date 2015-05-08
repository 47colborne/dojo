'use strict';

module.exports = function () {
  var PLACES = [
    {unit: 'I', fiveUnit: 'V'},
    {unit: 'X', fiveUnit: 'L'},
    {unit: 'C', fiveUnit: 'D'},
    {unit: 'M'}
  ];

  return {
    translate: function (number) {
      if (number >= 4000) {
        return undefined;
      }

      var answer = '',
        stringNumber = number.toString(),
        currentPlace = stringNumber.length - 1,
        digit = parseInt(stringNumber.charAt(0)),
        ones = 0;

      if (digit === 9) {
        answer += PLACES[currentPlace].unit + PLACES[currentPlace + 1].unit;
      } else if (digit >= 5) {
        answer += PLACES[currentPlace].fiveUnit;
        ones = digit - 5;
      } else if (digit === 4) {
        answer += PLACES[currentPlace].unit + PLACES[currentPlace].fiveUnit;
      } else {
        ones = digit;
      }

      for (var i = 0; i < ones; i++) {
        answer += PLACES[currentPlace].unit;
      }

      if (currentPlace === 0) {
        return answer;
      } else {
        return answer + this.translate(parseInt(stringNumber.substring(1)));
      }
    }
  };
};
