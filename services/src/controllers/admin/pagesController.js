const Page = require("../../models/pages");

// Create a new page
const createPage = async (req, res) => {
  try {
    const pageData = req.body;
    const createdPage = await Page.create(pageData);
    res.status(201).json({ success: true, data: createdPage });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
};

// Update a page by ID
const updatePage = async (req, res) => {
  try {
    const { id } = req.params;
    const pageData = req.body;
    const updatedPage = await Page.findByIdAndUpdate(id, pageData, {
      new: true,
      runValidators: true,
    });
    if (!updatedPage) {
      return res
        .status(404)
        .json({ success: false, message: "Page not found" });
    }
    res.status(200).json({ success: true, data: updatedPage });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
};

module.exports = {
  createPage,
  updatePage,
};
