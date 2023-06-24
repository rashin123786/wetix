const express = require("express");
const router = express.Router();
const {
  createReview,
  getAllReviews,
  getReviewById,
  updateReviewById,
  deleteReviewById,
} = require("../../controllers/users/reviewController");
const userAuth = require("../../middleware/auth");

// Create a new user review
router.post("/create-reviews/:userId", userAuth, createReview);

// Get all user reviews
router.get("/get-reviews", getAllReviews);

// Get a specific user review by ID
router.get("/reviews/:reviewId/:userId", userAuth, getReviewById);

// Update a user review by ID
router.put("/reviews/:reviewId/:userId", userAuth, updateReviewById);

// Delete a user review by ID
router.delete("/reviews/:reviewId/:userId", userAuth, deleteReviewById);

module.exports = router;
