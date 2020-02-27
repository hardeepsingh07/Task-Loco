const User = require('../model/User');
const Util = require('../util/Utils');
const keyGenerator = require('random-key-generator');
const _ = require('lodash');

exports.create = function (req, res) {
    createUser(req)
        .save()
        .then(data => Util.respond(res, "New User Created Successfully", subsetResponse(data), null))
        .catch(error => Util.respond(res, "New User Creation Failed", null, error))
};

exports.userNames = function (req, res) {
    Util.validateKey(req, res, () => {
        User.find({}, {username: 1, name: 1, _id: 0})
            .then(data => Util.respond(res, "Fetch all Username Successful", data, null))
            .catch(error => Util.respond(res, "Fetch all Username Failed", null, error))
    });
};

exports.getUser = function (req, res) {
    Util.validateKey(req, res, () => {
        User.find({username: req.params.username}, {password: 0})
            .then(data => Util.respond(res, "Fetch User Successful", data, null))
            .catch(error => Util.respond(res, "Fetch User Failed", null, error))
    });
};

exports.login = function (req, res) {
    User.findOne({username: req.body.username})
        .then(user => {
            user.validatePassword(req.body.password, function (error, isValid) {
                if (error || !isValid) Util.respond(res, "Invalid Password", null, Error("Invalid Password"));
                User.findByIdAndUpdate(user.id, {apiKey: keyGenerator(32)}, {new: true})
                    .then(data => Util.respond(res, "User Find Successful, Logging In", subsetResponse(data), null))
                    .catch(error => Util.respond(res, "User Find Successful, Logging In Failed", null, error))
            })
        }).catch(error => Util.respond(res, "User find failed, cannot log in", null, error))
};

exports.logout = function (req, res) {
    Util.validateKey(req, res, () => {
        User.findOneAndUpdate({username: req.body.username}, {apiKey: null}, {new: true})
            .then(data => Util.respond(res, "User Find Successful, Logging Out", subsetResponse(data), null))
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

function subsetResponse(data) {
    return _.pick(data, ['_id', 'username', 'apiKey'])
}

function createUser(req) {
    return new User({
        username: req.body.username,
        name: req.body.name,
        email: req.body.email,
        password: req.body.password,
        apiKey: keyGenerator(32)
    })
}

