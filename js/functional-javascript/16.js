function getDependencies(tree) {

    if (tree) {

        actual = tree.dependencies;
        results = [];
        return collectDependencies(actual, results).sort();
    }
    else {
        return [];
    }
}

function collectDependencies(tree, results) {

    if (!tree) {
        return [];
    }

    Object.keys(tree).forEach(function (dependency, index) {
        var name = dependency;
        var version = tree[dependency].version;
        var name_version = name + '@' + version;


        if (results.indexOf(name_version) < 0) {
            results.push(name + '@' + version);
        }

        collectDependencies(tree[dependency].dependencies, results);
    });

    return results;
}


module.exports = getDependencies