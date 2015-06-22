function curryN(fn, n, params) {
    if (arguments.length < 3)
        params = [];

    return function (baseFunction) {
        return function (val) { // curry function
            if (params.length < baseFunction.length)
                params.push(val);

            if (params.length == baseFunction.length)
                return baseFunction.apply(this, params);
            else {
                return curryN(baseFunction, 0, params);
            }
        }
    }(fn, params);
}

module.exports = curryN;