const express = require('express');
let router = express.Router();
const user = require('../controller/User');

router.post("/", user.create);
router.get("/names", user.userNames);
router.get("/login", user.login);
router.remove("/remove", user.remove);

module.exports = router;