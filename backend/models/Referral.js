const mongoose = require("mongoose");

const referralSchema = new mongoose.Schema({

    referrerUserId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true
    },

    referredUserId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true
    },

    rewardTokens: {
        type: Number,
        default: 50
    },

    status: {
        type: String,
        default: "completed"
    },

    createdAt: {
        type: Date,
        default: Date.now
    }

});

module.exports = mongoose.model("Referral", referralSchema);