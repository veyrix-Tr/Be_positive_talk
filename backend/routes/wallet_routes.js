const express = require("express");
const router = express.Router();

const walletController = require("../controllers/wallet_controller");
const authMiddleware = require("../middleware/auth_middleware");


router.get("/", authMiddleware, walletController.getWalletBalance);

router.get("/transactions", authMiddleware, walletController.getTransactionHistory);

router.post("/add-tokens", authMiddleware, walletController.addTokens);

module.exports = router;