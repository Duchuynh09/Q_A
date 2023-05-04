<template>
  <div>
    <div
      v-if="selectSort == 0"
      v-for="(document, index) in documents"
      :key="document._id"
    >
      <Quest @delete:quest="deleteQuest" :Quest="document" :i="index + 1" />
    </div>
    <!-- ======================================================== -->
    <div v-for="(document, index) in documents" :key="document._id">
      <Quest
        v-if="document.type == selectSort"
        @delete:quest="deleteQuest"
        :Quest="document"
        :i="index + 1"
      />
    </div>
  </div>
</template>

<script>
import Quest from "../components/Quest.vue";
import questService from "../services/quest.service";
import SideBar from "../components/SideBar.vue";
import { number } from "yup";
export default {
  data() {
    return { documents: [] };
  },
  props: {
    selectSort: number,
  },
  methods: {
    async getApi() {
      this.documents = await questService.getAll();
    },
    async deleteQuest(id) {
      if (confirm("Bạn muốn xóa !!!")) {
        try {
          await questService.delete(id);
          this.message = "Đã được xóa";
          this.getApi();
        } catch (error) {
          console.log(error);
        }
      }
    },
  },
  mounted() {
    this.getApi();
  },
  components: { Quest, SideBar },
};
</script>

<style></style>
