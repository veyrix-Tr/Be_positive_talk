const jwt = require("jsonwebtoken");
const User = require("../models/User");

let otpStore = {};

exports.sendOTP = async (req, res) => {

  const { phoneNumber } = req.body;

  const otp = "123456"; // simulated OTP

  otpStore[phoneNumber] = otp;

  res.json({
    message: "OTP sent successfully",
    otp: otp
  });
};

exports.verifyOTP = async (req, res) => {

  const { phoneNumber, otp } = req.body;

  if (otpStore[phoneNumber] !== otp) {
    return res.status(400).json({ message: "Invalid OTP" });
  }

  let user = await User.findOne({ phoneNumber });

  if (!user) {
    user = await User.create({ phoneNumber });
  }

  const token = jwt.sign(
    { userId: user._id },
    process.env.JWT_SECRET,
    { expiresIn: "7d" }
  );

  res.json({
    message: "Login successful",
    token: token,
    user: user
  });

};

