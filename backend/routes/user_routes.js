const express = require("express");

const router = express.Router();

const userController = require("../controllers/user_controller");

const authMiddleware = require("../middleware/auth_middleware");

router.post(
  "/test-notification",
  authMiddleware,
  userController.testNotification
);

router.post(
  "/device-token",
  authMiddleware,
  userController.saveDeviceToken
);

router.get(
  "/profile",
  authMiddleware,
  userController.getProfile
);

router.put(
  "/profile",
  authMiddleware,
  userController.updateProfile
);

router.get(
  "/referral-code",
  authMiddleware,
  userController.getReferralCode
);

module.exports = router;