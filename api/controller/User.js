const User = require('../model/User');
const Util = require('../util/Utils');
const keyGenerator = require('random-key-generator');

exports.create = function (req, res) {
    createUser(req)
        .then(data => Util.respond(res, "New User Created Successfully", data, null))
        .catch(error => Util.respond(res, "New User Creation Failed", null, error))
};

exports.userNames = function (req, res) {
    Util.validateKey(req, res, () => {
        User.find({}, {username: 1, _id: 0})
            .then(data => Util.respond(res, "Fetch all Username Successful", data, null))
            .catch(error => Util.respond(res, "Fetch all Username Failed", null, error))
    });
};

exports.getUser = function (req, res) {
    Util.validateKey(req, res, () => {
        User.find({username: req.params.username})
            .then(data => Util.respond(res, "Fetch User Successful", data, null))
            .catch(error => Util.respond(res, "Fetch User Failed", null, error))
    });
};

exports.login = function (req, res) {
    Util.validateKey(req, res, () => {
        User.findOneAndUpdate({username: req.body.username}, {api: keyGenerator(32)})
            .then(data => Util.respond(res, "User Find Successful, Logging In", data, null))
            .catch(error => Util.respond(res, "User find failed, cannot log in", null, error))
    });
};

exports.logout = function (req, res) {
    Util.validateKey(req, res, () => {
        User.findOneAndUpdate({username: req.body.username}, {api: null})
            .then(data => Util.respond(res, "User Find Successful, Logging Out", data, null))
            .catch(error => Util.respond(res, "User find failed, cannot log out", null, error))
    });
};

exports.remove = function (req, res) {
    Util.validateKey(req, res, () => {
        User.findOneAndRemove({username: req.params.username})
            .then(data => Util.respond(res, "User Remove Successful", data, null))
            .catch(error => Util.respond(res, "User Remove Failed", null, error))
    });
};

function createUser(req) {
    return new User({
        username: req.body.username,
        name: req.body.name,
        email: req.body.email,
        password: User.generateHash(req.body.password)
    })
}

