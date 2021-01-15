<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <buttons-panel>
            <div class="text-right">
                <span><router-link  :to="{ name : 'SitesCreate' }"  class="btn btn-success btn-sm header-button-top" style="color: white;"><span class="fa fa-plus"></span> &nbsp;Add New Site</router-link></span>
            </div>
          </buttons-panel>

        <ak-table
            :columns="table.columns"
            boot_api="/api/v1/sites/"

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
                title: 'Sites',
                permission: 'plan',
                active_link: 'Sites',
                parent: 'PropertiesM',
                breadcrumb: []
            },
            api: '/api/v1/sites/create',
            isActive: [],

            table: {
                columns: [
                    { label: '', name: '#', column: 1 },
                    { label: 'Name', name: 'name', column: 3 },
                    { label: 'Address', name: 'address', column: 3 },
                    { label: 'No of Properties', name: 'no_of_properties', column: 2 },
                    { label: 'Status', name: 'enabled' , column: 1},
                    { label: 'Actions', name: '##' },
                ]
            }
        }
    },

    methods: {

    }
}

</script>
