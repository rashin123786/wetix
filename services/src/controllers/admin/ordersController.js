const Order = require("../../models/orders");
const Cart = require("../../models/cart");
const Event = require("../../models/event");

const createOrder = async (req, res) => {
  try {
    const { userId, event, cartId } = req.body;

    // Retrieve the cart based on the cartId
    const cart = await Cart.findById(cartId);

    if (!cart) {
      return res.status(404).json({ error: "Cart not found" });
    }

    // Retrieve the event based on the event ID
    const foundEvent = await Event.findById(event);

    if (!foundEvent) {
      return res.status(404).json({ error: "Event not found" });
    }

    const { name, price, quantity } = cart.items;

    // Calculate the total based on the price and quantity of items
    const total = price * quantity;

    const order = new Order({
      userId,
      event,
      items: {
        name,
        price,
        quantity,
      },
      total,
      cartId,
    });

    const savedOrder = await order.save();

    res.status(201).json({ message: "Order placed successfully", savedOrder });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to create order" });
  }
};


const getOrders = async (req, res) => {
  try {
    const userId = req.userId; // Retrieve the userId from the req object

    const orders = await Order.find({ userId });
    console.log(orders);
    res.json({ orders });
  } catch (error) {
    res.status(500).json({ error: "Failed to get orders" });
  }
};

module.exports = {
  createOrder,
  getOrders,
};




