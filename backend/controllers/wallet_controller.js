const User = require("../models/User");
const Transaction = require("../models/Transaction");


exports.getWalletBalance = async (req, res) => {

  try {

    const user = await User.findById(req.user.userId);

    res.json({
      balance: user.tokenBalance
    });

  } catch (error) {

    res.status(500).json({ message: "Server error" });

  }

};


exports.getTransactionHistory = async (req, res) => {

  try {

    const transactions = await Transaction.find({
      userId: req.user.userId
    });

    res.json(transactions);

  } catch (error) {

    res.status(500).json({ message: "Server error" });

  }

};


exports.addTokens = async (req, res) => {

  try {

    const { tokens, amount } = req.body;

    const user = await User.findById(req.user.userId);

    user.tokenBalance += tokens;

    await user.save();

    const transaction = await Transaction.create({

      userId: user._id,
      type: "credit",
      tokens: tokens,
      amount: amount,
      description: "Token purchase"

    });

    res.json({
      message: "Tokens added successfully",
      balance: user.tokenBalance,
      transaction
    });

  } catch (error) {

    res.status(500).json({ message: "Server error" });

  }

};