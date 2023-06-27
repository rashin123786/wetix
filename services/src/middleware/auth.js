const Token = require("../models/token");

const userAuth = async (req, res, next) => {
  const token = req.header("Authorization");
  const userId = req.body.userId || req.params.userId;

  if (!token) {
    return res
      .status(401)
      .json({ status: false, message: "Missing authentication token" });
  }

  try {
    const user = await Token.findOne({ user: userId, token: token });

    if (!user) {
      return res
        .status(401)
        .json({ status: false, message: "Invalid authentication token" });
    }

    req.userId = userId;
    next();
  } catch (error) {
    return res.status(500).json({
      status: false,
      message: "Error validating authentication token",
    });
  }
};

module.exports = userAuth;
