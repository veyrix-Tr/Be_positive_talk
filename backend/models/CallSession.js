const mongoose = require("mongoose");

const CallSessionSchema = new mongoose.Schema({

  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },

  vendorId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Vendor"
  },

  startTime: Date,

  endTime: Date,

  durationSeconds: Number,

  tokensSpent: Number,

  status: {
    type: String,
    default: "active"
  }

});

module.exports = mongoose.model("CallSession", CallSessionSchema);