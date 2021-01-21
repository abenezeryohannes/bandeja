<template>
    <div :class="[outerClass, column, required]">
        <label v-if="label" for="enabled" class="form-control-label">{{label}}</label>
        <div class="input-group input-group-merge ">
            <div v-if="icon" class="input-group-prepend"><span class="input-group-text"><i :class="icon"></i></span></div> 
            <select style="min-width: 100px;" v-bind:value="value" :class="innerClass" v-on:input="$emit('input', $event.target.value)">
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
    props: [ "label", "value","icon","options","required","type","column", 
        "innerClassName"
    ],
    data() {
        return {
            outerClass: 'form-group',
            innerClass: this.innerClassName || 'form-control el-scrollbar__view el-select-dropdown__list'
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
