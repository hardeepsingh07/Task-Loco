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
        Task.find({"responsible.username": req.params.username})
            .then(data => {
                res.createResponse("Fetch Today Tasks Successful", filterData(data), null)
            })
            .catch(error => res.createResponse("Fetch Today Tasks Failed", null, error));
    });
};

exports.archive = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch Closed Tasks", Task.find({closed: true}))
    });
};

exports.statusTask = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch Completed Tasks", Task.find({status: req.params.status}))
    });
};

exports.highPriorityWithStatus = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch High Priority Status Tasks", Task.find({priority: "High", status: req.params.status}))
    });
};

exports.standardPriorityWithStatus = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch Standard Priority Status Tasks", Task.find({priority: "Standard", status: req.params.status}))
    });
};

exports.priorityTask = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch High Priority Tasks", Task.find({priority: req.params.priority}))
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
    let highPriority = data.filter(task => task.priority === "High" && task.status !== "Completed" && !task.closed);
    let inProgress = data.filter(task => task.priority === "Standard" && task.status === "In Progress" && !task.closed);
    let pending = data.filter(task => task.priority === "Standard" && task.status === "Pending" && !task.closed);
    let completed = data.filter(task => task.status === "Completed" && !task.closed);
    return _.union(highPriority, inProgress, pending, completed);
}

