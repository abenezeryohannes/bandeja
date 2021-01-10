<template>
    <layout-b  :page="page_meta" >
        Sales
    </layout-b>
</template>
<script>
import pageLoader from "../../mixins/PageLoader"
export default {

    props: [],

    mixins: [],

    components: {},
    data() {
        return {
            departments: [],
            loaded: false,
            page_meta: {
                title: 'Plan',
                permission: 'plan',
                active_link: 'Sales',
                parent: 'Properties',
                breadcrumb: [
                    { label: 'Home', icon: 'dashboard' },
                    { label: 'Plan', icon: '' },
                ]
            },
        }
    },
}
</script>
