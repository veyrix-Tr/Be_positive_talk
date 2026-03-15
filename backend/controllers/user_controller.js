const User = require("../models/User");
const { sendNotification } = require("../services/notification_service");

exports.testNotification = async (req, res) => {
  try {
    await sendNotification(
      req.user.userId,
      "Test Notification",
      "Backend notification working"
    );
    res.json({
      success: true,
      message: "Test notification sent"
    });

  } catch (error) {

    console.error("Test notification error:", error);
    res.status(500).json({
      success: false,
      message: "Failed to send notification"
    });
  }
};

exports.getProfile = async (req, res) => {

  try {

    const user = await User.findById(req.user.userId).select("-__v");
    // console.log(req);
    res.json({
      success: true,
      user
    });

  } catch (error) {

    res.status(500).json({
      success: false,
      message: error.message
    });

  }

};

exports.updateProfile = async (req, res) => {

  try {

    const { name, profileImage } = req.body;

    const user = await User.findByIdAndUpdate(
      req.user.userId,
      { name, profileImage },
      { new: true }
    );

    res.json({
      success: true,
      user
    });

  } catch (error) {

    res.status(500).json({
      success: false,
      message: error.message
    });

  }

};

exports.getReferralCode = async (req, res) => {

  try {

    const user = await User.findById(req.user.userId);

    res.json({
      success: true,
      referralCode: user.referralCode
    });

  } catch (error) {

    res.status(500).json({
      success: false,
      message: error.message
    });

  }

};

exports.saveDeviceToken = async (req, res) => {

  try {

    const userId = req.user.userId;
    const { deviceToken } = req.body;

    if (!deviceToken) {
      return res.status(400).json({
        message: "Device token required"
      });
    }

    await User.findByIdAndUpdate(userId, {
      deviceToken: deviceToken
    });

    res.json({
      message: "Device token saved successfully"
    });

  } catch (error) {

    res.status(500).json({
      message: "Server error"
    });

  }

};