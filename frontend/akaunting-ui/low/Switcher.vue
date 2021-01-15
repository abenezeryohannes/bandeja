<template>
    <div>
        <label for="enabled" class="form-control-label">{{label}}</label>
        <div role="tabpanel" class="tab-pane tab-example-result fade show active">
            <div data-toggle="buttons" class="btn-group btn-group-toggle radio-yes-no">
            	<!-- <label class="btn btn-success active">Yes</label>  -->
            	<label v-for="f in source.options" :class="get_option_class(f,selected)" v-on:click="select_option(f)">{{f}}</label>
            </div>
        </div>
    </div>
</template>


<script>
    export default {
        props: ["source","label","value","multiple"],
        data() {
            return {
            	selected: []
            }
        },
        watch : {
            // active: 'mount_active',
            // active_tab : 'notify_up'
        },
        methods : {
            boot(){
            	if (this.multiple) {
	            	this.selected = this.value || []
	            	this.selected = this.selected.concat(this.source.default)
            	}else{
	            	this.selected = this.value || this.source.default
            	}
            	this.$emit('input', this.selected)
            },
            get_option_class(f, selected){
            	if (this.multiple) {
	            	if (selected.indexOf(f) == -1) {
		            	return "btn btn-danger"
	            	}
            	}else{
            		if (selected != f) {
		            	return "btn btn-danger"
	            	}
            	}
            	return "btn btn-success active"
            },
            select_option_multiple(f){
            	if (this.selected.indexOf(f) == -1) {
            		this.selected = this.selected.concat(f)
            	}else{
            		var t1 = this.selected.slice(0,this.selected.indexOf(f))
            		var t2= []
            		if (this.selected.indexOf(f)!= this.selected.length-1) {
            			t2 = this.selected.slice(this.selected.indexOf(f)+1,this.selected.length)
            		}
            		this.selected = t1.concat(t2)
            	}
            },
            select_option_single(f){
            	if (this.selected != f) {
            		this.selected = f
            	}else{
            		this.selected = null
            	}
            },
            select_option(f){
            	if (this.multiple) {
            		this.select_option_multiple(f)
            	}else{
            		this.select_option_single(f)
            	}
            	this.$emit('input', this.selected)
            	// this.$emit('input', $event.target.value)
            }
        },
        mounted(){
        	this.boot()
        }
    }
</script>

<style scoped>

</style>
