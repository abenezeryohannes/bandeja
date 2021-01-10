<template>
    <div class="box-body box-profile" >

        <img v-if="url" class="profile-user-img img-responsive img-circle" v-bind:src="url" alt="picture">

        <template v-if="localImg">
            <img class="profile-user-img img-responsive img-circle" v-bind:src="localImg" alt="picture">
            <button  v-if="!uploading" v-on:click="upload_image" class="btn  btn-success ">Upload</button>
            <button v-if="!uploading" v-on:click="cancel_upload_image" class="btn  btn-danger">Cancel</button>
            <i v-if="uploading" style="text-align: center;">Uploading ...</i>
        </template>
        <template>
            <input type="file" v-on:change="onPicInput">
        </template>

        <slot></slot>
    </div>
</template>

<script>
    export default {
        name: "AvatarMgt",
        props: [
            'url'
        ],
        data() {
            return {
                theImage : null,
                localImg: null,
                uploading: false,
            }
        },
        watch : {
            url : 'boot'
        },
        mounted() {
          this.boot()
        },
        methods: {
            onPicInput(event){
                this.theImage = event.target.files[0]
                this.localImg = URL.createObjectURL(this.theImage)
            },
            cancel_upload_image(){
                this.localImg = null
                this.theImage = null
            },
            upload_image(){
                this.uploading = true
                this.uploading = false
            },
            boot(){
                if(url){

                }else{

                }
            }
        }
    }
</script>

<style scoped>

</style>