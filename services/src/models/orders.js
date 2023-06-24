const mongoose = require("mongoose");

const orderSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  event: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Event",
    required: true,
  },
  items: {
    name: {
      type: String,
      required: true,
    },
    price: {
      type: Number,
      required: true,
    },
    quantity: {
      type: Number,
      required: true,
    },
  },
  status: {
    type: String,
    enum: ["placed", "cancelled", "completed"],
    default: "placed",
  },
  total: {
    type: Number,
    required: true,
  },
  cartId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Cart",
  },
});

module.exports = mongoose.model("Order", orderSchema);
