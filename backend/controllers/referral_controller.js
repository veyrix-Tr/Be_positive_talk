const Referral = require("../models/Referral");

exports.getReferralHistory = async (req, res) => {

  try {

    const userId = req.user.id;

    const referrals = await Referral.find({
      referrerUserId: userId
    }).populate("referredUserId", "phoneNumber name");

    res.json({
      success: true,
      referrals
    });

  } catch (error) {

    res.status(500).json({
      success: false,
      message: error.message
    });

  }

};