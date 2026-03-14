const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema({
  phoneNumber: {
    type: String,
    required: true,
    unique: true
  },

  name: {
    type: String,
    default: ""
  },

  profileImage: {
    type: String,
    default: ""
  },

  tokenBalance: {
    type: Number,
    default: 0
  },

  referralCode: {
    type: String
  },

  createdAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model("User", UserSchema);