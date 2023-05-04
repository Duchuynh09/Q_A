const express = require("express");
const user = require("../controller/user.controller");
const router = express.Router();

router.route("/").post(user.create);
router.route("/:id").get(user.findOne);
router.route("/login").post(user.checkLogin);
module.exports = router;
