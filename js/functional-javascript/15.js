function loadUsers(userIds, load, done) {
    var users = [];
    var counter = 0;

    userIds.forEach(function(elem, index) {
        load(elem, function(user) {
            users[index] = user;
            counter++;
            if (counter === userIds.length) {
                done(users);
            }
        });
    });
}

module.exports = loadUsers