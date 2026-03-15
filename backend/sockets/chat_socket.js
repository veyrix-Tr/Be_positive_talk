const Message = require("../models/Message");
const { sendNotification } = require("../services/notification_service");

module.exports = function(io) {

  io.on("connection", (socket) => {

    console.log("User connected:", socket.id);

    socket.on("join-room", (roomId) => {

      socket.join(roomId);

      console.log("Joined room:", roomId);

    });

    socket.on("send-message", async (data) => {

      const { senderId, receiverId, text } = data;

      const message = await Message.create({
        senderId,
        receiverId,
        text
      });

      // Send notification to receiver
      await sendNotification(
        receiverId,
        "New Message",
        "You received a new message"
      );

      const roomId = [senderId, receiverId].sort().join("_");

      io.to(roomId).emit("receive-message", message);

    });

    socket.on("disconnect", () => {

      console.log("User disconnected:", socket.id);

    });

  });

};