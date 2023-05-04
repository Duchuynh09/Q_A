const express = require("express");
const cors = require("cors");
const questRouter = require("./app/routes/quest.route");
const userRoute = require("./app/routes/user.route");
const ApiError = require("./app/api-error");
const app = express();
app.use(cors());
app.use(express.json());
app.use("/api/quests", questRouter);
app.use("/api/users", userRoute);

app.use((req, res, next) => {
  return next(new ApiError(404, "Resource not founde"));
});
app.use((error, req, res, next) => {
  return res.status(error.statusCode || 500).json({
    message: error.message || "Inernal Server Error",
  });
});
module.exports = app;
