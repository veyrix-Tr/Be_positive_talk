const mongoose = require("mongoose");

const VendorSchema = new mongoose.Schema({

  name: String,

  gender: String,

  age: Number,

  rating: {
    type: Number,
    default: 0
  },

  totalReviews: {
    type: Number,
    default: 0
  },

  description: String,

  experienceHours: {
    type: Number,
    default: 0
  },

  ratePerMinute: Number,

  isOnline: {
    type: Boolean,
    default: false
  },

  verified: {
    type: Boolean,
    default: false
  }

});

module.exports = mongoose.model("Vendor", VendorSchema);