const Task = require('../model/Task');

//Create Task with Username and Today Date
exports.createTasksWithUsername = (username) => {
    let date = new Date();
    for (var i = 0; i < 10; i++) {
        new Task({
            title: "Task " + username + " " + i,
            description: "Task Description " + i,
            completeBy: date.toLocaleDateString(),
            assignee: "Hardeep " + i,
            responsible: username,
            priority: i % 2 === 0 ? "High" : "Standard",
            status: i % 2 === 0 ? "Pending" : "In Progress"
        }).save()
    }
    console.log("Generated " + username + " Tasks")
};

//Create Pending Tasks (even High Priority, odd Standard Priority)
exports.createPendingTasks = (startIndex) => {
    for (var i = startIndex; i < startIndex + 10; i++) {
        new Task({
            title: "Task " + i,
            description: "Task Description " + i,
            completeBy: new Date().addDays(i),
            assignee: "Hardeep " + i,
            responsible: i % 2 === 0 ? "Sona " + i : "",
            priority: i % 2 === 0 ? "High" : "Standard",
            status: "Pending"
        }).save()
    }
    console.log("Generated Pending Tasks")
};

//Create In-Progress Tasks (even High Priority, odd Standard Priority)
exports.createInProgressTasks = (startIndex) => {
    for (var i = startIndex; i < startIndex + 10; i++) {
        new Task({
            title: "Tweet " + i,
            description: "Tweet Description " + i,
            completeBy: new Date().addDays(i),
            assignee: "Sona " + i,
            responsible: i % 2 === 0 ? "Sahindeep " + i : "",
            priority: i % 2 === 0 ? "High" : "Standard",
            status: "In Progress"
        }).save()
    }
    console.log("Generated InProgress Tasks")
};

//Create Completed Tasks (even High Priority, odd Standard Priority)
exports.createCompletedTasks = (startIndex) => {
    for (var i = startIndex; i < startIndex + 10; i++) {
        new Task({
            title: "Story " + i,
            description: "Story Description " + i,
            completeBy: new Date().addDays(i),
            assignee: "Sahibdeep " + i,
            responsible: i % 2 === 0 ? "Sona " + i : "",
            priority: i % 2 === 0 ? "High" : "Standard",
            status: "Completed"
        }).save();
    }
    console.log("Generated Completed Tasks")
};


// Get Date with Days
Date.prototype.addDays = function(days) {
    this.setDate(this.getDate() + parseInt(days));
    return this;
};