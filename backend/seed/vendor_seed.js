const mongoose = require("mongoose");
require("dotenv").config();

const Vendor = require("../models/Vendor");

const vendors = [

  {
    name: "Priya Sharma",
    gender: "Female",
    age: 26,
    rating: 4.8,
    totalReviews: 120,
    description: "Friendly conversation expert",
    experienceHours: 350,
    ratePerMinute: 10,
    isOnline: true,
    verified: true
  },

  {
    name: "Ananya Singh",
    gender: "Female",
    age: 24,
    rating: 4.6,
    totalReviews: 90,
    description: "Relationship advisor",
    experienceHours: 210,
    ratePerMinute: 8,
    isOnline: false,
    verified: true
  },

  {
    name: "Riya Kapoor",
    gender: "Female",
    age: 27,
    rating: 4.7,
    totalReviews: 150,
    description: "Life coach and motivational speaker",
    experienceHours: 400,
    ratePerMinute: 12,
    isOnline: true,
    verified: true
  }

];

async function seedVendors() {

  try {

    await mongoose.connect(process.env.MONGO_URI);

    console.log("MongoDB connected");

    await Vendor.deleteMany();

    console.log("Old vendors removed");

    await Vendor.insertMany(vendors);

    console.log("Vendor data seeded successfully");

    process.exit();

  } catch (error) {

    console.error(error);
    process.exit(1);

  }

}

seedVendors();
