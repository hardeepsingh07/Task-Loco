const User = require('../model/User');
const Task = require('../model/Task');
const Project = require('../model/Project');
const keyGenerator = require('random-key-generator');

exports.initDate = (users, projects, tasks) => {
    let hardeep = {username: "hardeep", name: "Hardeep Singh"};
    let sahib = {username: "sahib", name: "Sahibdeep Singh"};
    let sona = {username: "sona", name: "Sandeep Kaur"};
    let ranjit = {username: "ranjit", name: "Ranjit Kaur"};
    let kamal = {username: "kamal", name: "Kamaljeet Kaur"};
    let projectIds;

    createUser(hardeep);
    createUser(sahib);
    createUser(sona);
    createUser(ranjit);
    createUser(kamal);

    projectIds = [createProjects("Thanos", [sahib, sona, kamal, hardeep], false),
        createProjects("Devil", [ranjit, sona, hardeep], false),
        createProjects("Spectre", [sahib, ranjit, hardeep], true),
        createProjects("Vale", [sona, ranjit, kamal, hardeep], false),
        createProjects("RedSkull", [sahib, hardeep, sona], false)];

    createTask(projectIds[random(projectIds.length)], sona);
    createTask(projectIds[random(projectIds.length)], sahib);
    createTask(projectIds[random(projectIds.length)], hardeep);
    createTask(projectIds[random(projectIds.length)], kamal);
    createTask(projectIds[random(projectIds.length)], ranjit);
};

function random(max) {
    return Math.floor(Math.random() * max)
}

function createUser(user) {
    new User({
        username: user.username,
        name: user.name,
        email: user.name + "@gmail.com",
        password: user.username,
        apiKey: keyGenerator(32)
    }).save();
    console.log(user.name + " User Created!")
}

function createProjects(name, users, starred) {
    let projectId = name.substring(0, 4) + "-" + Math.floor(Math.random() * 999);
    new Project({
        name: name,
        projectId: projectId,
        description: "This project, with name " + name + " is descriptive project",
        users: users,
        starred: starred,
        autoClose: false
    }).save();
    console.log(name + " Project Created!");
    return projectId;
}

function createTask(projectId, responsible) {
    let assignee = {username: "api", name: "Task Loco Api"};
    let priority = ["High", "Standard"];
    let status = ["Pending", "In Progress", "Completed", "Closed"];

    for (let i = 0; i < 10; i++) {
        let entry = random(999);
        new Task({
            projectId: projectId,
            title: "Task " + responsible.username + " " + entry,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sin laboramus, quis est, qui " +
                "alienae modum statuat industriae? Laboro autem non sine causa; Tum mihi Piso: Quid ergo? Et quidem " +
                "illud ipsum non nimium probo et tantum patior, philosophum loqui de cupiditatibus finiendis.",
            completeBy: new Date().toLocaleDateString(),
            assignee: assignee,
            responsible: responsible,
            priority: priority[random(priority.length)],
            status: status[random(status.length)]
        }).save();
        console.log("Task " + responsible.username + " " + entry + " Created!")
    }
}