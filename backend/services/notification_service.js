const admin = require("../config/firebase");
const User = require("../models/User");

exports.sendNotification = async (userId, title, body) => {

  try {

    const user = await User.findById(userId);

    if (!user || !user.deviceToken) {
      return;
    }

    const message = {
      token: user.deviceToken,
      notification: {
        title: title,
        body: body
      }
    };

    await admin.messaging().send(message);

  } catch (error) {

    console.log("Notification error:", error.message);

  }

};