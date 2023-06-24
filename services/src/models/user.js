const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    fullName: {
      type: String,
      required: [true, "Full name is required"],
      // unique: true,
    },
    userName: {
      type: String,
      required: [true, "Username is required"],
      unique: true,
    },
    email: {
      type: String,
      required: [true, "Email is required"],
      unique: true,
    },
    contact: {
      type: String,
      validate: {
        validator: function (value) {
          // Regex pattern for validating contact number
          const regex = /^[+]?[0-9]{1,3}[-\s.]?[0-9]{1,14}[-\s.]?[0-9]{1,14}$/;
          return regex.test(value);
        },
        message: "Invalid contact number",
      },
    },
    state: {
      type: String,
    },
    city: {
      type: String,
    },
    billing: {
      type: String,
    },
    status: {
      type: String,
      enum: ["active", "inactive", "pending"],
      default: "active",
    },
    // action: {
    //   type: String,
    //   enum: ["publish", "unpublish"],
    //   default: "publish",
    // },
    role: {
      type: String,
      enum: ["user", "organiser", "admin"],
      default: "user",
    },
    is_delete: {
      type: Boolean,
      default: false,
    },
    password: {
      type: String,
      default: "",
    },
  },
  { timestamps: { createdAt: true, updatedAt: true } }
);

const User = mongoose.model("User", userSchema);

module.exports = User;
