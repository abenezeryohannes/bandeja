<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <ak-form-a 
            :boot_data="page_info"
            action_api="/api/v1/user/profile/me"
            method="put"
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
            errors: null,
            password1: null,
            password2: null,
            picture: null,
            departments: [],
            loaded: false,
            page_meta: {
                title: 'My Profile',
                permission: 'plan',
                active_link: 'Profile',
                breadcrumb: [
                    { label: 'Home', icon: 'dashboard' },
                    { label: 'Plan', icon: '' },
                ]
            },
            api: '/api/v1/user/profile/create',
            isActive: [],
        }
    },

    methods: {
        save() {
            this.errors = null
            let formData = new FormData();
            formData.append('_method', "put")
            formData.append('password1', this.password1)
            formData.append('password2', this.password2)
            formData.append('name', this.page_info.user.name)
            formData.append('email', this.page_info.user.email)
            formData.append('locale', this.page_info.user.locale)
            if (this.picture) {
                formData.append('picture', this.picture)
            }
            const config = {
                headers: {
                    'content-type': 'multipart/form-data',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                }
            }
            this.$axios.post('/api/v1/user/profile/me', formData, config)
                .then(response => {

                }).catch(error => {
                    if (error.response.status == 422) {
                        this.errors = error.response.data.errors
                    }
                });
        },
        cancel() {

        }
    }
}

</script>
