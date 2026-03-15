const crypto = require("crypto");
const { createRazorpayOrder } = require("../services/payment_service");
const User = require("../models/User");
const Transaction = require("../models/Transaction");
const Referral = require("../models/Referral");
const { sendNotification } = require("../services/notification_service");

const REFERRAL_REWARD = 50;
const DISCOUNT_TOKENS = 20;

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

    if (!user.firstPurchaseCompleted) {
      user.firstPurchaseCompleted = true;

      if (user.referredBy) {
        const referrer = await User.findById(user.referredBy);
        
        referrer.tokenBalance += REFERRAL_REWARD;
        user.tokenBalance += DISCOUNT_TOKENS;
        
        await referrer.save();
        
        await Referral.create({
          referrerUserId: referrer._id,
          referredUserId: user._id,
          rewardTokens: REFERRAL_REWARD,
          status: "completed"
        });

        // Send referral reward notification
        await sendNotification(
          referrer._id,
          "Referral Reward",
          "You earned referral tokens"
        );
      }
    }

    await user.save();

    await Transaction.create({
      userId,
      type: "purchase",
      tokens,
      amount: tokens,
      description: "Token purchase"
    });

    // Send payment success notification
    await sendNotification(
      userId,
      "Payment Successful",
      "Your wallet has been credited"
    );

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

