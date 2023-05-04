const ApiError = require("../api-error");
const MongoDB = require("../utils/mongodb.util");
const UserService = require("../services/user.service");
exports.findOne = async (req, res) => {
  try {
    const userService = new UserService(MongoDB.client);
    const user = await userService.findById(req.params.id);
    return res.send(user);
  } catch (error) {
    console.log(error);
  }
};
exports.checkLogin = async (req, res, next) => {
  if (!req.body?.email) {
    return next(new ApiError(400, "Không tồn tại dữ liệu kiểm tra"));
  }
  try {
    const userService = new UserService(MongoDB.client);
    const login = await userService.findByEmail(req.body.email);
    if (login[0].password == req.body.password) {
      return res.send({
        statusCode: 200,
        idUser: login[0]._id,
        message: "đăng nhập thành công",
      });
    } else return res.send(new ApiError(400, "Email hoặc mật khẩu sai"));
  } catch (error) {
    console.log(error);
  }
};
exports.create = async (_req, res, next) => {
  if (!_req.body?.email) {
    return next(new ApiError(400, "Không tồn tại dữ liệu để tạo"));
  }
  try {
    const userService = new UserService(MongoDB.client);
    if ((await userService.findByEmail(_req.body.email)).length == 0) {
      const document = await userService.create(_req.body);
      return res.send(document);
    }
    return res.send(new ApiError(400, "Email đã tồn tại"));
  } catch (error) {
    return next(
      new ApiError(
        500,
        "Đã xảy ra lỗi khi tạo người dùng, kiểm tra lại service"
      )
    );
  }
};
