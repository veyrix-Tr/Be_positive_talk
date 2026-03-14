const mongoose = require("mongoose");

const ReferralSchema = new mongoose.Schema({

  referrerUserId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },

  referredUserId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },

  rewardTokens: Number,

  status: {
    type: String,
    default: "pending"
  },

  createdAt: {
    type: Date,
    default: Date.now
  }

});

module.exports = mongoose.model("Referral", ReferralSchema);