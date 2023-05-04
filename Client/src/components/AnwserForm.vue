<template>
    <div class="form-group">
      <label for="" class="form-label">Câu trả lời1</label>
      <Field name="anwser1" class="form-control" v-model="Quest.anwsers[0]"></Field>
    </div>
</template>
<script>
    export default{
        props:{
            anwser:{type:Object,required:true}
        }
    }
</script>
