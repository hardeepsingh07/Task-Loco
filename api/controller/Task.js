const Task = require('../model/Task');
const utils = require('../util/Utils');

exports.create = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("New Task Creation", createTask(req).save())
    });
};

exports.update = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Task Update",
            Task.findByIdAndUpdate(req.params.taskId, req.body, {new: true}))
    });
};

exports.tasks = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch All Tasks", Task.find())
    });
};

exports.todayTasks = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch Today Tasks",
            Task.find({responsible: req.params.username, completeBy: new Date().toLocaleDateString()}))
    });
};

exports.tasksCompleted = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch Completed Tasks", Task.find({status: "Completed"}))
    });
};

exports.tasksPending = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch Pending Tasks", Task.find({status: "Pending"}))
    });
};

exports.tasksInProgress = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch In Progress Tasks", Task.find({status: "In Progress"}))
    });
};

exports.tasksHighPriority = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch High Priority Tasks", Task.find({priority: "High"}))
    });
};

exports.tasksStandardPriority = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch Standard Priority Tasks", Task.find({priority: "Standard"}))
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
        responsible: req.body.responsible,
        status: req.body.status
    });
}

