const User = require('../model/User');
const express = require('express');
const ApiResponse = require('../model/ApiResponse');
const invalidApiKeyError = {name: "InvalidApiKey", message: "Api Key doesn't not exist. Login for new Api Key or confirm your existing Api key"};

express.response.createResponse = function(message, data, error) {
    console.log(`${message}: ${error ? error : JSON.stringify(data)}`);
    let outwardError = error ? {name: "Error Occurred", message: message} : null;
    let response = new ApiResponse(data? 200: 250, message, data, outwardError);
    this.send(response)
};

express.response.generateAndRespond = function(message, promise) {
    promise
        .then(data => this.createResponse(message + " Successful", data, null))
        .catch(error => this.createResponse(message + " Failed", null, error))
};

express.request.validateKey = function(res, action) {
    User.findOne({apiKey: this.query.apiKey})
        .then(data => data ? action() : res.createResponse("Invalid Api Key", null, invalidApiKeyError))
        .catch(error => res.createResponse("Invalid Api Key", null, error));
};

let validateKey = (req, res, action) => {
    User.findOne({apiKey: req.query.apiKey})
        .then(data => data ? action() : res.createResponse("Invalid Api Key", null, invalidApiKeyError))
        .catch(error => res.createResponse("Invalid Api Key", null, error));
};

exports.validateKey = validateKey;
