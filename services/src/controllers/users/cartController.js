const Cart = require("../../models/cart");
const Event = require("../../models/event");
const Order = require("../../models/orders");

const addToCart = async (req, res) => {
  try {
    const { userId, event, item } = req.body;

    const foundEvent = await Event.findById(event);
    console.log(foundEvent);
    if (!foundEvent) {
      return res.status(404).json({ error: "Event not found" });
    }

    const price = foundEvent.price;

    const existingCart = await Cart.findOne({ userId, event });

    if (existingCart) {
      return res
        .status(400)
        .json({ error: "Cart already exists for this event." });
    }

    const cart = new Cart({
      userId,
      event: event.toString(),
      items: {
        name: item.name,
        price: price,
        quantity: item.quantity || 1,
        subtotal: price * (item.quantity || 1),
      },
      total: price * (item.quantity || 1),
    });

    await cart.save();

    const response = {
      _id: cart._id,
      userId: cart.userId,
      event: cart.event,
      items: cart.items,
      total: cart.total,
      tax: cart.tax,
      serviceCharge: cart.serviceCharge,
      __v: cart.__v,
    };

    console.log(response); // Check the response object in the console

    res.status(200).json(response);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "An error occurred while adding the item to the cart." });
  }
};




const getCartByUser = async (req, res) => {
  try {
    const { userId } = req.params;

    // Find all carts for the user
    const carts = await Cart.find({ userId });

    if (carts.length === 0) {
      return res
        .status(404)
        .json({ success: false, message: "Carts not found for the user" });
    }

    // Calculate the total sum of all carts
    const totalSum = carts.reduce((sum, cart) => sum + cart.total, 0);

    res.status(200).json({
      success: true,
      carts,
      totalSum,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};



const removeFromCart = async (req, res) => {
  try {
    const { userId, cartId } = req.params;

    // Find and delete the cart
    const result = await Cart.deleteOne({ _id: cartId, userId });

    if (result.deletedCount === 0) {
      return res
        .status(404)
        .json({ success: false, message: "Cart not found" });
    }

    res.status(200).json({
      success: true,
      message: "Cart removed successfully.",
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};



const updateItemCount = async (req, res) => {
  try {
    const { cartId, userId, action } = req.body;

    // Find the cart
    const cart = await Cart.findById(cartId);

    if (!cart) {
      return res
        .status(404)
        .json({ success: false, message: "Cart not found" });
    }

    // Verify that the cart belongs to the specified user
    if (cart.userId.toString() !== userId) {
      return res
        .status(401)
        .json({ success: false, message: "Unauthorized access to cart" });
    }

    const item = cart.items;

    if (action === "+") {
      // Increment the item quantity and subtotal
      item.quantity++;
      item.subtotal = item.price * item.quantity;
    } else if (action === "-") {
      // Decrement the item quantity and subtotal
      if (item.quantity > 1) {
        item.quantity--;
        item.subtotal = item.price * item.quantity;
      } else {
        return res
          .status(400)
          .json({
            success: false,
            message: "Cannot decrement item quantity below 1",
          });
      }
    } else {
      return res
        .status(400)
        .json({ success: false, message: "Invalid action" });
    }

    // Update the cart total
    cart.total = item.subtotal;

    // Save the cart
    await cart.save();

    res.status(200).json({
      success: true,
      message: `Cart item count ${
        action === "+" ? "incremented" : "decremented"
      } successfully`,
      cart,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};


module.exports = {
  addToCart,
  getCartByUser,
  removeFromCart,
  updateItemCount,
};
