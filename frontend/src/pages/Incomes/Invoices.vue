<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <buttons-panel>
            <div class="text-right">
                <span><router-link  :to="{ name : 'InvoicesCreate' }"  class="btn btn-success btn-sm header-button-top" style="color: white;"><span class="fa fa-plus"></span> &nbsp;Add New Invoice</router-link></span>
            </div>
          </buttons-panel>

        <ak-table
            :columns="table.columns"
            boot_api="/api/v1/invoices/"
            :actions="{
                show: 'InvoicesShow',
                edit: 'CategoriesUpdate',
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
                title: 'Invoices',
                permission: 'plan',
                active_link: 'Invoices',
                parent: 'Incomes',
                breadcrumb: []
            },
            api: '/api/v1/invoices/create',
            isActive: [],

            table: {
                columns: [
                    { label: '', name: '#', column: 1 },
                    { label: 'Number', name: 'invoice_number', column: 1 },
                    { label: 'Tenant Name', name: 'tenant_name', column: 2 },
                    { label: 'Price', name: 'price', column: 2 },
                    { label: 'Invoice Date', name: 'invoice_date', column: 2 },
                    { label: 'Due Date', name: 'due_date', column: 1 },
                    { label: 'Status', name: 'status' , column: 1},
                    { label: 'Actions', name: '##' , column: 2},
                ]
            }
        }
    },

    methods: {

    }
}

</script>
