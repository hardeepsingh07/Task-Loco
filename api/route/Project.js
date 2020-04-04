const express = require('express');
let router = express.Router();
const project = require('../controller/Project');

router.post("/", project.create);
router.get('/all', project.all);
router.get("/id/:projectId", project.project);
router.get("/:username", project.userProjects);
router.delete("/:projectId", project.remove);

module.exports = router;