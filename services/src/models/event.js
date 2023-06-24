const mongoose = require("mongoose");

const eventSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [true, "user id is required"],
    },
    event: {
      type: String,
      required: [true, "event is required"],
    },
    organization: {
      type: String,
      // required: [true, "organization is required"],
    },
    eventCategory: {
      type: String,
      required: [true, "event category is required"],
    },
    eventSubCategory: {
      type: String,
      // required: [true, "event sub category is required"],
    },
    imagePath: [String],
    start_date: {
      type: Date,
      required: [true, "Date and time are required"],
    },
    end_date: {
      type: Date,
      required: [true, "Date and time are required"],
    },
    place: {
      type: String,
      required: [true, "Place is required"],
    },
    price: {
      type: Number,
      required: [true, "Price is required"],
    },
    note: {
      type: String,
      // required: [true, "Price is required"],
    },
    type: {
      type: String,
      // required: [true, "Type is required"],
    },
    status: {
      type: String,
      enum: ["active", "inactive", "pending"],
      default: "pending",
    },
    isBooked: {
      type: Boolean,
      default: false,
    },
    eventMap: {
      type: String,
      default: null,
    },
    feeOptions: {
      type: String,
      enum: ["Pass on to buyer", "Absorb fees"],
      // enum: ["paid", "pending"],
      default: "Absorb fees",
    },
    is_delete: {
      type: Boolean,
      default: false,
    },
  },
  { timestamps: true }
);

const Event = mongoose.model("Event", eventSchema);

module.exports = Event;
