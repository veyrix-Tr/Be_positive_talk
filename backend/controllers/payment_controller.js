const crypto = require("crypto");
const { createRazorpayOrder } = require("../services/payment_service");
const User = require("../models/User");
const Transaction = require("../models/Transaction");

exports.createOrder = async (req, res) => {
  try {
    const { amount } = req.body;
    const order = await createRazorpayOrder(amount);

    res.json({
      success: true,
      order
    });

  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

exports.verifyPayment = async (req, res) => {

  try {

    const {
      razorpay_order_id,
      razorpay_payment_id,
      razorpay_signature,
      tokens
    } = req.body;

    const body = razorpay_order_id + "|" + razorpay_payment_id;

    const expectedSignature = crypto
      .createHmac("sha256", process.env.RAZORPAY_KEY_SECRET)
      .update(body.toString())
      .digest("hex");

    if (expectedSignature !== razorpay_signature) {

      return res.status(400).json({
        success: false,
        message: "Invalid payment signature"
      });
    }


    const userId = req.user.userId;
    const user = await User.findById(userId);

    user.tokenBalance += tokens;

    await user.save();

    await Transaction.create({
      userId,
      type: "purchase",
      tokens,
      amount: tokens,
      description: "Token purchase"
    });

    res.json({
      success: true,
      message: "Payment verified and wallet updated"
    });

  } catch (error) {

    res.status(500).json({
      success: false,
      message: error.message
    });

  }
};

