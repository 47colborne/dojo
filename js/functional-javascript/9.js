var slice = Array.prototype.slice;

function logger(namespace) {
    return function () {
        if (arguments != null) {
            argumentsArray = slice.call(arguments);

            newArgumentsArray = Array.prototype.concat(namespace, argumentsArray);
            console.log.apply(null, newArgumentsArray);
        }
    };
}

module.exports = logger;
