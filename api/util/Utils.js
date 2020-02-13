const User = require('../model/User');
const invalidApiKeyError = Error("Invalid Api Key");

exports.respond = (res, message, data, error) => {
    console.log(`${message}: ${error ? error : JSON.stringify(data)}`);
    res.send({
        "response": data ? 200 : 250,
        "message": message,
        "data": data,
        "error": error
    })
};

exports.validateKey = (req, res, action) => {
    User.find({apiKey: req.query.apiKey})
        .then(data => action())
        .catch(error => respond(res, "New Task Creation Failed", null, invalidApiKeyError));
};