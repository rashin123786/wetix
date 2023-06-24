const Event = require("../../models/event");
const User = require("../../models/user");
const path = require("path");
fs = require("fs");

// Create a new event
// Controller method for creating an event for a registered user
const createEvent = async (req, res) => {
  const {
    eventName,
    category,
    organization,
    location,
    startDate,
    endDate,
    price,
    note,
  } = req.body;

  let { images } = req.files;
  let imagesPath = [];

  if (!Array.isArray(images)) {
    images = [images];
  }

  images.forEach((file, i) => {
    const extension = path.extname(`${file.name}`);
    const md5 = file.md5 + new Date().getTime() + i;
    const encryptImageName = md5 + extension;
    file.mv("./assets/eventImages/" + encryptImageName);
    imagesPath.push(encryptImageName);
  });

  try {
    const newEvent = new Event({
      userId: req.userId,
      event: eventName,
      eventCategory: category,
      imagePath: imagesPath,
      organization: organization,
      place: location,
      start_date: startDate,
      end_date: endDate,
      price: price,
      note: note,
    });

    await newEvent.save();

    res
      .status(201)
      .json({ message: "Event created successfully", event: newEvent });
  } catch (error) {
    console.log(error, "error");
    res.status(500).json({ error: "Failed to create event" });
  }
};


// Update an existing event
const updateEvent = async (req, res) => {
  try {
    const eventId = req.params.eventId;
    const updates = req.body;

    const updatedEvent = await Event.findByIdAndUpdate(eventId, updates, {
      new: true,
    });

    if (!updatedEvent) {
      return res
        .status(404)
        .json({ success: false, message: "Event not found" });
    }

    res.status(200).json({ success: true, data: updatedEvent });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
};

// Delete an event
const deleteEvent = async (req, res) => {
  try {
    const { id } = req.params;

    // Check if the event exists
    const event = await Event.findById(id);
    if (!event) {
      return res
        .status(404)
        .json({ success: false, message: "Event not found" });
    }

    // Update the is_delete key to true
    event.is_delete = true;
    await event.save();

    res.status(200).json({
      success: true,
      message: "Event deleted successfully",
      event: event,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Get all events with is_default set to false
const getEvents = async (req, res) => {
  try {
    const events = await Event.find();

    res.status(200).json({
      success: true,
      message: "Events retrieved successfully",
      events: events,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Get single event by userId
const getEventById = async (req, res) => {
  try {
    const { id } = req.params;

    // Find the event by id and is_default set to false
    const event = await Event.findOne({ _id: id, is_default: false });

    if (!event) {
      return res.status(404).json({
        success: false,
        message: "Event not found or not accessible",
      });
    }

    res.status(200).json({
      success: true,
      message: "Event retrieved successfully",
      event: event,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Get all events by userId
const getEventsById = async (req, res) => {
  try {
    const { id } = req.params;

    // Find the event by id and is_default set to false
    const events = await Event.find({ userId: id });

    if (!events) {
      return res.status(404).json({
        success: false,
        message: "Events not found or not accessible",
      });
    }

    res.status(200).json({
      success: true,
      message: "Events retrieved successfully",
      events: events,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Controller method for booking an event ticket(s)
const bookEvent = async (req, res) => {
  try {
    const eventId = req.params.eventId;

    const event = await Event.findById(eventId);

    if (!event) {
      return res
        .status(404)
        .json({ success: false, message: "Event not found" });
    }

    if (event.isBooked) {
      return res
        .status(400)
        .json({ success: false, message: "Event is already booked" });
    }

    event.isBooked = true;
    await event.save();

    res
      .status(200)
      .json({ success: true, message: "Event ticket(s) booked successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
};
const cancelBooking = async (req, res) => {
  try {
    const eventId = req.params.eventId;

    const event = await Event.findById(eventId);

    if (!event) {
      return res
        .status(404)
        .json({ success: false, message: "Event not found" });
    }

    if (!event.isBooked) {
      return res
        .status(400)
        .json({ success: false, message: "Event is not booked" });
    }

    event.isBooked = false;
    await event.save();

    res
      .status(200)
      .json({ success: true, message: "Event booking canceled successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
};

// Controller method for choosing fee options
const chooseFeeOptions = async (req, res) => {
  try {
    const eventId = req.params.eventId;
    const { absorbFees } = req.body;

    const event = await Event.findById(eventId);

    if (!event) {
      return res
        .status(404)
        .json({ success: false, message: "Event not found" });
    }

    // Update the fee options for the event
    event.absorbFees = absorbFees;
    await event.save();

    res
      .status(200)
      .json({ success: true, message: "Fee options chosen successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
};

// Controller method for adding event map
const addEventMap = async (req, res) => {
  try {
    const eventId = req.params.eventId;
    const { eventMap } = req.body;

    const event = await Event.findById(eventId);

    if (!event) {
      return res
        .status(404)
        .json({ success: false, message: "Event not found" });
    }

    // Update the event map
    event.eventMap = eventMap;
    await event.save();

    res
      .status(200)
      .json({ success: true, message: "Event map added successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
};

// past event

const getPastEvents = async (req, res) => {
  try {
    const currentDate = new Date(); // Get the current date

    // Retrieve past events for the authenticated user
    const pastEvents = await Event.find({
      userId: req.userId,
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

//upcoming event
const getUpcomingEvents = async (req, res) => {
  try {
    const currentDate = new Date(); // Get the current date

    // Set the time to the end of the current day
    currentDate.setHours(23, 59, 59, 999);

    // Retrieve upcoming events for the authenticated user
    const upcomingEvents = await Event.find({
      userId: req.userId,
      start_date: { $gt: currentDate },
    });

    res.status(200).json({
      message: "Upcoming events retrieved successfully",
      upcomingEvents,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to retrieve upcoming events" });
  }
};

//upcoming event

const getLiveEvents = async (req, res) => {
  try {
    const currentDate = new Date(); // Get the current date

    // Set the time to the start of the current day
    currentDate.setHours(0, 0, 0, 0);

    // Set the end date to the end of the current day
    const endDate = new Date(currentDate);
    endDate.setHours(23, 59, 59, 999);

    // Retrieve live events for the authenticated user
    const liveEvents = await Event.find({
      userId: req.userId,
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
// search events by category
async function searchEventsByCategory(req, res) {
  try {
    const category = req.params.category.toLowerCase(); // Convert category to lowercase
    const events = await Event.find({ eventCategory: { $regex: new RegExp('^' + category, 'i') } });

    res.status(200).json({
      message: "Events retrieved successfully",
      events,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to retrieve events" });
  }
}

// Search events by event name
async function searchEventByEventName(req, res) {
  try {
    const eventName = req.params.eventName.toLowerCase();
    const events = await Event.find({
      event: { $regex: new RegExp("^" + eventName, "i") },
    });

    res.status(200).json({
      message: 'Events retrieved successfully',
      events,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to retrieve events' });
  }
}

module.exports = {
  createEvent,
  updateEvent,
  deleteEvent,
  getEvents,
  getEventById,
  getEventsById,
  bookEvent,
  cancelBooking,
  chooseFeeOptions,
  addEventMap,
  getPastEvents,
  getUpcomingEvents,
  getLiveEvents,
  searchEventsByCategory,
  searchEventByEventName,
};
