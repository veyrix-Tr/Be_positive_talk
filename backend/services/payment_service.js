const Razorpay = require("razorpay");

const razorpayInstance = new Razorpay({
  key_id: process.env.RAZORPAY_KEY_ID,
  key_secret: process.env.RAZORPAY_KEY_SECRET
});

const createRazorpayOrder = async (amount) => {

  const options = {
    amount: amount * 100,
    currency: "INR",
    receipt: "receipt_" + Date.now()
  };

  const order = await razorpayInstance.orders.create(options);

  return order;
};

module.exports = {
  createRazorpayOrder
};