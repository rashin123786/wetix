const mongoose = require("mongoose");

const tokenSchema = new mongoose.Schema(
  {
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    token: {
      type: String,
    },
  },
  { timestamps: { createdAt: true, updatedAt: true } }
);

const Token = mongoose.model("Token", tokenSchema);

module.exports = Token;
