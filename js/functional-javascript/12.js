function spy(target, method) {
    var obj = {
        count : 0
        };

    var oldMethod = target[method];

    var newMethod = function() {
        obj.count++;
        return oldMethod.apply(target,arguments);
    };

    target[method] = newMethod;

    return obj;
}

module.exports = spy