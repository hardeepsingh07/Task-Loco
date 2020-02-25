const express = require('express');
let router = express.Router();
const user = require('../controller/User');

router.post("/", user.create);
router.post('/logout', user.logout);
router.get("/names", user.userNames);
router.post("/login", user.login);
router.get("/:username", user.getUser);
router.delete("/:username", user.remove);

module.exports = router;