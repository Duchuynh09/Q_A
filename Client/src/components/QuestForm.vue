<template>
  <Form @submit="submitQuest" :validation-schema="questSchema">
    <legend class="text-center bg-dark text-white h1">{{ nameForm }}</legend>
    <div class="form-group mb-3">
      <label for="" class="form-label h3">Câu hỏi</label>
      <Field
        name="quest"
        class="form-control"
        v-model="questLocal.quest"
      ></Field>
    </div>
    <div class="form-group row pb-1">
      <label for="anwser1" class="col-form-label col-sm-2">Câu A: </label>
      <div class="col-sm-10">
        <Field
          name="anwser1"
          class="form-control"
          v-model="questLocal.anwsers[0]"
        ></Field>
      </div>
    </div>
    <div class="form-group row pb-1">
      <label for="anwser2" class="col-form-label col-sm-2">Câu B: </label>
      <div class="col-sm-10">
        <Field
          name="anwser2"
          class="form-control"
          v-model="questLocal.anwsers[1]"
        ></Field>
      </div>
    </div>
    <div class="form-group row pb-1">
      <label for="anwser3" class="col-form-label col-sm-2">Câu C: </label>
      <div class="col-sm-10">
        <Field
          name="anwser3"
          class="form-control"
          v-model="questLocal.anwsers[2]"
        ></Field>
      </div>
    </div>
    <div class="form-group row">
      <label for="anwser4s" class="col-form-label col-sm-2">Câu D: </label>
      <div class="col-sm-10">
        <Field
          name="anwser4"
          class="form-control"
          v-model="questLocal.anwsers[3]"
        ></Field>
      </div>
    </div>
    <div class="form-group">
      <fieldset class="row">
        <legend>Đáp án đúng</legend>
        <div class="col-3 form-check">
          <label for="" class="form-check-label">Câu A</label>
          <input
            type="radio"
            class="form-check-input"
            name="anwserCorrect"
            :value="0"
            v-model="questLocal.anwserCorrect"
          />
        </div>
        <div class="col-3 form-check">
          <label for="" class="form-check-label">Câu B</label>
          <input
            type="radio"
            class="form-check-input"
            name="anwserCorrect"
            :value="1"
            v-model="questLocal.anwserCorrect"
          />
        </div>
        <div class="col-3 form-check">
          <label for="" class="form-check-label">Câu C</label>
          <input
            type="radio"
            class="form-check-input"
            name="anwserCorrect"
            :value="2"
            v-model="questLocal.anwserCorrect"
          />
        </div>
        <div class="col-3 form-check">
          <label for="" class="form-check-label">Câu D</label>
          <input
            type="radio"
            class="form-check-input"
            name="anwserCorrect"
            :value="3"
            v-model="questLocal.anwserCorrect"
          />
        </div>
      </fieldset>
    </div>
    <div class="form-group">
      <fieldset class="row">
        <legend>Bộ câu hỏi</legend>
        <div class="col-3 form-check">
          <label for="type" class="form-check-label">Triết học</label>
          <input
            type="radio"
            class="form-check-input"
            name="type"
            :value="1"
            v-model="questLocal.type"
          />
        </div>
        <div class="col-3 form-check">
          <label for="type" class="form-check-label">Lịch sử Đảng</label>
          <input
            type="radio"
            class="form-check-input"
            name="type"
            :value="3"
            v-model="questLocal.type"
          />
        </div>
        <div class="col-3 form-check">
          <label for="type" class="form-check-label">Kinh tế chính trị</label>
          <input
            type="radio"
            class="form-check-input"
            name="type"
            :value="2"
            v-model="questLocal.type"
          />
        </div>
        <div class="col-3 form-check">
          <label for="type" class="form-check-label"
            >Tư tưởng Hồ Chí Minh</label
          >
          <input
            type="radio"
            class="form-check-input"
            name="type"
            :value="4"
            v-model="questLocal.type"
          />
        </div>
      </fieldset>
    </div>
    <div>
      <button class="btn btn-success">Xác nhận</button>
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
  emits: ["submit:quest"],
  props: {
    nameForm: String,
    Quest: { type: Object, required: true },
  },
  data() {
    const questSchema = yup.object().shape({
      quest: yup.string().required(),
      anwser1: yup.string().required(),
      anwser2: yup.string().required(),
      anwser3: yup.string().required(),
      anwser4: yup.string().required(),
    });
    return { questSchema, questLocal: this.Quest };
  },
  methods: {
    submitQuest() {
      this.$emit("submit:quest", this.questLocal);
    },
  },
};
</script>
<style>
.col-form-label {
  font-size: large;
}
</style>
