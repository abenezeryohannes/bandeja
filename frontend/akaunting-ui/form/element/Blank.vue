<template>
    <div :class="['form-group', column]">
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
