const User = require('../model/User');
const Util = require('../utils/ResponseUtil');
const keyGenerator = require('random-key-generator');
const invalidKeyError = Error("Invalid Api Key");

exports.create = function (req, res) {
    createUser(req)
        .then(data => Util.respond(res, "New User Created Successfully", data, null))
        .catch(error => Util.respond(res, "New User Creation Failed", null, error))
};

exports.userNames = function (req, res) {
    User.find({}, {username: 1, _id: 0})
        .then(data => {
            if (Util.validKey(req, data)) {
                Util.respond(res, "Fetch all Username Successful", data, null)
            } else {
                Util.respond(res, "Fetch all Username Failed", null, invalidKeyError)
            }
        })
        .catch(error => Util.respond(res, "Fetch all Username Failed", null, error))
};

exports.getUser = function (req, res) {
    User.find({username: req.params.username})
        .then(data => {
            if (Util.validKey(req, data)) {
                Util.respond(res, "Fetch User Successful", data, null)
            } else {
                Util.respond(res, "Fetch User Failed, Invalid Api Key", null, invalidKeyError)
            }
        })
        .catch(error => Util.respond(res, "Fetch User Failed", null, error))
};

exports.login = function (req, res) {
    User.find({username: req.body.username})
        .then(data => {
            if (Util.validKey(req, data)) {
                data.findByIdAndUpdate(data.id, {api: keyGenerator(32)});
                Util.respond(res, "User Find Successful, Logging In", data, null)
            } else {
                Util.respond(res, "Invalid Password", null, invalidKeyError)
            }
        })
        .catch(error => Util.respond(res, "User find failed, cannot log in", null, error))
};

exports.logout = function (req, res) {
    User.find({username: req.body.username})
        .then(data => {
            if (Util.validKey(req, data)) {
                data.findByIdAndUpdate(data.id, {api: null});
                Util.respond(res, "User Find Successful, Logging Out", data, null)
            } else {
                Util.respond(res, "Invalid Password", null, invalidKeyError)
            }
        })
        .catch(error => Util.respond(res, "User find failed, cannot log out", null, error))
};

exports.remove = function (req, res) {
    User.find({username: req.params.username})
        .then(data => {
            if (Util.validKey(req, data)) {
                data.findByIdAndRemove(data.id);
                Util.respond(res, "User Remove Successful", data, null)
            } else {
                Util.respond(res, "User Remove Failed", null, invalidKeyError)
            }
        })
        .catch(error => Util.respond(res, "User Remove Failed", null, error))
};

function createUser(req) {
    return new User({
        username: req.body.username,
        name: req.body.name,
        email: req.body.email,
        password: User.generateHash(req.body.password)
    })
}

