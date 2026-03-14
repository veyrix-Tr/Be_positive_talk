const Message = require("../models/Message");

exports.getChatHistory = async (req, res) => {

  try {

    const { userId, vendorId } = req.params;

    const messages = await Message.find({
      $or: [
        { senderId: userId, receiverId: vendorId },
        { senderId: vendorId, receiverId: userId }
      ]
    }).sort({ timestamp: 1 });

    res.json(messages);

  } catch (error) {

    res.status(500).json({ message: "Server error" });

  }

};
