const express = require("express");
const router = express.Router();
const {
  getDashboardInfo,
  getHomepageEvents,
  getPastEvents,
  getUpcomingEvents,
  getLiveEvents,
} = require("../../controllers/users/dashboardController");
const userAuth = require("../../middleware/auth");

// Get dashboard information for a particular user
router.get("/dashboard", userAuth, getDashboardInfo);

// Get events for homepage
router.get("/homepage-events", getHomepageEvents);

router.get("/getPastEvents", getPastEvents);
router.get("/getUpcomingEvents", getUpcomingEvents);
router.get("/getLiveEvents", getLiveEvents);

module.exports = router;
