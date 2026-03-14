const Vendor = require("../models/Vendor");

exports.getAllVendors = async (req, res) => {

  try {

    const vendors = await Vendor.find();

    res.json(vendors);

  } catch (error) {

    res.status(500).json({ message: "Server error" });

  }

};


exports.getVendorById = async (req, res) => {

  try {

    const vendor = await Vendor.findById(req.params.id);

    if (!vendor) {
      return res.status(404).json({ message: "Vendor not found" });
    }

    res.json(vendor);

  } catch (error) {

    res.status(500).json({ message: "Server error" });

  }

};