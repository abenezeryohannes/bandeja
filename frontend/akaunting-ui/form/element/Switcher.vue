<template>
    <div :class="['form-group', column, required]"  style="padding-left: 15px;">
        <label for="enabled" class="form-control-label">{{label}}</label>



        <div class="input-group input-group-merge ">

            <!-- <div class="input-group-prepend"><span class="input-group-text"></span></div>  -->

        <!-- <div role="tabpanel" class="tab-pane tab-example-result fade show active"> -->
            <div  class="btn-group btn-group-toggle radio-yes-no">
            	<!-- <label class="btn btn-success active">Yes</label>  -->
            	<label v-for="f in options" :class="get_option_class(f.value || f,selected)" v-on:click="select_option(f.value || f)">{{f.label || f}}</label>
            </div>
        </div>
    </div>
</template>


<script>
    export default {
        props: ["default","options","label","value","multiple","required","column"],
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
            	if (this.multiple == "multiple") {
	            	this.selected = this.value || []
	            	this.selected = this.selected.concat(this.default)
            	}else{
	            	this.selected = this.value || this.default
            	}
            	this.$emit('input', this.selected)
            },
            get_option_class(f, selected){
            	if (this.multiple == "multiple") {
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
            	if (this.multiple == "multiple") {
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
