exports.respond = (res, message, data, error) => {
    console.log(message + ": " + error ? error : data.id);
    res.send({
        "response": data ? 200 : 250,
        "message": message,
        "data": data,
        "error": error
    })
};

exports.validKey = (req, data) => {
    return req.query.apiKey === data.apiKey
}