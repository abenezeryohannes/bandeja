<template>
    <div :class="['form-group', column, required]">
        <label class="form-control-label">{{label}}</label>
        <div class="custom-file">
            <input v-on:change="onUpload" type="file"  class="custom-file-input cursor-pointer"> 
            <label class="custom-file-label"> <img v-if="img_preview" :src="img_preview">  {{file_name}}</label>
        </div>
        <div class="invalid-feedback d-block" v-if="error_msg && error_msg[0] && error_msg[0][error_msg[1]] ">
            <template v-if="error_msg[0][error_msg[1]].length == 1">
                {{error_msg[0][error_msg[1]][0]}}
            </template>
            <template v-else>
                <ul>
                    <li v-for="i in error_msg[0][error_msg[1]]" >{{i}}</li>
                </ul>
            </template>
        </div>
    </div>
</template>
<script>
export default {
    props: ["label", "value", "icon", "placeholder", "required", "type", "column","error_msg"],
    data() {
        return {
            file_name: 'select file',
            img_preview: null
        }
    },
    watch: {
        // active: 'mount_active',
        // active_tab : 'notify_up'
    },
    methods: {

        onUpload(event){
            var file = event.target.files[0]
            this.file_name = file.name
            if (
                file.type == 'image/jpeg' &&
                file.type == 'image/png'
            ) {
                this.img_preview = URL.createObjectURL(file)
            }
            this.$emit('input', file)
            // console.log(file)
        },
    },
    mounted() {
    }
}

</script>
<style scoped>
</style>
