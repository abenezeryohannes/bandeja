<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">

        <div class="card" >
            <form method="POST" accept-charset="UTF-8" id="user" role="form" novalidate="novalidate" enctype="multipart/form-data" class="form-loading-button"><input name="_method" type="hidden" value="PATCH">
                <div class="card-body">
                    <div class="row">
                        <div class="form-group col-md-6 required"><label for="name" class="form-control-label">Name</label>
                            <div class="input-group input-group-merge ">
                                <div class="input-group-prepend"><span class="input-group-text"><i class="fa fa-font"></i></span></div> <input data-name="name" placeholder="Enter Name" v-model="page_info.user.name" required="required" name="name" type="text" id="name" class="form-control">
                            </div>
                            <!---->
                        </div>
                        <div class="form-group col-md-6 required"><label for="email" class="form-control-label">Email</label>
                            <div class="input-group input-group-merge ">
                                <div class="input-group-prepend"><span class="input-group-text"><i class="fa fa-envelope"></i></span></div> <input data-name="email" placeholder="Enter Email" required="required" name="email" type="email" v-model="page_info.user.email" id="email" class="form-control">
                            </div>
                            <!---->
                        </div>
                        <div class="form-group col-md-6"><label for="password" class="form-control-label">Password</label>
                            <div class="input-group input-group-merge ">
                                <div class="input-group-prepend"><span class="input-group-text"><i class="fa fa-key"></i></span></div> <input data-name="password" placeholder="Enter Password" name="password" type="password" value="" id="password" class="form-control">
                            </div>
                            <!---->
                        </div>
                        <div class="form-group col-md-6"><label for="password_confirmation" class="form-control-label">Password Confirmation</label>
                            <div class="input-group input-group-merge ">
                                <div class="input-group-prepend"><span class="input-group-text"><i class="fa fa-key"></i></span></div> <input data-name="password_confirmation" placeholder="Enter Password Confirmation" name="password_confirmation" type="password" value="" id="password_confirmation" class="form-control">
                            </div>
                        </div>
                        <div  class="form-group col-md-6 required">
                            <label class="form-control-label">
                                Language
                            </label>

                            <div class="input-group input-group-merge ">
                                <div class="input-group-prepend"><span class="input-group-text"><i class="fa fa-key"></i></span></div>
                                <select name="locale" v-model="page_info.user.locale" id="locale" class="form-control el-scrollbar__view el-select-dropdown__list">
                                    <option value="0">- Select Language -</option>
                                    <option value="en" class="el-select-dropdown__item">English</option>
                                    <option value="am">Amharic</option>
                                </select>
                            </div>

                        </div>
                        <div class="form-group col-md-6"><label for="picture" class="form-control-label">Picture</label>
                            <div class="custom-file"><input name="picture" type="file" id="picture" class="custom-file-input cursor-pointer"> <label for="picture" class="custom-file-label">Picture</label></div>
                        </div>

                        <div class="form-group col-md-12 required"><label for="roles" class="form-control-label">Roles</label>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="custom-control custom-checkbox"><input id="checkbox-roles-1" checked="checked" name="roles" type="checkbox" :value="page_info.user.role == 'admin'" class="custom-control-input"> <label for="checkbox-roles-1" class="custom-control-label">
                                            Admin
                                        </label></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-6"><label for="enabled" class="form-control-label">Enabled</label>
                            <div role="tabpanel" aria-labelledby="-component-tab" class="tab-pane tab-example-result fade show active">
                                <div data-toggle="buttons" class="btn-group btn-group-toggle radio-yes-no"><label class="btn btn-success active">
                                        Yes
                                        <input type="radio" name="enabled" id="enabled-1"></label> <label class="btn btn-danger">
                                        No
                                        <input type="radio" name="enabled" id="enabled-0"></label></div> <input type="hidden" name="enabled" value="1">
                            </div>
                            <!---->
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row save-buttons">
                        <div class="col-md-12"><a v-on:click="cancel"  class="btn btn-icon btn-outline-secondary header-button-top"><span class="btn-inner--icon"><i class="fas fa-times"></i></span> <span class="btn-inner--text">Cancel</span></a> <button  v-on:click="save" type="submit" data-loading-text="Loading..." class="btn btn-icon btn-success button-submit header-button-top">
                            <span class="btn-inner--icon"><i class="fas fa-save"></i></span><span class="btn-inner--text">Save</span></button></div>
                    </div>
                </div>
            </form>
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
        }
    },

    methods: {
        save(){

        },
        cancel() {
            
        }
    }
}

</script>
