<template>

    <div :class="class1">
        <button v-on:click="toggle_open" v-click-outside="close" type="button" data-toggle="dropdown" :aria-expanded="opened" class="btn btn-primary header-button-top"><i class="fa fa-chevron-down"></i>&nbsp; More Actions</button>

        <div :class="class2" x-placement="top-start" >
            <slot></slot>
        </div>
    </div>
</template>

<script>
export default {
    props: ["id","actions"],
    data() {
        return {
            class1: 'dropup header-drop-top ',
            class2: 'dropdown-menu ',
            default1: 'dropup header-drop-top ',
            default2: 'dropdown-menu ',
            opened: false,
        }
    },

    methods: {
        toggle_open(){
        	console.log(this.opened)
        	if (this.opened) {
        		this.close()
        	}else{
	        	this.class1 = this.default1+"show"
	        	this.class2 = this.default2+"show"
	        	this.opened = true
        	}
        },

        close(){
        	this.class1 = this.default1
        	this.class2 = this.default2
        	this.opened = false
        }

    },
    mounted() {

    }
}

</script>
<style scoped>
</style>
