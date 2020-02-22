const Task = require('../model/Task');
const Util = require('../util/Utils');

exports.create = function (req, res) {
    Util.validateKey(req, res, () => {
        createTask(req)
            .save()
            .then(data => Util.respond(res, "New Task Created Successfully", data, null))
            .catch(error => Util.respond(res, "New Task Creation Failed" + error, null, error))
    });
};

exports.update = function (req, res) {
    Util.validateKey(req, res, () => {
        Task.findByIdAndUpdate(req.params.taskId, req.body, {new: true})
            .then(data => Util.respond(res, "Task Update Successfully", data, null))
            .catch(error => Util.respond(res, "Task Update Failed", null, error))
    });
};

exports.tasks = function (req, res) {
    Util.validateKey(req, res, () => {
        Task.find()
            .then(data => Util.respond(res, "Task Update Successfully", data, null))
            .catch(error => Util.respond(res, "Task Update Failed", null, error))
    });
};

exports.tasksCompleted = function (req, res) {
    Util.validateKey(req, res, () => {
        Task.find({status: "Completed"})
            .then(data => Util.respond(res, "Fetching Completed Tasks Successful", data, null))
            .catch(error => Util.respond(res, "Fetching Completed Tasks Failed", null, error))
    });
};

exports.tasksPending = function (req, res) {
    Util.validateKey(req, res, () => {
        Task.find({status: "Pending"})
            .then(data => Util.respond(res, "Fetching Pending Tasks Successful", data, null))
            .catch(error => Util.respond(res, "Fetching Pending Tasks Failed" + error, null, error))
    });
};

exports.tasksInProgress = function (req, res) {
    Util.validateKey(req, res, () => {
        Task.find({status: "In Progress"})
            .then(data => Util.respond(res, "Fetching In Progress Tasks Successful", data, null))
            .catch(error => Util.respond(res, "Fetching In Progress Tasks Failed" + error, null, error))
    });
};

exports.tasksHighPriority = function (req, res) {
    Util.validateKey(req, res, () => {
        Task.find({priority: "High"})
            .then(data => Util.respond(res, "Fetching High Priority Tasks Successful", data, null))
            .catch(error => Util.respond(res, "Fetching High Priority Tasks Failed" + error, null, error))
    });
};

exports.tasksStandardPriority = function (req, res) {
    Util.validateKey(req, res, () => {
        Task.find({priority: "standard"})
            .then(data => Util.respond(res, "Fetching Standard Priority Tasks Successful", data, null))
            .catch(error => Util.respond(res, "Fetching Standard Priority Tasks Failed" + error, null, error))
    });
};

exports.remove = function (req, res) {
    Util.validateKey(req, res, () => {
        Task.findByIdAndRemove(req.params.taskId)
            .then(data => Util.respond(res, "Removing Tasks Successful", data, null))
            .catch(error => Util.respond(res, "Removing Tasks Failed" + error, null, error))
    });
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

