const express = require("express");

const router = express.Router();

const referralController = require("../controllers/referral_controller");

const authMiddleware = require("../middleware/auth_middleware");

router.get(
  "/history",
  authMiddleware,
  referralController.getReferralHistory
);

module.exports = router;