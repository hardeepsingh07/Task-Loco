const express = require('express');
let router = express.Router();
const task = require('../controller/Task');

router.post("/", task.create);
router.post("/:taskId", task.update);
router.get("/all", task.tasks);
router.get("/user/:username/:projectId", task.userTask);
router.get("/filter/:projectId", task.filter);
router.get("/archive", task.archive);
router.delete("/:taskId", task.remove);

module.exports = router;