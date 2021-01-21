<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <ak-form-a 
            :boot_data="page_info"
            :action_api="api"
            method="post"
            :return_url="{ name: 'InvoicesShow', params: { id: $route.id } }"
        />


        <!-- boot_api="/api/v1/user/profile/create" -->
    </layout-b>
</template>
<script>
import pageLoader from "../../mixins/PageLoader"

export default {

    props: [],

    mixins: [pageLoader],

    components: {
    },
    data() {
        return {
            page_meta: {
                title: 'Pay Invoice',
                permission: 'plan',
                active_link: 'Invoices',
                parent: 'Incomes',
                breadcrumb: []
            },
            api: '/api/v1/invoices/pay/' + this.$route.params.id,
            isActive: [],

        
        }
    },

    methods: {

        set_strings() {

            // this.page_meta.title = this.page_info.data.title
        },
    },

    mounted() {
        if (this.page_info.data) {

        }
        // var p = this.$route.params.id
        // if (p) {
        //     this.api = '/api/v1/propertycategories/edit/' + p
        // } else {
        //     // create
        // }
        // console.log(p)
    }
}

</script>
