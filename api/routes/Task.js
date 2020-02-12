const express = require('express');
let router = express.Router();
const task = require('../controller/Task');

router.get("/", task.create);

module.exports = router;