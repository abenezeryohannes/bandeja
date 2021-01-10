<template>
        <div  :class="theClass" >
            <button v-click-outside="close" v-on:click="toggleView"
                    :class="['btn', btnClass, 'btn-lg', 'dropdown-toggle']" >
                <slot></slot>
                <span class="fa fa-caret-down"></span>
            </button>
            <ul class="dropdown-menu">
                <slot name="list"></slot>
            </ul>
        </div>
</template>

<script>
    export default {
        name: "ManyActions",
        props: ['btnType'],
        data() {
            return {
                opened: false,
                theClass: 'input-group-btn ',
                btnClass: 'btn-default',
            }
        },
        watch : {
          opened: 'updateClass'
        },
        mounted() {
          if(this.btnType){
              this.btnClass = this.btnType
          }else{
              this.btnClass = 'btn-default'
          }
        },
        methods : {
            close(){
              this.opened = false
            },
            updateClass(){
              if(this.opened){
                  this.theClass = 'input-group-btn open'
              }else{
                  this.theClass = 'input-group-btn '
              }
            },
            toggleView() {
                this.opened = !this.opened
                // this.updateClass()
            }
        }
    }
</script>

<style scoped>

</style>