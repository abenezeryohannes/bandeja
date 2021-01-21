<template>
    <div :class="class1">
    	<a v-on:click="toggle_open" v-click-outside="close" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
        <div :class="class2">
            <router-link v-if="actions.show"  :to="{ name : actions.show, params: { id: id } }" class="dropdown-item">Show</router-link> 
            <router-link v-if="actions.edit"  :to="{ name : actions.edit, params: { id: id } }" class="dropdown-item">Edit</router-link> 
            <div class="dropdown-divider" v-if="actions.destroy"></div> 
            <button v-if="actions.destroy" type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
        </div>
    </div>
</template>

<script>
export default {
    props: ["id","actions"],
    data() {
        return {
            class1: 'dropdown ',
            class2: 'dropdown-menu dropdown-menu-right dropdown-menu-arrow ',
            default1: 'dropdown ',
            default2: 'dropdown-menu dropdown-menu-right dropdown-menu-arrow ',
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
