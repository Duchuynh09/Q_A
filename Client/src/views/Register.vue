<template>
  <div>
    <User @submit:user="register" formName="Đăng ký" :register="true" />
  </div>
</template>
<script>
import User from "../components/UserForm.vue";
import userService from "../services/user.service";
export default {
  components: { User },
  data() {
    return { message: "" };
  },
  methods: {
    async register(userForm) {
      try {
        let state = (await userService.create(userForm)).statusCode;
        this.message = (await userService.create(userForm)).message;
        if (state != 400) {
          alert("Đăng kí thành công");
          this.$router.push({ name: "login" });
        } else {
          alert(this.message);
        }
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>
<style lang=""></style>
