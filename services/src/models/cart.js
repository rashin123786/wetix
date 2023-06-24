const mongoose = require("mongoose");

const cartSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
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
      default: 1,
    },
    subtotal: {
      type: Number,
      required: true,
      default: 0,
    },
  },
  total: {
    type: Number,
    required: true,
    default: 0,
  },
  tax: {
    type: Number,
    required: true,
    default: 0,
  },
  serviceCharge: {
    type: Number,
    required: true,
    default: 0,
  },
});

const Cart = mongoose.model("Cart", cartSchema);

module.exports = Cart;
