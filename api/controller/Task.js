const Task = require('../model/Task');
const utils = require('../util/Utils');
const _ = require('lodash');

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
        Task.find({responsible: req.params.username, completeBy: new Date().toLocaleDateString()})
            .then(data => {
                let highPriority = data.filter(task => task.priority === "High" && task.status !== "Completed");
                let inProgress = data.filter(task => task.priority === "Standard" && task.status === "In Progress");
                let pending = data.filter(task => task.priority === "Standard" && task.status === "Pending");
                let completed = data.filter(task => task.status === "Completed");
                let result = _.union(highPriority, inProgress, pending, completed);
                res.createResponse("Fetch Today Tasks Successful", result, null)
            })
            .catch(error => res.createResponse("Fetch Today Tasks Failed", null, error));
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

