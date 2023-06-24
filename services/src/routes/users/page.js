const express = require("express");
const router = express.Router();
const {
  getAboutSectionContent,
  getContactSectionContent,
  getBannerSectionContent,
  getOtherSectionContent,
} = require("../../controllers/users/pageController");


// Route for getting the about section content
router.get("/page-about", getAboutSectionContent);

// Route for getting the contact section content
router.get("/page-contact", getContactSectionContent);

// Route for getting the banner section content
router.get("/page-banner", getBannerSectionContent);

// Route for getting the other section content
router.get("/page-other", getOtherSectionContent);

module.exports = router;
