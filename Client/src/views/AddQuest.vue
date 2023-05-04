<template>
  <QuestForm
    v-if="quest"
    :Quest="quest"
    @submit:quest="addQuest"
    nameForm="Thêm câu hỏi"
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
    return {
      quest: {
        quest: "",
        anwsers: [],
        anwserCorrect: 0,
        type: 0,
      },
    };
  },
  methods: {
    async addQuest(data) {
      try {
        await questService.create(data);
        this.message = "Thêm câu hỏi thành công.";
      } catch (error) {
        console.log(error);
      }
      await setTimeout(() => {
        this.$router.push({ name: "home" });
      }, 500);
    },
  },
};
</script>

<style></style>
