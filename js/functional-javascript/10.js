module.exports = function(namespace) {
    return console.log.bind(undefined, namespace);
};