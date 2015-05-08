'use strict';
module.exports = function (str) {
  console.log(str || 'Rainbow');

  return {
    foo: function () {
      return 1;
    }
  };
};
