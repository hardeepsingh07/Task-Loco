const User = require('../model/User');
const Task = require('../model/Task');
const Project = require('../model/Project');
const keyGenerator = require('random-key-generator');

exports.initData = () => {
    let test1 = {username: "test1", name: "Test 1"};
    let test2 = {username: "test2", name: "Test 2"}
    let test3 = {username: "test3", name: "Test 3"};
    let test4 = {username: "test4", name: "Test 4"};
    let test5 = {username: "test5", name: "Test 5"};
    let test6 = {username: "test6", name: "Test 6"};

    createUser(test1);
    createUser(test2);
    createUser(test3);
    createUser(test4);
    createUser(test5);
    createUser(test6);

    createProject("Thanos", [test3, test4, test6, test1], false)
    createProject("Devil", [test5, test4, test1, test2], false)
    createProject("Spectre", [test3, test5, test1], true)
    createProject("Vale", [test4, test5, test2, test6, test1], false)
    createProject("RedSkull", [test3, test1, test4, test2], false)
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