const express = require("express");
const router = express.Router();

const chatController = require("../controllers/chat_controller");
const authMiddleware = require("../middleware/auth_middleware");

router.get(
  "/history/:userId/:vendorId",
  authMiddleware,
  chatController.getChatHistory
);

module.exports = router;
