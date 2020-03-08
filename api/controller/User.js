const User = require('../model/User');
const keyGenerator = require('random-key-generator');
const _ = require('lodash');
const utils = require('../util/Utils');

exports.create = function (req, res) {
    User.exists({username: req.body.username})
        .then(exists => {
            exists
                ? res.createResponse("New User Creation Failed", null, userExistsError())
                : res.generateAndRespond("New User Creation", createUser(req).save());
        }).catch(error => res.createResponse("User Creation Failed", null, userExistsError()));
};

exports.userNames = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch all Username", User.find({}, {username: 1, name: 1, _id: 0}));
    });
};

exports.getUser = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch User", User.find({username: req.params.username}, {password: 0}))
    });
};

exports.login = function (req, res) {
    User.findOne({username: req.body.username})
        .then(user => {
            user.validatePassword(req.body.password, function (error, isValid) {
                if (error || !isValid) res.createResponse( "Invalid Password", null, Error("Invalid Password"));
                res.generateAndRespond("User Login",
                    User.findByIdAndUpdate(user.id, {apiKey: keyGenerator(32)}, {new: true}));
            })
        }).catch(error => res.createResponse( "User find failed, cannot log in", null, error))
};

exports.logout = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("User Logout",
            User.findOneAndUpdate({username: req.body.username}, {apiKey: null}, {new: true}))
    });
};

exports.remove = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("User Remove", User.findOneAndRemove({username: req.params.username}))
    });
};

function createUser(req) {
    return new User({
        username: req.body.username,
        name: req.body.name,
        email: req.body.email,
        password: req.body.password,
        apiKey: keyGenerator(32)
    })
}

function userExistsError() {
    let error = Error();
    error.name = "User already Exists";
    error.message = "Username is already taken, please choose an another Username.";
    return error;
}

