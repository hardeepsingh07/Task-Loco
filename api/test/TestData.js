const Task = require('../model/Task');

//Create Task with Username and Today Date
exports.createTasksWithUsername = (username) => {
    let priority = ["High", "Standard"];
    let status = ["Pending", "In Progress", "Completed"];

    let date = new Date();
    for (var i = 0; i < 20; i++) {
        let priorityIndex = Math.floor(Math.random() * priority.length);
        let statusIndex = Math.floor(Math.random() * status.length);
        new Task({
            title: "Task " + username + " " + i,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sin laboramus, quis est, qui alienae modum statuat industriae? Laboro autem non sine causa; Tum mihi Piso: Quid ergo? Et quidem illud ipsum non nimium probo et tantum patior, philosophum loqui de cupiditatibus finiendis.",
            completeBy: date.toLocaleDateString(),
            assignee: "Hardeep " + i,
            responsible: username,
            priority: priority[priorityIndex],
            status: status[statusIndex]
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
    return this.toLocaleDateString();
};