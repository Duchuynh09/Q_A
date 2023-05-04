<template>
  <Form @submit="submitUser" :validation-schema="userSchema">
    <div class="form-group mb-3" v-if="register">
      <label for="" class="form-label h3">Tên</label>
      <Field name="name" class="form-control" v-model="userLocal.name"></Field>
      <ErrorMessage class="error" name="name" />
    </div>
    <div class="form-group mb-3">
      <label for="" class="form-label h3">Email</label>
      <Field
        name="email"
        class="form-control"
        v-model="userLocal.email"
      ></Field>
      <ErrorMessage class="error" name="email" />
    </div>
    <div class="form-group mb-3">
      <label for="" class="form-label h3">Mật khẩu</label>
      <Field
        type="password"
        name="password"
        class="form-control"
        v-model="userLocal.password"
      ></Field>
      <ErrorMessage class="error" name="password" />
    </div>
    <div class="form-group mb-3" v-if="register">
      <label for="" class="form-label h3">Nhập lại mật khẩu</label>
      <Field
        type="password"
        name="confirm_password"
        class="form-control"
      ></Field>
      <ErrorMessage class="error" name="confirm_password" />
    </div>
    <div v-if="!register" class="">
      <router-link :to="{ name: 'register' }"
        ><small>Bạn chưa có tài khoản</small></router-link
      >
    </div>
    <div>
      <button class="btn btn-success">{{ formName }}</button>
    </div>
  </Form>
</template>
<script>
import { Form, Field, ErrorMessage } from "vee-validate";
import * as yup from "yup";
export default {
  components: {
    Form,
    Field,
    ErrorMessage,
  },
  emits: ["submit:user"],
  props: {
    formName: String,
    register: Boolean,
  },
  data() {
    const userSchemaLogin = yup.object().shape({
      email: yup.string().email().required("Định dạng phải kiểu 123@abc.com"),
      password: yup.string().required("Bắt buộc nhập mật khẩu"),
    });
    const userSchemaRegister = yup.object().shape({
      email: yup.string().email().required("Định dạng phải kiểu 123@abc.com"),
      password: yup
        .string()
        .min(8, "Tối thiểu 8 kí tự")
        .required("Bắt buộc nhập mật khẩu"),
      confirm_password: yup
        .string()
        .required("Không thể để trống")
        .oneOf([yup.ref("password"), null], "Mật khẩu phải trùng khớp"),
      name: yup
        .string()
        .required("Không thể để trống!!")
        .max(25, "Tối đa 25 kí tự !!"),
    });
    var userSchema = userSchemaLogin;
    if (this.register) {
      userSchema = userSchemaRegister;
    } else userSchema = userSchemaLogin;
    return { userSchema, userLocal: {} };
  },
  methods: {
    submitUser(data) {
      this.$emit("submit:user", this.userLocal);
    },
  },
};
</script>
<style>
.error {
  color: red;
}
</style>
