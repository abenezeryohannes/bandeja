<template>
    <div :class="['form-group', column, required]">
        <label for="enabled" class="form-control-label">{{label}}</label>
        <div class="input-group input-group-merge ">
            <div class="input-group-prepend"><span class="input-group-text"><i :class="icon"></i></span></div> 
            <textarea  :placeholder="placeholder" v-bind:value="value" v-on:input="$emit('input', $event.target.value)" class="form-control"></textarea>
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
    props: [ "label", "value","icon","placeholder","required","type","column","error_msg"],
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
