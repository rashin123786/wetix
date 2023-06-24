require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const fileupload = require("express-fileupload");

const app = express();
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(fileupload());

const userRoute = require("./src/routes/admin/user.js");
const eventRoute = require("./src/routes/admin/event.js");
const orgRoutes = require("./src/routes/admin/organizers.js");
const pageRoutes = require("./src/routes/admin/pages.js");
const orderRoutes = require("./src/routes/admin/orders.js");
const pageRoute = require("./src/routes/users/page.js");
const cartRoute = require("./src/routes/users/cart.js");
const reviewRoute = require("./src/routes/users/review.js");
const dashboardRoute = require("./src/routes/users/dashboard.js");
const loginRoute = require("./src/routes/users/signup-login.js");
const connectToDb = require("./src/config/config");
const cors = require("cors");

app.use(
  cors({
    // origin: ["http://127.0.0.1:3000", "http://127.0.0.1:3001", "http://127.0.0.1:5173"],
    origin: "*",
  })
);

// app.use(express.json());
// app.use(bodyParser.urlencoded({ extended: true }));

connectToDb();

//app.use("/auth", require("./src/routes/user"));
app.use("/", userRoute);
app.use("/", eventRoute);
app.use("/", orgRoutes);
app.use("/", pageRoutes);
app.use("/", orderRoutes);
app.use("/", pageRoute);
app.use("/", cartRoute);
app.use("/", reviewRoute);
app.use("/", dashboardRoute);
app.use("/", loginRoute);
const PORT = process.env.PORT || 5000;

// Listen the server
app.listen(PORT, () => {
  console.log(`Server is running port: ${PORT}`);
});
