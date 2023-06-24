const userModel = require("../../models/user");
const Token = require("../../models/token");
const validator = require("../../utils/validator");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const { JWT_SECRET } = process.env;

const signUp = async function (req, res) {
  try {
    const { fullName, userName, email, password } = req.body;

    if (
      !validator.isValid(fullName) ||
      !validator.isValid(userName) ||
      !validator.isValid(password)
    ) {
      return res.status(400).json({
        status: false,
        message:
          "Invalid request parameters. Please provide full name, username, and password.",
      });
    }

    // Check if the username, email is already taken
    const existingUser = await userModel.findOne({ userName });
    const existingEmail = await userModel.findOne({ email });

    if (existingUser) {
      return res.status(400).json({
        status: false,
        message:
          "Username is already taken. Please choose a different username.",
      });
    }
    if (existingEmail) {
      return res.status(400).json({
        status: false,
        message: "Email is already taken. Please choose a different email.",
      });
    }
    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create a new user
    const newUser = new userModel({
      fullName,
      userName,
      email,
      password: hashedPassword,
    });

    // Save the user to the database
    const savedUser = await newUser.save();

    return res.status(201).json({
      status: true,
      message: "User registered successfully.",
      user: savedUser,
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};

const login = async function (req, res) {
  try {
    const { userName, password } = req.body;

    if (!validator.isValid(userName) || !validator.isValid(password)) {
      return res.status(400).json({
        status: false,
        message:
          "Invalid request parameters. Please provide username and password.",
      });
    }

    // Find the user by username
    const user = await userModel.findOne({ userName });

    if (!user) {
      return res.status(404).json({
        status: false,
        message: "User not found. Please check your username.",
      });
    }

    // Compare the provided password with the stored password
    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch) {
      return res.status(401).json({
        status: false,
        message: "Invalid password. Please check your password.",
      });
    }

    // Generate a JWT token
    const token = jwt.sign({ userId: user._id }, JWT_SECRET);

    // Save the login information in the database
    const tokenData = new Token({
      user: user._id,
      token: token,
    });

    await tokenData.save();

    return res.json({
      status: true,
      message: "Login successful.",
      token,
      id: user.id,
    });
  } catch (err) {
    return res.status(500).json({ status: false, error: err.message });
  }
};

const logout = async (req, res) => {
  try {
    const { userId } = req.body;

    // Delete the token and associated user ID from the database
    await Token.findOneAndDelete({ user: userId });

    res.json({ status: true, message: "Logout successful." });
  } catch (error) {
    res.status(500).json({ status: false, error: "Failed to logout." });
  }
};

module.exports = {
  signUp,
  login,
  logout,
};
