<template>
    <div :class="['form-group', column, required]">
        <label for="enabled" class="form-control-label">{{label}}</label>
        <div class="input-group input-group-merge ">
            <div class="input-group-prepend"><span class="input-group-text"><i :class="icon"></i></span></div> 
            <input  :placeholder="placeholder" :type="type" v-bind:value="value" v-on:input="$emit('input', $event.target.value)" class="form-control">
        </div>
    </div>
    <div class="form-group col-md-12 required"><label for="roles" class="form-control-label">Roles</label>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="custom-control custom-checkbox"><input id="checkbox-roles-1" checked="checked" name="roles" type="checkbox" :value="page_info.user.role == 'admin'" class="custom-control-input"> <label for="checkbox-roles-1" class="custom-control-label">
                                            Admin
                                        </label></div>
                                </div>
                            </div>
                        </div>


                                                <ak-switcher column="col-md-6" v-model="isActive" multiple="true" label="Active" :source="{ options: [ 'Yes', 'No', 'Maybe' ], default: 'No' }" />
</template>
<script>
export default {
    props: [ "label", "value","icon","placeholder","required","type","column"],
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
