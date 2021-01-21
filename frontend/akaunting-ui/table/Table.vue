<template>
    <div class="card">
        <div class="card-header border-bottom-0">
            <div method="GET" accept-charset="UTF-8" role="form" class="mb-0">
                <div class="align-items-center">
                    <div class="el-select pl-20 mr-40">
                        <div class="el-input el-input--suffix">
                            <input type="text" autocomplete="off" placeholder="Type to search.." class="el-input__inner">
                            <span class="el-input__suffix">
                                <span class="el-input__suffix-inner">
                                    <i class="el-select__caret el-input__icon el-icon-"></i>
                                </span>
                            </span>
                        </div>
                        <div class="el-select-dropdown el-popper" style="display: none; min-width: 993px;">
                            <div class="el-scrollbar" style="display: none;">
                                <div class="el-select-dropdown__wrap el-scrollbar__wrap" style="margin-bottom: -15px; margin-right: -15px;">
                                    <ul class="el-scrollbar__view el-select-dropdown__list">
                                        <!---->
                                        <!---->
                                    </ul>
                                </div>
                                <div class="el-scrollbar__bar is-horizontal">
                                    <div class="el-scrollbar__thumb" style="transform: translateX(0%);"></div>
                                </div>
                                <div class="el-scrollbar__bar is-vertical">
                                    <div class="el-scrollbar__thumb" style="transform: translateY(0%);"></div>
                                </div>
                            </div>
                            <!---->
                        </div>
                    </div>
                </div>
                <!---->
                <!---->
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-flush table-hover">
                <thead class="thead-light">
                    <tr class="row table-head-line">
                        <template v-for="(c,k) in columns">
                            <template v-if="c.name == '#'">
                                <th class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                                    <div class="custom-control custom-checkbox">
                                        <input id="table-check-all" type="checkbox" class="custom-control-input"> 
                                        <label for="table-check-all" class="custom-control-label"></label>
                                    </div>
                                </th>
                            </template>
                            <template v-else-if="c.name == '##'">
                                <th class="col-sm-2 d-none text-center d-md-block"><a rel="nofollow" class="col-aka">{{c.label}}</a></th>
                            </template>
                            <template v-else>
                                <th :class="['col-sm-'+get_col_size(c,k,columns), 'text-center','d-none d-md-block']"><a>{{c.label}}</a>&nbsp; <i class="fas fa-sort-numeric-up"></i></th>
                            </template>
                        </template>
                    </tr>
                </thead>
                <tbody v-if="table_data">
                    <tr v-for="r in table_data.data" class="row align-items-center border-top-1">
                        <template v-for="(c,k) in columns">
                            <template v-if="c.name == '#'">
                                <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                                    <div class="custom-control custom-checkbox">
                                        <input :id="'check-'+r.id" type="checkbox" class="custom-control-input"> 
                                        <label :for="'check-'+r.id" class="custom-control-label"></label>
                                    </div>
                                </td>
                            </template>
                            <template v-else-if="c.name == '##'">
                                <td class="col-sm-2 d-none d-md-block">
                                    <ak-actions :id="r.id" :actions="actions" ></ak-actions>
                                </td>
                            </template>
                            <template v-else>
                                <td :class="['col-sm-'+get_col_size(c,k,columns), 'text-center','d-none d-md-block']">
                                    <span v-if="c.type == 'status'" class="badge badge-lg badge-pill " :class="{'badge-success': r[c.name],'badge-danger': !r[c.name] }">
                                        {{get_status(r,c)}}
                                    </span>
                                    <a v-else>{{get_label(r,c)}} </a>
                                </td>
                            </template>
                        </template>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="card-footer table-action">
            <div class="row">
                <div class="col-xs-12 col-sm-5 d-flex align-items-center">
                    <!-- <select name="limit" class="form-control form-control-sm d-inline-block w-auto d-none d-md-block">
                        <option value="10">10</option>
                        <option value="25" selected="selected">25</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select> 
                    <span class="table-text d-none d-lg-block ml-2">
                        per page.
                        1-25 of 100 records.
                    </span> -->
                </div>
                <div class="col-xs-12 col-sm-7 pagination-xs">
                    <nav class="float-right">
                        <ul class="pagination mb-0">
                            <li class="page-item disabled"><span class="page-link">«</span></li>
                            <li class="page-item active"><span class="page-link">1</span></li>
                            <li class="page-item"><a href="http://localhost:8000/sales/invoices?sort=invoice_number&amp;direction=desc&amp;page=2" class="page-link">2</a></li>
                            <li class="page-item"><a href="http://localhost:8000/sales/invoices?sort=invoice_number&amp;direction=desc&amp;page=3" class="page-link">3</a></li>
                            <li class="page-item d-none d-sm-block"><a href="http://localhost:8000/sales/invoices?sort=invoice_number&amp;direction=desc&amp;page=4" class="page-link">4</a></li>
                            <li class="page-item"><a href="http://localhost:8000/sales/invoices?sort=invoice_number&amp;direction=desc&amp;page=2" rel="next" class="page-link">»</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: ["boot_api", "columns","actions"],
    data() {
        return {
            file_name: 'select file',
            img_preview: null,
            errors: null,
            name: null,

            strings: {},
            fields: [],

            table_data: null,

            models: {

            }
        }
    },
    watch: {
        // active: 'mount_active',
        // active_tab : 'notify_up'
    },
    methods: {
        get_status(r,c){
            if (r[c.name]) {
                return "Enabled"
            }
            return "Disabled"
        },
        get_label(r,c){
            const rr = c.name.split('.');
            if (rr.length == 1) {
                return r[c.name]
            }
            var ans = r
            for (var i = 0 ; i < rr.length; i++) {
                if (ans[rr[i]] !== undefined) {
                    ans = ans[rr[i]]
                }else{
                    return null
                }
            }
            return ans
        },
        get_col_size(c, k, columns) {
            if (c.column) {
                return c.column
            }
            var t = Math.floor(8 / (columns.length-2))
            var t2 = Math.floor(8 % (columns.length-2))
            if (k == 1) {
                return t+t2
            }
            return t
        },
        save() {
            this.errors = null
            let formData = new FormData();
            formData.append('_method', this.method)
            for (var i = this.fields.length - 1; i >= 0; i--) {
                var field = this.fields[i]
                var v = this.models[field.name]
                if (v) {
                    formData.append(field.name, v)
                }
            }
            const config = {
                headers: {
                    'content-type': 'multipart/form-data',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                }
            }
            this.$axios.post(this.action_api, formData, config)
                .then(response => {

                }).catch(error => {
                    if (error.response.status == 422) {
                        this.errors = error.response.data.errors
                    }
                });
        },

        onUpload(event) {
            var file = event.target.files[0]
            this.file_name = file.name
            if (
                file.type == 'image/jpeg' &&
                file.type == 'image/png'
            ) {
                this.img_preview = URL.createObjectURL(file)
            }
            // console.log(file)
        },

        boot_from_source() {
            this.fields = this.boot_data.form.fields
            this.strings = this.boot_data.form.strings
            for (var i = this.fields.length - 1; i >= 0; i--) {
                var field = this.fields[i]
                this.models[field.name] = field.default
            }

        },

        boot_from_api() {
            this.$axios
                .get(this.boot_api)
                .then(response => {
                    this.table_data = response.data
                })
                .catch(error => {

                })
        },

        boot() {
            if (this.boot_data) {
                this.boot_from_source()
            } else {
                this.boot_from_api()
            }
        }
    },
    mounted() {
        this.boot()
    }
}

</script>
<style scoped>
</style>
