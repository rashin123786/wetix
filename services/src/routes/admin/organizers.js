const express = require("express");
const router = express.Router();
const {
  createOrganizer,
  updateOrganizer,
  getAllOrganizers,
  getOrganizerById,
  deleteOrganizer,
} = require("../../controllers/admin/organizersController");

// Create a new organizer
router.post("/organizers", createOrganizer);

// Update an organizer by ID
router.put("/organizers/:userId", updateOrganizer);

// Get all organizers (with is_default as false)
router.get("/organizers", getAllOrganizers);

// Get an organizer by ID (with is_default as false)
router.get("/organizers/:id", getOrganizerById);

// Delete an organizer by ID (set is_default to true)
router.delete("/organizers/:id", deleteOrganizer);

module.exports = router;
