const { ObjectId } = require("mongodb");
class UserService {
  constructor(client) {
    this.user = client.db().collection("user");
  }
  async create(payload) {
    const userCreate = {
      name: payload.name,
      email: payload.email,
      password: payload.password,
    };
    try {
      const result = await this.user.findOneAndUpdate(
        userCreate,
        { $set: { _id: new ObjectId() } },
        { returnDocument: "after", upsert: true }
      );
      return result.value;
    } catch (error) {
      console.log(error);
    }
  }
  async findByEmail(email) {
    return await this.user
      .find({
        email: email,
      })
      .toArray();
  }
  async findById(id) {
    return await this.user.findOne({
      _id: ObjectId.isValid(id) ? new ObjectId(id) : null,
    });
  }
}
module.exports = UserService;
