<template>
  <User formName="Đăng nhập" @submit:user="login" />
</template>
<script>
import User from "../components/UserForm.vue";
import userService from "../services/user.service";
export default {
  components: { User },
  data() {
    return {
      state: {},
    };
  },
  methods: {
    async login(data) {
      this.state = await userService.checkLogin(data);
      if (this.state.statusCode == 200) {
        localStorage.setItem("login", true);
        localStorage.setItem("idUser", this.state.idUser);
        this.$router.push({ name: "home" });
      } else alert("Sai Email hoặc mật khẩu");
    },
  },
};
</script>
<style lang=""></style>
