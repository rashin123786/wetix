const mongoose = require("mongoose");
const Event = require("../../models/event");
const Order = require("../../models/orders");

// Get dashboard information for a particular user and event
const getDashboardInfo = async (req, res) => {
  try {
    const userId = req.query.user; // Get the user ID from the query parameter
    const eventId = req.query.event; // Get the event ID from the query parameter

    const totalEvents = await Event.countDocuments({ userId }).maxTimeMS(30000);
    const currentDate = new Date();
    const upcomingEvents = await Event.countDocuments({
      userId,
      date_time: { $gt: currentDate },
    }).maxTimeMS(30000);
    const ticketSale = await Order.countDocuments({
      user: userId,
      event: eventId,
      status: "placed",
    }).maxTimeMS(30000);
    const totalIncome = await Order.countDocuments({
      user: userId,
      event: eventId,
      status: "placed",
    }).maxTimeMS(30000);
    const totalAttendee = await Order.aggregate(
      [
        { $match: { event: eventId, status: "placed" } },
        { $group: { _id: null, total: { $sum: "$items.quantity" } } },
      ],
      { maxTimeMS: 30000 }
    );

    res.json({
      totalEvents,
      upcomingEvents,
      ticketSale,
      totalIncome,
      totalAttendee: totalAttendee[0]?.total || 0,
    });
  } catch (error) {
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
