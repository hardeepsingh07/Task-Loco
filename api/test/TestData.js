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
            assignee: {username: "Hardeep " + i, name: "Hardeep " + i},
            responsible: {username: "singhha", name: "Hardeep Singh"},
            priority: priority[priorityIndex],
            status: status[statusIndex],
            closed: false
        }).save()
    }
    console.log("Generated " + username + " Tasks")
};

exports.createCloseTasks = (startIndex) => {
    let priority = ["High", "Standard"];
    let status = ["Pending", "In Progress", "Completed"];

    let date = new Date();
    for (var i = 0; i < 20; i++) {
        let priorityIndex = Math.floor(Math.random() * priority.length);
        let statusIndex = Math.floor(Math.random() * status.length);
        new Task({
            title: "Task Hardeep" + i,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sin laboramus, quis est, qui alienae modum statuat industriae? Laboro autem non sine causa; Tum mihi Piso: Quid ergo? Et quidem illud ipsum non nimium probo et tantum patior, philosophum loqui de cupiditatibus finiendis.",
            completeBy: date.toLocaleDateString(),
            assignee: {username: "Hardeep " + i, name: "Hardeep " + i},
            responsible: {username: "Hardeep " + i, name: "Hardeep " + i},
            priority: priority[priorityIndex],
            status: status[statusIndex],
            closed: true
        }).save()
    }
    console.log("Generated Closed Tasks")
};

// Get Date with Days
Date.prototype.addDays = function(days) {
    this.setDate(this.getDate() + parseInt(days));
    return this.toLocaleDateString();
};