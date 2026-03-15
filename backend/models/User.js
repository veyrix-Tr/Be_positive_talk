const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({

  phoneNumber: String,

  name: String,

  profileImage: String,

  tokenBalance: {
    type: Number,
    default: 0
  },

  referralCode: {
    type: String,
    unique: true
  },

  referredBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    default: null
  },

  firstPurchaseCompleted: {
    type: Boolean,
    default: false
  },

  createdAt: {
    type: Date,
    default: Date.now
  }

});

module.exports = mongoose.model("User", userSchema);