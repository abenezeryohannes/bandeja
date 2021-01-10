<template>
    <layout-b  :page="page_meta" >
        <k-table2 />
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
                title: 'Dashboard',
                permission: 'plan',
                active_link: 'Home',
                breadcrumb: [
                    { label: 'Home', icon: 'dashboard' },
                    { label: 'Plan', icon: '' },
                ]
            },
        }
    },
}
</script>
