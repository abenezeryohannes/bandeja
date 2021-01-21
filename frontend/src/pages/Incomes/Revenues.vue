<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <buttons-panel>
            <div class="text-right">
                <span><router-link  :to="{ name : 'RevenuesCreate' }"  class="btn btn-success btn-sm header-button-top" style="color: white;"><span class="fa fa-plus"></span> &nbsp;Add New Revenue</router-link></span>
            </div>
          </buttons-panel>

        <ak-table
            :columns="table.columns"
            boot_api="/api/v1/revenues/"
            :actions="{
                show: 'RevenuesShow',
                edit: 'RevenuesUpdate',
                destroy: 'RevenuesUpdate',
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
                title: 'Revenues',
                permission: 'plan',
                active_link: 'Revenues',
                parent: 'Incomes',
                breadcrumb: []
            },
            api: '/api/v1/revenues/create',
            isActive: [],

            table: {
                columns: [
                    { label: '', name: '#', column: 2 },
                    { label: 'Date', name: 'date', column: 3 },
                    { label: 'Amount', name: 'amount', column: 2 },
                    { label: 'Customer / Tenant', name: 'tenant', column: 2 },
                    { label: 'Category', name: 'category' , column: 2},
                    { label: 'Actions', name: '##', column: 2 },
                ]
            }
        }
    },

    methods: {

    }
}

</script>
