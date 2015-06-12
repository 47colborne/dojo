function countWords(inputWords) {
    hash = {};

    inputWords.forEach(function(element){
        hash[element] = hash[element] || 0;
        hash[element] += 1;
    });

    return hash;
}

module.exports = countWords