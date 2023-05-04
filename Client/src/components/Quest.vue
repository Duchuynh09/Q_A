<template>
  <div>
    <h4>Câu hỏi: {{ Quest.quest }}</h4>
    <p v-for="(anwser, index) in Quest.anwsers" :key="anwser.id">
      {{ anwserLabel[index] + ". " + anwser }}
    </p>
    <div class="btn-group">
      <router-link
        class="btn btn-warning"
        :to="{ name: 'editQuest', params: { id: this.Quest._id } }"
      >
        Sửa
      </router-link>
      <button v-if="isLogin" class="btn btn-danger" @click="deleteQuest">
        Xoa
      </button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      anwserLabel: ["A", "B", "C", "D"],
      isLogin: localStorage.getItem("login"),
    };
  },
  props: {
    i: { type: String },
    Quest: { Type: Object },
  },
  emits: ["delete:quest"],
  methods: {
    deleteQuest() {
      this.$emit("delete:quest", this.Quest._id);
    },
  },
};
</script>

<style></style>
