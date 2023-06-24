const mongoose = require("mongoose");

const organizerSchema = new mongoose.Schema(
  {
    company_name: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [true, "company name is required"],
    },
    address: {
      type: String,
      required: [true, "address is required"],
    },
    status: {
      type: String,
      enum: ["active", "inactive", "pending"],
      default: "pending",
    },
    action: {
      type: String,
      enum: ["publish", "unpublish"],
      default: "publish",
    },
    is_delete: {
      type: Boolean,
      default: false,
    },
  },
  { timestamps: true }
);

const Organizer = mongoose.model("Organizer", organizerSchema);

module.exports = Organizer;
