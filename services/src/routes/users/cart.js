const express = require("express");
const router = express.Router();
const userAuth = require("../../middleware/auth");
const {
  addToCart,
  getCartByUser,
  removeFromCart,
  updateItemCount,
} = require("../../controllers/users/cartController");

/// Add item to cart
router.post("/cart-add", userAuth, addToCart);

// Get cart by user
router.get("/cart/:userId", userAuth, getCartByUser);

// Remove item from cart
router.delete("/cart/:userId/:cartId", userAuth, removeFromCart);
// Update item count in cart
router.put("/cart/update-item-count", userAuth, updateItemCount);
module.exports = router;
