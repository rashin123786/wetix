const User = require("../../models/user");

const createUser = async (req, res) => {
  try {
    const {
      fullName,
      userName,
      email,
      contact,
      state,
      city,
      billing,
      status,
      actions,
    } = req.body;

    if (!fullName || !userName || !email) {
      return res.status(400).json({
        success: false,
        message: "Full Name, Username, and Email are required",
      });
    }

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(200).json({
        success: false,
        message: "Email already exists. Please use another email",
      });
    }

    const newUser = new User({
      fullName,
      userName,
      email,
      contact,
      state,
      city,
      billing,
      status,
      actions,
    });

    const savedUser = await newUser.save();

    res.status(201).json({
      success: true,
      message: "User created successfully.",
      user: savedUser,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

const getAllUsers = async (req, res) => {
  try {
    const users = await User.find({ is_delete: false });

    res.status(200).json({
      success: true,
      message: "Users retrieved successfully.",
      users,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

const getUserById = async (req, res) => {
  try {
    const userId = req.params.id;

    const user = await User.findOne({ _id: userId, is_delete: false });

    if (!user) {
      return res
        .status(404)
        .json({ success: false, message: "User not found or not accessible" });
    }

    res.status(200).json({
      success: true,
      message: "User retrieved successfully.",
      user,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

const updateUserById = async (req, res) => {
  try {
    const { user_id } = req.params;
    const {
      full_name,
      user_name,
      email,
      contact,
      state,
      city,
      billing,
      status,
      actions,
    } = req.body;

    const user = await User.findById(user_id);
    if (!user) {
      return res
        .status(404)
        .json({ success: false, message: "User not found" });
    }

    user.full_name = full_name || user.full_name;
    user.user_name = user_name || user.user_name;
    user.email = email || user.email;
    user.contact = contact || user.contact;
    user.state = state || user.state;
    user.city = city || user.city;
    user.billing = billing || user.billing;
    user.status = status || user.status;
    user.actions = actions || user.actions;

    const updatedUser = await user.save();

    res.status(200).json({
      success: true,
      message: "User updated successfully.",
      user: updatedUser,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

const deleteUserById = async (req, res) => {
  try {
    const userId = req.params.id;

    const deletedUser = await User.findByIdAndDelete(userId);

    if (!deletedUser) {
      return res
        .status(404)
        .json({ success: false, message: "User not found" });
    }

    if (deletedUser.is_default) {
      // Delete the default user
      await User.findOneAndDelete({ is_default: true });
    }

    res.status(200).json({
      success: true,
      message: "User deleted successfully.",
      user: deletedUser,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

module.exports = {
  createUser,
  getAllUsers,
  getUserById,
  updateUserById,
  deleteUserById,
};
