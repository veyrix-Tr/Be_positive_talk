const mongoose = require("mongoose");

const TransactionSchema = new mongoose.Schema({

  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },

  type: String,

  tokens: Number,

  amount: Number,

  description: String,

  createdAt: {
    type: Date,
    default: Date.now
  }

});

module.exports = mongoose.model("Transaction", TransactionSchema);