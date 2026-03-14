const express = require("express");
const cors = require("cors");
require("dotenv").config();

const connectDB = require("./config/db");
const authRoutes = require("./routes/auth_routes");
const vendorRoutes = require("./routes/vendor_routes");
const walletRoutes = require("./routes/wallet_routes");

const app = express();

connectDB();

app.use(cors());
app.use(express.json());

app.use("/auth", authRoutes);
app.use("/vendors", vendorRoutes);
app.use("/wallet", walletRoutes);

app.get("/", (req, res) => {
  res.send("Backend server running successfully");
});

const PORT = 5000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});