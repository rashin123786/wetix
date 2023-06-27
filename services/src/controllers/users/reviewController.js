const Review = require("../../models/review");

// Create a new review
const createReview = async (req, res) => {
  try {
    const { userId, event, name, email, review, rating } = req.body;

    const existingReview = await Review.findOne({ userId, event });

    if (existingReview) {
      return res
        .status(400)
        .json({ error: "Already reviewed for this event." });
    }

    if (!name || !email || !review || !rating) {
      return res.status(400).json({ error: "All fields are required" });
    }

    const userReview = new Review({
      userId,
      event,
      name,
      email,
      review,
      rating,
    });

    await userReview.save();

    res
      .status(201)
      .json({ message: "User review created successfully", userReview });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to create review" });
  }
};

// Get all reviews with count
const getAllReviews = async (req, res) => {
  const { id } = req.params;

  try {
    const reviews = await Review.find({ event: id });
    const totalReviews = reviews.length;

    res.json({ reviews, totalReviews });
  } catch (error) {
    res.status(500).json({ error: "Failed to get reviews" });
  }
};

// Get a specific review by ID
const getReviewById = async (req, res) => {
  try {
    const { reviewId } = req.params;
    const review = await Review.findById(reviewId);
    if (!review) {
      return res.status(404).json({ error: "Review not found" });
    }
    res.json(review);
  } catch (error) {
    res.status(500).json({ error: "Failed to get review" });
  }
};

// Update a review by ID
const updateReviewById = async (req, res) => {
  try {
    const { reviewId } = req.params;
    const { user, name, email, review, rating } = req.body;

    const updatedReview = await Review.findByIdAndUpdate(
      reviewId,
      { user, name, email, review, rating },
      { new: true }
    );

    if (!updatedReview) {
      return res.status(404).json({ error: "Review not found" });
    }

    res.json({ message: "Review updated successfully", review: updatedReview });
  } catch (error) {
    res.status(500).json({ error: "Failed to update review" });
  }
};

// Delete a review by ID
const deleteReviewById = async (req, res) => {
  try {
    const { reviewId } = req.params;
    const deletedReview = await Review.findByIdAndDelete(reviewId);

    if (!deletedReview) {
      return res.status(404).json({ error: "Review not found" });
    }

    res.json({ message: "Review deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: "Failed to delete review" });
  }
};

module.exports = {
  createReview,
  getAllReviews,
  getReviewById,
  updateReviewById,
  deleteReviewById,
};
