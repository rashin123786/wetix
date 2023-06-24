const express = require("express");
const router = express.Router();
const {
  createPage,
  updatePage,
} = require("../../controllers/admin/pagesController");

// POST /pages
router.post("/createPage", createPage);

// PUT /pages/:id
router.put("/updatePage:id", updatePage);

module.exports = router;
