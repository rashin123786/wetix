const express = require("express");
const router = express.Router();
const {
  createOrder,
  getOrders,
} = require("../../controllers/admin/ordersController");
const userAuth = require("../../middleware/auth");

// Create a new order, getOrders
router.post("/create-order", userAuth, createOrder);
router.get("/get-order/:userId", userAuth, getOrders);

module.exports = router;
