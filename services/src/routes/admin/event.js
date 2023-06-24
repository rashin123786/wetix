const express = require("express");
const router = express.Router();
const userAuth = require("../../middleware/auth");
const {
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
} = require("../../controllers/admin/eventController");

// POST /events
router.post("/event", userAuth, createEvent);

// PUT /events/:id - Update an existing event
router.put("/event/:userId", updateEvent);

// DELETE /events/:id - Delete an event ,

router.delete("/event/:userId", deleteEvent);

//get events
router.get("/events", getEvents);

//get events by id
router.get("/events/:userId", getEventsById);

// // POST /events
// router.post("/create-event/:userId", createEvent);

// // PUT /events/:id - Update an existing event
// router.put("/events/:id", updateEvent);

// // DELETE /events/:id - Delete an event ,

// router.delete("/events/:id", deleteEvent);

// //get events
// router.get("events", getEvents);

// //get event by id
// router.get("/events/:id", getEventById);

// Route for booking an event ticket(s)
router.post("/events/:eventId/book", bookEvent);

// Route for canceling event booking
router.post("/events/:eventId/cancel-booking", cancelBooking);

// Route for choosing fee options
router.post("/events/:eventId/fee-options", chooseFeeOptions);

// Route for adding event map
router.post("/events/:eventId/add-map", addEventMap);

// Define the routes getPastEvents,upcoming event, getLiveEvents
router.get("/past-events", userAuth, getPastEvents);
router.get("/upcoming-events", userAuth, getUpcomingEvents);
router.get("/live-events", userAuth, getLiveEvents);


// serach api searchEventsByCategory, searchEventByEventName

router.get("/search-category/:category", userAuth, searchEventsByCategory);
router.get("/search-Event-name/:eventName", userAuth, searchEventByEventName);

module.exports = router;
