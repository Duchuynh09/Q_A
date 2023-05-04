<script>
import Navigator from "./components/Navigator.vue";
import SideBar from "./components/SideBar.vue";
export default {
  data() {
    return { sort: 0 };
  },
  components: {
    Navigator,
    SideBar,
  },
  methods: {
    sortFollowing(typeSort) {
      this.sort = typeSort;
    },
  },
};
</script>
<template>
  <div class="container-fluid">
    <div class="row h-100">
      <SideBar @sortSelect="sortFollowing" class="col-sm-3 sideBar" />
      <div class="col-sm-3"></div>
      <!-- <Register class="container col-sm-9" /> -->
      <router-view :selectSort="sort" class="container col-sm-9" />
    </div>
  </div>
</template>
<style scoped>
.container-fluid {
  height: 100vh;
}
.sideBar {
  position: fixed;
  height: 100vh;
}
</style>
