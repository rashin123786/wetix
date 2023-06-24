const mongoose = require("mongoose");

const pageSchema = new mongoose.Schema(
  {
    aboutSectionContent: {
      heading: {
        type: String,
        required: [true, "About section heading is required"],
      },
      video: String,
      image: String,
      subHeading1: String,
      subHeading2: String,
      subDescriptionHeading1: String,
      subDescriptionHeading2: String,
    },
    contactSectionContent: {
      heading: {
        type: String,
        required: [true, "Contact section heading is required"],
      },
      phone: String,
      email: String,
      description: String,
    },
    bannerSectionContent: {
      image: {
        type: String,
        required: [true, "Banner section image is required"],
      },
      redirectUrl: {
        type: String,
        required: [true, "Banner section redirect URL is required"],
      },
    },
    otherSectionContent: {
      siteLogoChange: String,
      faviconIcon: String,
    },
  },
  { timestamps: true }
);

const Page = mongoose.model("Page", pageSchema);

module.exports = Page;
