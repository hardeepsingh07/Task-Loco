const express = require('express');
let router = express.Router();
const task = require('../controller/Task');

router.post("/", task.create);
router.post("/:taskId/updates", task.update);
router.get("/all", task.tasks);
router.get("/completed", task.tasksCompleted);
router.get("/pending", task.tasksPending);
router.get("/inprogress", task.tasksInProgress);
router.delete("/:taskId", task.remove);

module.exports = router;