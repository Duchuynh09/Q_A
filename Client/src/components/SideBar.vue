<template>
  <div class="xd-flex flex-column flex-shrink-0 p-3 text-bg-dark">
    <router-link
      to="/"
      class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none"
    >
      <svg class="bi pe-none me-2" width="40" height="32">
        <use xlink:href="#bootstrap"></use>
      </svg>
      <span class="fs-4"> ADMINITRATORS</span>
    </router-link>
    <hr />
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <router-link
          to="/"
          class="nav-link text-white"
          :class="[this.$route.name == 'home' ? 'active' : '']"
          aria-current="page"
        >
          <svg class="bi pe-none me-2" width="16" height="16">
            <use xlink:href="#home"></use>
          </svg>
          Home
        </router-link>
      </li>
      <li>
        <!-- <router-link class="dropdown-item" to="/addQuest" >Them cau hoi</router-link> -->
        <router-link
          :class="[this.$route.name == 'addQuest' ? 'active' : '']"
          to="/addQuest"
          class="nav-link text-white"
        >
          <svg class="bi pe-none me-2" width="16" height="16">
            <use xlink:href="#speedometer2"></use>
          </svg>
          Thêm câu hỏi
        </router-link>
      </li>
      <div v-if="userActive.name">
        <hr />

        Sắp xếp theo
        <select
          class="form-select bg-dark text-white"
          aria-label="Default select example"
          @change="changeSelect"
        >
          <option class="text-white" value="0">Tất cả</option>
          <option class="text-white" value="1">Triết học</option>
          <option class="text-white" value="2">Kinh tế Chính trị</option>
          <option class="text-white" value="3">Lịch sử đảng</option>
          <option class="text-white" value="4">Tư Tưởng</option>
        </select>
      </div>
    </ul>
    <hr />
    <div class="dropdown" v-if="userActive.name">
      <a
        href="#"
        class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
        data-bs-toggle="dropdown"
        aria-expanded="false"
      >
        <img
          src="https://cdn.landesa.org/wp-content/uploads/default-user-image.png"
          alt=""
          width="32"
          height="32"
          class="rounded-circle me-2"
        />
        <strong>{{ userActive.name }}</strong>
      </a>
      <ul class="dropdown-menu dropdown-menu-dark text-small shadow">
        <!-- <li><a class="dropdown-item" href="#">New project...</a></li>
        <li><a class="dropdown-item" href="#">Settings</a></li>
        <li><a class="dropdown-item" href="#">Profile</a></li>
        <li>
          <hr class="dropdown-divider" />
        </li> -->
        <li>
          <router-link class="dropdown-item" @click="signOut" to="/login"
            >Sign out</router-link
          >
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import userService from "../services/user.service";
export default {
  methods: {
    signOut() {
      localStorage.clear();
    },
    async activeUser() {
      this.userActive = await userService.get(localStorage.getItem("idUser"));
    },
    changeSelect(data) {
      this.$emit("sortSelect", data.target.value);
    },
  },
  data() {
    return {
      typeSort: 0,
      userActive: {},
    };
  },
  beforeUpdate() {
    this.activeUser();
  },
  mounted() {
    this.activeUser();
  },
};
</script>
<style></style>
