'use strict';

function curryN(fn, n, params) {
    n = n || fn.length;
    params = params || [];

    return function () { // curry function
        var combinedParams = params.concat(Array.prototype.slice.call(arguments));

        if (combinedParams.length >= n) {
            return fn.apply(this, combinedParams);
        }
        else {
            return curryN(fn, n, combinedParams);
        }
    };
}

module.exports = curryN;
