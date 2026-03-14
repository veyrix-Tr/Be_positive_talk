const express = require("express");
const router = express.Router();

const vendorController = require("../controllers/vendor_controller");

router.get("/", vendorController.getAllVendors);

router.get("/:id", vendorController.getVendorById);

module.exports = router;