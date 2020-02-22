const express = require('express');
let router = express.Router();
const task = require('../controller/Task');

router.post("/", task.create);
router.post("/:taskId", task.update);
router.get("/all", task.tasks);
router.get("/status/completed", task.tasksCompleted);
router.get("/status/pending", task.tasksPending);
router.get("/status/inprogress", task.tasksInProgress);
router.get("/priority/high", task.tasksHighPriority);
router.get("/priority/standard", task.tasksStandardPriority);
router.delete("/:taskId", task.remove);

module.exports = router;