const mongoose = require("mongoose");

const MessageSchema = new mongoose.Schema({

  senderId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },

  receiverId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Vendor"
  },

  text: String,

  timestamp: {
    type: Date,
    default: Date.now
  },

  isRead: {
    type: Boolean,
    default: false
  }

});

module.exports = mongoose.model("Message", MessageSchema);