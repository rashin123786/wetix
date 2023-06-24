const express = require("express");
const router = express.Router();
const {
  createUser,
  getAllUsers,
  getUserById,
  updateUserById,
  deleteUserById,
} = require("../../controllers/admin/userController");

router.post("/create-user", createUser);
router.get("/getAllUsers", getAllUsers);
router.get("/getUserById/:id", getUserById);
router.put("/users/:id", updateUserById);
router.delete("/users/:id", deleteUserById);

module.exports = router;
