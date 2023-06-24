const Page = require("../../models/pages");

// Get the about section content
const getAboutSectionContent = async (req, res) => {
  try {
    const page = await Page.findOne({}, "aboutSectionContent");

    if (!page) {
      return res
        .status(404)
        .json({ success: false, message: "Page not found" });
    }

    res.status(200).json({
      success: true,
      message: "About section content retrieved successfully.",
      aboutSectionContent: page.aboutSectionContent,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Get the contact section content
const getContactSectionContent = async (req, res) => {
  try {
    const page = await Page.findOne({}, "contactSectionContent");

    if (!page) {
      return res
        .status(404)
        .json({ success: false, message: "Page not found" });
    }

    res.status(200).json({
      success: true,
      message: "Contact section content retrieved successfully.",
      contactSectionContent: page.contactSectionContent,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Get the banner section content
const getBannerSectionContent = async (req, res) => {
  try {
    const page = await Page.findOne({}, "bannerSectionContent");

    if (!page) {
      return res
        .status(404)
        .json({ success: false, message: "Page not found" });
    }

    res.status(200).json({
      success: true,
      message: "Banner section content retrieved successfully.",
      bannerSectionContent: page.bannerSectionContent,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Get the other section content
const getOtherSectionContent = async (req, res) => {
  try {
    const page = await Page.findOne({}, "otherSectionContent");

    if (!page) {
      return res
        .status(404)
        .json({ success: false, message: "Page not found" });
    }

    res.status(200).json({
      success: true,
      message: "Other section content retrieved successfully.",
      otherSectionContent: page.otherSectionContent,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

module.exports = {
  getAboutSectionContent,
  getContactSectionContent,
  getBannerSectionContent,
  getOtherSectionContent,
};
