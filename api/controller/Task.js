const Task = require('../model/Task');

exports.create = function (req, res) {
    createTask(req).save()
        .then(data => response(res, "New Task Created Successfully" + data.id, data, null))
        .catch(error => response(res, "New Task Creation Failed" + error, null, error))
};

exports.update = function (req, res) {
    Task.findByIdAndUpdate(req.params.taskId, req.body, {new: true})
        .then(data => response(res, "Task Update Successfully" + data.id, data, null))
        .catch(error => response(res, "Task Update Failed", null, error))
};

exports.tasks = function (req, res) {
    Task.find()
        .then(data => response(res, "Task Update Successfully", data, null))
        .catch(error => response(res, "Task Update Failed", null, error))
};

exports.tasksCompleted = function (req, res) {
    Task.find({status: "Completed"})
        .then(data => response(res, "Fetching Completed Tasks Successful", data, null))
        .catch(error => response(res, "Fetching Completed Tasks Failed", null, error))
};

exports.tasksPending = function (req, res) {
    Task.find({status: "Pending"})
        .then(data => response(res, "Fetching Pending Tasks Successful", data, null))
        .catch(error => response(res, "Fetching Pending Tasks Failed" + error, null, error))
};

exports.tasksInProgress = function (req, res) {
    Task.find({status: "In Progress"})
        .then(data => response(res, "Fetching In Progress Tasks Successful", data, null))
        .catch(error => response(res, "Fetching In Progress Tasks Failed" + error, null, error))
};

exports.remove = function (req, res) {
    Task.findByIdAndRemove(req.params.taskId)
        .then(data => response(res, "Removing Tasks Successful", data, null))
        .catch(error => response(res, "Removing Tasks Failed" + error, null, error))
};

function createTask(req) {
    return new Task({
        title: req.body.title,
        description: req.body.description,
        completed: req.body.completed,
        completeBy: req.body.completeBy,
        assignee: req.body.assignee,
        responsible: req.body.responsible,
        status: req.body.status
    });
}

function response(res, message, data, error) {
    console.log(message + ": " + error ? error : data.id);
    res.send({
        "response": data ? 200 : 250,
        "message": message,
        "data": data,
        "error": error
    });
}

