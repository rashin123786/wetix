const mongoose = require("mongoose");
const Event = require("../../models/event");
const Order = require("../../models/orders");

const getDashboardInfo = async (req, res) => {
  try {
    const { userId } = req.body; // Get the userId from the request body

    const totalEvents = await Order.countDocuments({ userId });
    const currentDate = new Date();
    const upcomingEvents = await Event.countDocuments({
      userId,
      start_date: { $gt: currentDate },
    });
    const ticketSale = await Order.countDocuments({
      userId,
      status: "placed",
    });

    const totalOrders = await Order.find({ userId, status: "placed" });
    const totalIncome = totalOrders.reduce(
      (sum, order) => sum + order.total,
      0
    );

    const totalAttendeeResult = await Order.aggregate([
      { $match: { status: "placed" } },
      { $group: { _id: null, total: { $sum: "$items.quantity" } } },
    ]);

    const totalAttendee =
      totalAttendeeResult && totalAttendeeResult.length > 0
        ? totalAttendeeResult[0].total
        : 0;

    res.json({
      message: "Dashboard information retrieved successfully",
      totalEvents: {
        message: "Total events retrieved successfully",
        value: totalEvents,
      },
      upcomingEvents: {
        message: "Upcoming events fetched successfully",
        value: upcomingEvents,
      },
      ticketSale: {
        message: "Ticket sale count fetched successfully",
        value: ticketSale,
      },
      totalIncome: {
        message: "Total income calculated successfully",
        value: totalIncome,
      },
      totalAttendee: {
        message: "Total attendees calculated successfully",
        value: totalAttendee,
      },
    });


  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get dashboard information" });
  }
};


// Get events for homepage
const getHomepageEvents = async (req, res) => {
  try {
    const currentDate = new Date(); // Get the current date

    // Set the time to the start of the current day
    currentDate.setHours(0, 0, 0, 0);

    // Set the end date to the end of the current day
    const endDate = new Date(currentDate);
    endDate.setHours(23, 59, 59, 999);

    // Retrieve past events
    const pastEvents = await Event.find({
      end_date: { $lt: currentDate },
      start_date: { $lt: currentDate },
    }).exec();

    const filteredPastEvents = pastEvents.filter((event) => {
      const start = new Date(event.start_date);
      const end = new Date(event.end_date);
      return (
        start.getDate() !== currentDate.getDate() ||
        end.getDate() !== currentDate.getDate()
      );
    });

    // Retrieve upcoming events
    const upcomingEvents = await Event.find({
      start_date: { $gt: endDate },
      end_date: { $gt: endDate },
    });

    // Exclude events starting today from upcoming events
    const filteredUpcomingEvents = upcomingEvents.filter((event) => {
      const start = new Date(event.start_date);
      return start.getDate() !== currentDate.getDate();
    });

    // Retrieve live events
    const liveEvents = await Event.find({
      start_date: { $lte: endDate },
      end_date: { $gte: currentDate },
    }).exec();

    res.status(200).json({
      message: "Homepage events retrieved successfully",
      pastEvents: filteredPastEvents,
      upcomingEvents: filteredUpcomingEvents,
      liveEvents,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to retrieve homepage events" });
  }
};

const getPastEvents = async (req, res) => {
  try {
    const currentDate = new Date(); // Get the current date

    // Set the time to the start of the current day
    currentDate.setHours(0, 0, 0, 0);

    // Retrieve past events
    const pastEvents = await Event.find({
      end_date: { $lt: currentDate },
      start_date: { $lt: currentDate },
    }).exec();

    const filteredPastEvents = pastEvents.filter((event) => {
      const start = new Date(event.start_date);
      const end = new Date(event.end_date);
      return (
        start.getDate() !== currentDate.getDate() ||
        end.getDate() !== currentDate.getDate()
      );
    });

    res.status(200).json({
      message: "Past events retrieved successfully",
      pastEvents: filteredPastEvents,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to retrieve past events" });
  }
};

const getUpcomingEvents = async (req, res) => {
  try {
    const currentDate = new Date(); // Get the current date

    // Set the time to the start of the current day
    currentDate.setHours(0, 0, 0, 0);

    // Set the end date to the end of the current day
    const endDate = new Date(currentDate);
    endDate.setHours(23, 59, 59, 999);

    // Retrieve upcoming events
    const upcomingEvents = await Event.find({
      start_date: { $gt: endDate },
      end_date: { $gt: endDate },
    });

    // Exclude events starting today from upcoming events
    const filteredUpcomingEvents = upcomingEvents.filter((event) => {
      const start = new Date(event.start_date);
      return start.getDate() !== currentDate.getDate();
    });

    res.status(200).json({
      message: "Upcoming events retrieved successfully",
      upcomingEvents: filteredUpcomingEvents,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to retrieve upcoming events" });
  }
};

const getLiveEvents = async (req, res) => {
  try {
    const currentDate = new Date(); // Get the current date

    // Set the time to the start of the current day
    currentDate.setHours(0, 0, 0, 0);

    // Set the end date to the end of the current day
    const endDate = new Date(currentDate);
    endDate.setHours(23, 59, 59, 999);

    // Retrieve live events
    const liveEvents = await Event.find({
      start_date: { $lte: endDate },
      end_date: { $gte: currentDate },
    }).exec();

    res.status(200).json({
      message: "Live events retrieved successfully",
      liveEvents,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to retrieve live events" });
  }
};

module.exports = {
  getDashboardInfo,
  getHomepageEvents,
  getPastEvents,
  getUpcomingEvents,
  getLiveEvents,
};
