const express = require("express");
const router = express.Router();
const {
  login,
  signUp,
  logout,
} = require("../../controllers/users/signup-loginController");

//signup
router.post("/signup", signUp);

// Login
router.post("/login", login);

// Logout
router.post("/logout", logout);

module.exports = router;
