const { ObjectId } = require("mongodb");
class QuestService {
  constructor(client) {
    this.quest = client.db().collection("question");
  }
  async create(payload) {
    const quest = {
      quest: payload.quest,
      anwsers: payload.anwsers,
      anwserCorrect: payload.anwserCorrect,
      type: payload.type,
    };
    try {
      const result = await this.quest.findOneAndUpdate(
        quest,
        { $set: { _id: new ObjectId() } },
        { returnDocument: "after", upsert: true }
      );
      return result.value;
    } catch (error) {
      console.log(error);
    }
  }
  async findById(id) {
    return await this.quest.findOne({
      _id: ObjectId.isValid(id) ? new ObjectId(id) : null,
    });
  }
  async find(filter) {
    const cursor = await this.quest.find(filter);
    return await cursor.toArray();
  }
  async findByQuest(quest) {
    return await this.find({
      quest: { $regex: new RegExp(quest), $options: "i" },
    });
  }
  async update(id,payload){
    const quest = {
      quest: payload.quest,
      anwsers: payload.anwsers,
      anwserCorrect: payload.anwserCorrect,
      type: payload.type,
    };
    try {
      const result = await this.quest.findOneAndUpdate(
        {_id : ObjectId.isValid(id) ? new ObjectId(id) : null,},
        {$set : quest},
        { returnDocument: "after", upsert: true }
      );
      return result.value;
    } catch (error) {
      console.log(error);
    }
  }
  async delete(id) {
    const result = await this.quest.findOneAndDelete({
      _id: ObjectId.isValid(id) ? new ObjectId(id) : null,
    });
    return result.value;
  }
}
module.exports = QuestService;
