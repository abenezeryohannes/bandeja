<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <buttons-panel>
            <div class="text-right">
                <span><router-link  :to="{ name : 'PropertiesCreate' }"  class="btn btn-success btn-sm header-button-top" style="color: white;"><span class="fa fa-plus"></span> &nbsp;Add New Property</router-link></span>
            </div>
          </buttons-panel>

        <ak-table
            :columns="table.columns"
            boot_api="/api/v1/properties/"
             :actions="{
                show: 'PropertiesShow',
                edit: 'PropertiesUpdate',
                destroy: 'CategoriesUpdate',
            }"

        />
            <!-- boot_api="/api/v1/user/profile/create" -->
    </layout-b>
</template>
<script>
import pageLoader from "../../mixins/PageLoader"
export default {

    props: [],

    mixins: [pageLoader],

    components: {},
    data() {
        return {
            page_meta: {
                title: 'Properties',
                permission: 'plan',
                active_link: 'Properties',
                parent: 'PropertiesM',
                breadcrumb: []
            },
            api: '/api/v1/properties/create',
            isActive: [],

            table: {
                columns: [
                    { label: '', name: '#', column: 1 },
                    { label: 'Name', name: 'name', column: 3 },
                    { label: 'Category', name: 'property_category.name', column: 2 },
                    { label: 'Status', name: 'enabled', type: 'status' },
                    { label: 'Availability', name: 'available', column: 2 },
                    { label: 'Actions', name: '##' },
                ]
            }
        }
    },

    methods: {

    }
}

</script>
