const ApiError = require("../api-error");
const MongoDB = require("../utils/mongodb.util");
const QuestService = require("../services/quest.service");

exports.create = async (_req, res, next) => {
  if (!_req.body?.quest) {
    return next(new ApiError(400, "Câu hỏi rỗng"));
  }
  try {
    const questService = new QuestService(MongoDB.client);
    const document = await questService.create(_req.body);
    return res.send(document);
  } catch (error) {
    return next(
      new ApiError(500, "Đã xảy ra lỗi khi tạo câu hỏi, kiểm tra lại service")
    );
  }
};
exports.findALl = async (req, res, next) => {
  let documents = [];
  try {
    const service = new QuestService(MongoDB.client);
    const { quest } = req.query;
    if (quest) {
      documents = await service.findByQuest(quest);
    } else {
      documents = await service.find({});
    }
  } catch (error) {
    console.log(error);
    return next(new ApiError(500, "Lỗi khi truy xuất câu hỏi"));
  }
  return res.send(documents);
};
exports.findOne = async (req, res, next) => {
  const id = req.params.id;
  try {
    const service = new QuestService(MongoDB.client);
    const document = await service.findById(id);
    return res.status(200).json({ document });
  } catch (error) {
    return next(new ApiError(500, "Đã xảy ra lỗi khi truy xuất câu hỏi"));
  }
};
exports.update = async (_req, res, next) => {
  const id = _req.params.id;
  try {
    const service = new QuestService(MongoDB.client);
    const document = await service.update(id, _req.body);
    return res.status(200).json({ document });
  } catch (error) {
    return next(new ApiError(500, "Đã xảy ra lỗi khi cập nhật câu hỏi"));
  }
};
exports.delete = async (req, res, next) => {
  const id = req.params.id;
  try {
    const service = new QuestService(MongoDB.client);
    const document = await service.delete(id);
    if (!document) {
      return next(new ApiError(404, "Không tìm thấy câu hỏi"));
    } else {
      return res.send({ message: "Xóa thành công" });
    }
  } catch (error) {
    return next(new ApiError(500, "Đã xảy ra lỗi khi xóa câu hỏi"));
  }
};
