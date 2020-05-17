const User = require('../model/User');
const Task = require('../model/Task');
const Project = require('../model/Project');
const keyGenerator = require('random-key-generator');

exports.initData = () => {
    let hardeep = {username: "hardeep", name: "Hardeep Singh"};
    let sukhi = {username: "sukhi", name: "Sukhwinder Kaur"}
    let sahib = {username: "sahib", name: "Sahibdeep Singh"};
    let sona = {username: "sona", name: "Sandeep Kaur"};
    let ranjit = {username: "ranjit", name: "Ranjit Kaur"};
    let kamal = {username: "kamal", name: "Kamaljeet Kaur"};

    createUser(hardeep);
    createUser(sukhi);
    createUser(sahib);
    createUser(sona);
    createUser(ranjit);
    createUser(kamal);

    createProject("Thanos", [sahib, sona, kamal, hardeep], false)
    createProject("Devil", [ranjit, sona, hardeep, sukhi], false)
    createProject("Spectre", [sahib, ranjit, hardeep], true)
    createProject("Vale", [sona, ranjit, sukhi, kamal, hardeep], false)
    createProject("RedSkull", [sahib, hardeep, sona, sukhi], false)
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

function createProject(name, users, starred) {
    let projectId = name.substring(0, 4) + "-" + Math.floor(Math.random() * 999);
    let project = new Project({
        name: name,
        projectId: projectId,
        description: "This project, with name " + name + " is descriptive project",
        users: users,
        starred: starred,
        autoClose: false
    })
    project.save();
    console.log(name + " Project Created!");

    for (let i = 0; i < project.users.length; i++) {
        createTask(project.projectId, project.users[i]);
    }
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