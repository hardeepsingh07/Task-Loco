const express = require('express');
let router = express.Router();
const user = require('../controller/User');

router.get("/", user.create);

module.exports = router;