const express = require('express');
let router = express.Router();
const task = require('../controller/Task');

router.post("/", task.create);
router.post("/updatestatus", task.updateStatus);
router.post("/updatecompleted", task.updateCompleted);
router.post("/updateresponsible", task.updateResponsible);
router.get("/all", task.tasks);
router.get("/completed", task.tasksCompleted);
router.get("/pending", task.tasksPending);
router.get("/inprogress", task.tasksInProgress);
router.delete("/:taskId", task.remove);

module.exports = router;