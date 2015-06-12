module.exports = function arrayMap(arr, fn) {
    return arr.reduce(function(output, current){
        return output.concat(fn(current));
    }, []);
};