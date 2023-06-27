const Order = require("../../models/orders");
const Cart = require("../../models/cart");
const Event = require("../../models/event");
const { find } = require("../../models/user");

const createOrder = async (req, res) => {
  try {
    const {
      userId,
      firstName,
      laseName,
      address,
      city,
      state,
      contact,
      country,
      zipCode,
      note,
    } = req.body;

    // Find all carts for the user
    const carts = await Cart.find({ userId });

    if (carts.length === 0) {
      return res
        .status(404)
        .json({ success: false, message: "Carts not found for the user" });
    }

    if (
      !userId ||
      !firstName ||
      !laseName ||
      !address ||
      !city ||
      !state ||
      !contact ||
      !country ||
      !zipCode
    ) {
      return res.status(400).json({ error: "Buyer info all fields required" });
    }

    // Retrieve the cart based on the cartId
    const userCartItems = await Cart.find({ userId });
    console.log(userCartItems, "userCartItems");
    if (!userCartItems) {
      return res.status(404).json({ error: "Cart not found" });
    }

    userCartItems.forEach(async (cart) => {
      await new Order({
        userId: cart.userId,
        event: cart.event,
        items: {
          name: cart.items.name,
          price: cart.items.price,
          quantity: cart.items.quantity,
        },
        buyerInfo: {
          firstName,
          laseName,
          address,
          city,
          state,
          contact,
          country,
          zipCode,
          note,
        },
        total: cart.total,
        tax: cart.tax,
        serviceCharge: cart.serviceCharge,
      }).save();

      // Remove the cart from the cart collection
      await Cart.findByIdAndRemove(cart._id);
    });

    res.status(201).json({ message: "Order placed successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to create order" });
  }
};

const getOrders = async (req, res) => {
  try {
    const userId = req.userId; // Retrieve the userId from the req object

    const orders = await Order.find({ userId });

    res.json({ orders });
  } catch (error) {
    res.status(500).json({ error: "Failed to get orders" });
  }
};

module.exports = {
  createOrder,
  getOrders,
};
