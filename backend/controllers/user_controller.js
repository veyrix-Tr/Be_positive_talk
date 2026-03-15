const User = require("../models/User");

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