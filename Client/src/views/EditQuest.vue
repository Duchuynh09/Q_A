<template>
  <QuestForm
    nameForm="Chỉnh sửa câu hỏi"
    v-if="questActive != {}"
    :Quest="questActive"
    @submit:quest="updateQuest"
    @delete:quest="deleteQuest"
  />
</template>

<script>
import QuestForm from "../components/QuestForm.vue";
import questService from "../services/quest.service";
export default {
  components: {
    QuestForm,
  },
  data() {
    return { questActive: {}, message: "" };
  },
  created() {
    this.getQuest(this.$route.params.id);
  },
  methods: {
    async getQuest(id) {
      try {
        this.questActive = await questService.get(id);
      } catch (error) {
        console.log(error);
      }
    },
    async updateQuest(data) {
      try {
        await questService.update(this.questActive._id, data);
        this.message = "Cập nhật thành công.";
        await setTimeout(() => {
          this.$router.push({ name: "home" });
        }, 500);
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>

<style></style>
