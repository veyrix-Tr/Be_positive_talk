const jwt = require("jsonwebtoken");
const User = require("../models/User");

let otpStore = {};

exports.sendOTP = async (req, res) => {

  console.log(req.body);
  const { phoneNumber } = req.body;

  const otp = "123456"; // simulated OTP

  otpStore[phoneNumber] = otp;

  res.json({
    message: "OTP sent successfully",
    otp: otp
  });
};

exports.verifyOTP = async (req, res) => {

  const { phoneNumber, otp, referralCode } = req.body;
  
  if (otpStore[phoneNumber] !== otp) {
    return res.status(400).json({ message: "Invalid OTP" });
  }

  console.log("OTP verified successfully");

  let user = await User.findOne({ phoneNumber });


  if (!user) {
    let referrer = null;

    if (referralCode) {
      referrer = await User.findOne({
        referralCode: referralCode
      });
    }

    user = await User.create({
      phoneNumber,
      referralCode: generateReferralCode(),
      referredBy: referrer ? referrer._id : null
    });
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

const generateReferralCode = () => {

  const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

  let code = "";

  for (let i = 0; i < 8; i++) {

    code += chars.charAt(Math.floor(Math.random() * chars.length));

  }

  return code;
};