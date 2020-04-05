const express = require('express');
let router = express.Router();
const project = require('../controller/Project');

router.post("/", project.create);
router.get('/all', project.all);
router.post('/add/:projectId', project.addMember);
router.post('/remove/:projectId', project.removeMember);
router.post('/update/:projectId', project.updateProject);
router.get("/id/:projectId", project.project);
router.get("/:username", project.userProjects);
router.delete("/:projectId", project.remove);

module.exports = router;