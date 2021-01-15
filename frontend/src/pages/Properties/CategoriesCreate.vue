<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">

        <ak-form-a 
            :boot_data="page_info"
            action_api="/api/v1/propertycategories/store"
            method="patch"
            :return_url="{ name: 'Categories' }"
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
                title: 'Categories',
                permission: 'plan',
                active_link: 'Categories',
                parent: 'PropertiesM',
                breadcrumb: []
            },
            api: '/api/v1/propertycategories/create',
            isActive: [],

            table: {
                columns: [
                    { label: '', name: '#', column: 1 },
                    { label: 'Name', name: 'name', column: 2 },
                    { label: 'Description', name: 'description', column: 3 },
                    { label: 'Price', name: 'rent_price', column: 2 },
                    { label: 'No of Properties', name: 'no_of_properties' },
                    { label: 'Status', name: 'enabled' },
                    { label: 'Actions', name: '##' },
                ]
            }
        }
    },

    methods: {

    }
}

</script>
