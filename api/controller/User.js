const User = require('../model/User');

exports.create = function (req, res) {

};

exports.userNames = function(req, res) {

};

exports.getUser = function(req, res) {

};

exports.login = function (req, res) {

};

exports.remove = function (req, res) {

};

function createUser(req) {
    return new User({
        username: req.body.username,
        name: req.body.name,
        email: req.body.email,
        password: User.generateHash(req.body.password)
    })
}

