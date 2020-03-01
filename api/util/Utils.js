const User = require('../model/User');
const invalidApiKeyError = {name: "InvalidApiKey", message: "Api Key doesn't not exist. Login for new Api Key or confirm your existing Api key"};

let respond = (res, message, data, error) => {
    console.log(`${message}: ${error ? error : JSON.stringify(data)}`);
    let outwardError = error ? {name: "Error Occurred", message: message} : null;
    res.send({
        "response": data ? 200 : 250,
        "message": message,
        "data": data,
        "error": outwardError
    })
};

let validateKey = (req, res, action) => {
    User.findOne({apiKey: req.query.apiKey})
        .then(data => data ? action() : respond(res, "Invalid Api Key", null, invalidApiKeyError))
        .catch(error => respond(res, "Invalid Api Key", null, error));
};

exports.respond = respond;
exports.validateKey = validateKey;
