const Project = require('../model/Project');
const utils = require('../util/Utils');

exports.create = function (req, res) {
    req.validateKey(res, () => {
        Project.exists({projectId: req.body.projectId})
            .then(exists => {
                exists
                    ? res.createResponse("New Project Creation Failed", null, projectExistsError())
                    : res.generateAndRespondWithArray("New Project Creation", createProject(req).save());
            }).catch(error => res.createResponse("New Project Creation Failed", null, projectExistsError()));
    });
};

exports.all = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch all Projects", Project.find());
    });
};

exports.addMember = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespondWithArray("Add Member to Project",
            Project.findOneAndUpdate(
                {projectId: req.params.projectId},
                {$push: {users: req.body}},
                {new: true}
            )
        );
    });
};

exports.removeMember = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Remove Member to Project",
            Project.findOneAndUpdate(
                {projectId: req.params.projectId},
                {$pull: {users: req.body}},
                {new: true}
            )
        );
    });
};

exports.userProjects = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch User Project", Project.find({'users.username': req.params.username}))
    });
};

exports.project = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespond("Fetch Project", Project.find({projectId: req.params.projectId}))
    });
};

exports.remove = function (req, res) {
    req.validateKey(res, () => {
        res.generateAndRespondWithArray("Project Remove", Project.findOneAndRemove({projectId: req.params.projectId}))
    });
};

function createProject(req) {
    return new Project({
        name: req.body.name,
        projectId: req.body.projectId,
        description: req.body.description,
        users: req.body.users,
        starred: req.body.starred
    })
}

function projectExistsError() {
    let error = Error();
    error.name = "Project already Exists";
    error.message = "Project already exists, please choose an another Project Name.";
    return error;
}

