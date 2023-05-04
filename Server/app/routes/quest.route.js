const express = require("express")
const quest = require("../controller/quest.Controller")

const router = express.Router()

router.route("/")
    .get(quest.findALl)
    .post(quest.create)
router.route("/:id")
    .get(quest.findOne)
    .put(quest.update)
    .delete(quest.delete)
module.exports = router;