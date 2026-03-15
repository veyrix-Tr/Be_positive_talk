const express = require("express");
const router = express.Router();

const paymentController = require("../controllers/payment_controller");
const authMiddleware = require("../middleware/auth_middleware");

router.post(
    "/create-order",
    authMiddleware,
    paymentController.createOrder
);

router.post(
    "/verify-payment",
    authMiddleware,
    paymentController.verifyPayment
);

module.exports = router;