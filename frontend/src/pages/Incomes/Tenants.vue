<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <buttons-panel>
            <div class="text-right">
                <span><router-link  :to="{ name : 'TenantsCreate' }"  class="btn btn-success btn-sm header-button-top" style="color: white;"><span class="fa fa-plus"></span> &nbsp;Add New Tenant</router-link></span>
            </div>
          </buttons-panel>

        <ak-table
            :columns="table.columns"
            boot_api="/api/v1/tenants/"
             :actions="{
                show: 'TenantsShow',
                edit: 'TenantsUpdate',
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
                title: 'Tenants',
                permission: 'plan',
                active_link: 'Tenants',
                parent: 'Incomes',
                breadcrumb: []
            },
            api: '/api/v1/tenants/create',
            isActive: [],

            table: {
                columns: [
                    { label: '', name: '#', column: 1 },
                    { label: 'Name', name: 'name', column: 3 },
                    { label: 'Phone Number', name: 'phone_number', column: 2 },
                    { label: 'Open Invoices', name: 'no_of_open_invoices' },
                    { label: 'Defaulted', name: 'no_of_defaulted', column: 2 },
                    { label: 'Actions', name: '##' },
                ]
            }
        }
    },

    methods: {

    }
}

</script>
