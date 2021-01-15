<template>
    <div :class="['form-group', column, required]">
        <label for="enabled" class="form-control-label">{{label}}</label>
        <div class="input-group input-group-merge ">
            <div class="input-group-prepend"><span class="input-group-text"><i :class="icon"></i></span></div> 
            <select v-bind:value="value" class="form-control el-scrollbar__view el-select-dropdown__list" v-on:input="$emit('input', $event.target.value)">
                <template v-if="options[0] && typeof options[0] == 'string'">                
                    <option class="el-select-dropdown__item" v-for="o in options" :value="o" >{{o}}</option>
                </template>
                <template v-else-if="options[0] && typeof options[0] == 'object'">
                    <option class="el-select-dropdown__item" v-for="o in options" :value="o.value" >{{o.label}}</option>
                </template>
            </select>
        </div>
    </div>
</template>
<script>
export default {
    props: [ "label", "value","icon","options","required","type","column"],
    data() {
        return {
        }
    },
    watch: {
        // active: 'mount_active',
        // active_tab : 'notify_up'
    },
    methods: {

    },
    mounted() {

    }
}

</script>
<style scoped>
</style>
