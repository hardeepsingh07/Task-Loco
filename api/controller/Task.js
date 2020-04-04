const Task = require('../model/Task');
const utils = require('../util/Utils');
const _ = require('lodash');

exports.create = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespondWithArray("New Task Creation", createTask(req).save())
    });
};

exports.update = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespondWithArray("Task Update",
            Task.findByIdAndUpdate(req.params.taskId, req.body, {new: true}))
    });
};

exports.tasks = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch All Tasks", Task.find())
    });
};

exports.userTask = function (req, res) {
    req.validateKey(res, () => {
        Task.find({"responsible.username": req.params.username, status: { $ne: "Closed"}})
            .then(data => {
                res.createResponse("Fetch Today Tasks Successful", filterData(data), null)
            })
            .catch(error => res.createResponse("Fetch Today Tasks Failed", null, error));
    });
};

exports.archive = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch Closed Tasks", Task.find({status: "Closed"}))
    });
};

exports.filter = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Filter Tasks", Task.find({
            priority: {$regex: req.query.priority ? req.query.priority : "$", $options: 'i'},
            status: {$regex: req.query.status ? req.query.status : "$", $options: 'i'},
            "responsible.username": {$regex: req.query.username ? req.query.username : "$", $options: 'i'}
        }))
    });
};

exports.remove = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Remove Tasks", Task.findByIdAndRemove(req.params.taskId))
    });
};

function createTask(req) {
    return new Task({
        title: req.body.title,
        description: req.body.description,
        completed: req.body.completed,
        completeBy: req.body.completeBy,
        assignee: req.body.assignee,
        responsible: {username: req.body.responsible.username, name: req.body.responsible.name},
        status: req.body.status
    });
}

function filterData(data) {
    let highPriority = data.filter(task => task.priority === "High" && task.status !== "Completed");
    let inProgress = data.filter(task => task.priority === "Standard" && task.status === "In Progress");
    let pending = data.filter(task => task.priority === "Standard" && task.status === "Pending");
    let completed = data.filter(task => task.status === "Completed");
    return _.union(highPriority, inProgress, pending, completed);
}

