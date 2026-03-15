const express = require("express");
const cors = require("cors");
require("dotenv").config();

const http = require("http");
const { Server } = require("socket.io");

const connectDB = require("./config/db");

const authRoutes = require("./routes/auth_routes");
const vendorRoutes = require("./routes/vendor_routes");
const walletRoutes = require("./routes/wallet_routes");
const chatRoutes = require("./routes/chat_routes");
const paymentRoutes = require("./routes/payment_routes");
const referralRoutes = require("./routes/referral_routes");
const userRoutes = require("./routes/user_routes");
const initChatSocket = require("./sockets/chat_socket");


connectDB();

const app = express();

app.use(cors());
app.use(express.json());

app.use("/auth", authRoutes);
app.use("/vendors", vendorRoutes);
app.use("/wallet", walletRoutes);
app.use("/chat", chatRoutes);
app.use("/payment", paymentRoutes);
app.use("/referral", referralRoutes);
app.use("/user", userRoutes);

app.get("/", (req, res) => {
  res.send("Backend server running successfully");
});

const server = http.createServer(app);

const io = new Server(server, {
  cors: {
    origin: "*"
  }
});

initChatSocket(io);

io.on("connection", (socket) => {

  console.log("User connected:", socket.id);

  socket.on("disconnect", () => {
    console.log("User disconnected:", socket.id);
  });

});

const PORT = 5000;

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});