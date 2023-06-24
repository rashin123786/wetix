const Organizer = require("../../models/organizers");

// Create an organizer
const createOrganizer = async (req, res) => {
  try {
    const { company_name, address, status, action } = req.body;

    if (!company_name || !address) {
      return res.status(400).json({
        success: false,
        message: "Company name and address are required",
      });
    }

    const newOrganizer = new Organizer({
      company_name,
      address,
      status,
      action,
    });

    const savedOrganizer = await newOrganizer.save();

    res.status(201).json({
      success: true,
      message: "Organizer created successfully.",
      organizer: savedOrganizer,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Update an organizer by ID
const updateOrganizer = async (req, res) => {
  try {
    const { id } = req.params;
    const { company_name, address, status, action } = req.body;

    // Check if the organizer exists
    const organizer = await Organizer.findById(id);
    if (!organizer) {
      return res
        .status(404)
        .json({ success: false, message: "Organizer not found" });
    }

    // Update the organizer
    organizer.company_name = company_name;
    organizer.address = address;
    organizer.status = status;
    organizer.action = action;

    const updatedOrganizer = await organizer.save();

    res.status(200).json({
      success: true,
      message: "Organizer updated successfully",
      organizer: updatedOrganizer,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Get all organizers
const getAllOrganizers = async (req, res) => {
  try {
    const organizers = await Organizer.find({ is_delete: false });

    res.status(200).json({
      success: true,
      message: "Organizers retrieved successfully.",
      organizers,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Get an organizer by ID
const getOrganizerById = async (req, res) => {
  try {
    const organizerId = req.params.id;

    const organizer = await Organizer.findOne({
      _id: organizerId,
      is_default: false,
    });

    if (!organizer) {
      return res
        .status(404)
        .json({ success: false, message: "Organizer not found" });
    }

    res.status(200).json({
      success: true,
      message: "Organizer retrieved successfully.",
      organizer,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

// Delete an organizer
const deleteOrganizer = async (req, res) => {
  try {
    const { id } = req.params;

    // Check if the organizer exists
    const organizer = await Organizer.findById(id);
    if (!organizer) {
      return res
        .status(404)
        .json({ success: false, message: "Organizer not found" });
    }

    // Update the is_delete field to true
    organizer.is_delete = true;

    const updatedOrganizer = await organizer.save();

    res.status(200).json({
      success: true,
      message: "Organizer deleted successfully",
      organizer: updatedOrganizer,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ success: false, message: "Internal server error" });
  }
};

module.exports = {
  createOrganizer,
  updateOrganizer,
  getAllOrganizers,
  getOrganizerById,
  deleteOrganizer,
};
