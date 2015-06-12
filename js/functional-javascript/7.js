"use strict";

function reduce(arr, fn, initial) {
    if (arr.length === 0) {
        return initial;
    } else {
        var current = fn(initial, arr[0], 0, arr);
        return reduce(arr.slice(1), fn, current);
    }
}

module.exports = reduce;