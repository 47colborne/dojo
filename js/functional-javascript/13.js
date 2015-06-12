function repeat(operation, num) {
    // modify this so it can be interrupted
    setImmediate(function() {
        if (num <= 0) return;
        operation();
        repeat(operation, --num);
    });
}

module.exports = repeat;