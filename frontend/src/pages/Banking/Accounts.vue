<template>
    <layout-b  :page="page_meta" >

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
                title: 'Accounts',
                permission: 'plan',
                active_link: 'Accounts',
                parent: 'Banking',
                breadcrumb: [
                    { label: 'Home', icon: 'dashboard' },
                    { label: 'Plan', icon: '' },
                ]
            },
        }
    },
}
</script>
