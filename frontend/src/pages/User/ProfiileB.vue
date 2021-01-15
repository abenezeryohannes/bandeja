<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <div class="card">
            <div role="form" novalidate="novalidate" enctype="multipart/form-data" class="form-loading-button">
                <div class="card-body">
                    <div class="row">
                        <ak-input  label="Name" icon="fa fa-font" v-model="page_info.user.name" type="text" required="required" column="col-md-6"  :error_msg="[errors,'name']" />
                        <ak-input  label="Email" icon="fa fa-save" v-model="page_info.user.email" type="email" required="required" column="col-md-6" :error_msg="[errors,'email']"  />

                        <ak-input  label="Password" icon="fa fa-key" v-model="password1" type="password" required="required" column="col-md-6" :error_msg="[errors,'password1']" />
                        <ak-input  label="Password Confirmation" icon="fa fa-key" v-model="password2" type="password" required="required" column="col-md-6"  :error_msg="[errors,'password2']" />

                        <ak-select  label="Language" icon="fa fa-save" v-model="page_info.user.locale"  column="col-md-6"
                                :options="[ { label:'- Select Language -',value:'0' },{ label:'English',value:'en' },{ label:'Amharic',value:'am' }  ]"  :error_msg="[errors,'language']" />
                        <ak-file  label="File Uploader" icon="fa fa-save" v-model="picture"  column="col-md-6" :error_msg="[errors,'picture']"  />

                    </div>
                </div>
                <div class="card-footer">
                    <div class="row save-buttons">
                        <div class="col-md-12"><a v-on:click="cancel" class="btn btn-icon btn-outline-secondary header-button-top"><span class="btn-inner--icon"><i class="fas fa-times"></i></span> <span class="btn-inner--text">Cancel</span></a> <button v-on:click="save" type="submit" data-loading-text="Loading..." class="btn btn-icon btn-success button-submit header-button-top">
                                <span class="btn-inner--icon"><i class="fas fa-save"></i></span><span class="btn-inner--text">Save</span></button></div>
                    </div>
                </div>
            </div>
        </div>
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
