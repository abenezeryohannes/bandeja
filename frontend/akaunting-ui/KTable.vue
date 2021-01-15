<template>
    <div class="box">
        <div class="box-header">
            <slot name="header">
                <h3 class="box-title">{{ktable_title}}</h3>
            </slot>
            <div class="box-tools">
                <div class="input-group input-group-sm hidden-xs" style="width: 150px;">
                    <input v-on:keyup.enter="search_table" type="text" name="table_search" class="form-control pull-right" placeholder="Search" v-model="search_text">
                    <div class="input-group-btn">
                        <button v-on:click="search_table" type="submit" class="btn btn-default"><i class="fa fa-search"></i></button>
                    </div>
                </div>
            </div>
            <div class="visible-xs">
                <!-- <div class="input-group input-group-sm"> -->
                <div class="row">
                    <div class="col-xs-8">
                        <input v-on:keyup.enter="search_table" type="text" name="table_search" class="form-control" placeholder="Search ..." v-model="search_text">
                    </div>
                    <div class="col-xs-4">
                        <div class="input-group-btn">
                            <button v-on:click="search_table" type="submit" class="btn btn-default btn-block"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </div>
                <!-- </div> -->
            </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
            <div class="dataTables_wrapper form-inline dt-bootstrap">
                <div class="row">
                    <div class="col-sm-12 no-padding">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover dataTable">
                                <thead>
                                    <tr role="row">
                                        <th v-for="header in ktable_headers" style="text-align: left" rowspan="1" colspan="1">{{header.name}}</th>
                                    </tr>
                                </thead>
                                <tbody v-if="table_is_loading" style="text-align: center;">
                                    <tr>
                                        <td class="hidden-xs" :colspan="ktable_headers.length"><i class="fa fa-refresh fa-spin"></i></td>
                                        <td class="visible-xs"><i class="fa fa-refresh fa-spin"></i></td>
                                    </tr>
                                </tbody>
                                <tbody v-else-if="errorStatus">
                                    <tr>
                                        <td v-if="errorStatus == 404" :colspan="ktable_headers.length" style="color: red">Table Info Not Found</td>
                                        <td v-else-if="errorStatus == 401" :colspan="ktable_headers.length" style="color: red">Unauthorized To View</td>
                                        <td v-else :colspan="ktable_headers.length" style="color: red">Error</td>
                                    </tr>
                                </tbody>
                                <tbody v-else>
                                    <tr role="row" v-for="post, x in table.data" :class="evenodd(x)">
                                        <td v-for="r in ktable_row">
                                            <template v-if="r.type =='string'">
                                                {{ post[r.key] }}
                                            </template>
                                            <template v-if="r.type =='#'">
                                                {{ x+1 }}
                                            </template>
                                            <template v-else-if="r.type =='image'">
                                                <img v-if="post[r.key]" :src="post[r.key]" height="100">
                                            </template>
                                            <template v-else-if="r.type =='list'">
                                                <small v-for="r in post[r.key]" class="label bg-blue"> {{r}} </small>
                                            </template>
                                            <template v-else-if="r.type =='list2'">
                                                <ul>
                                                    <li v-for="r in post[r.key]">{{r}}</li>
                                                </ul>
                                            </template>
                                            <template v-else-if="r.type =='actions'">
                                                <template v-for="a, ak in r.actions">
                                                    <button v-if="a.type=='delete'" class="btn btn-sm btn-danger" v-on:click="delete_item(post.id)"> Delete </button>
                                                    <router-link v-else :class="a.class" :to="{ name: a.link, params: {  id: post.id } }">{{a.name}}</router-link>
                                                </template>
                                            </template>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="row" v-if="!table_is_loading">
                    <div class="col-sm-5">
                        <div class="dataTables_info" id="example2_info" role="status" aria-live="polite">Showing {{table.from}} to {{table.to}} of {{table.total}} entries</div>
                    </div>
                    <div class="col-sm-7">
                        <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
                            <ul class="pagination">
                                <li v-if="table.current_page -1" class="paginate_button previous"><a v-on:click="load_this_page(table.current_page -1)" aria-controls="example2" data-dt-idx="0" tabindex="0">Previous</a></li>
                                <li v-else class="paginate_button previous disabled"><a aria-controls="example2" data-dt-idx="0" tabindex="0">Previous</a></li>
                                <li v-for="k in table.page_links" :class="get_class_link(k)"><a v-on:click="load_this_page(k)" aria-controls="example2" data-dt-idx="1" tabindex="0">{{k}}</a></li>
                                <li v-if="table.current_page == table.last_page" class="paginate_button next disabled" id="example2_next"><a href="#" aria-controls="example2" data-dt-idx="7" tabindex="0">Next</a></li>
                                <li v-else class="paginate_button next" id="example2_next"><a v-on:click="load_this_page(table.current_page + 1)" aria-controls="example2" data-dt-idx="7" tabindex="0">Next</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: [
        'ktable_title', 'ktable_api', 'ktable_headers', 'ktable_row', 'kevent_refresh'
    ],
    watch: {
        ktable_api: 'load_table_data',
        kevent_refresh: 'load_table_data'
    },
    data() {
        return {
            searched: false,
            k_show: false,
            table_api: '/api/personnel/employee/table',
            table_is_loading: true,
            table: {},

            search_text: null,
            items: [],
            categories: [],
            fields: {
                name: null,
                serial: null,
                picture: null,
                quantity: null,
                unit: null,
                unit_price: null,
                total_price: null,
                status: null,
                remark: null,
                categories: null,
            },
            load_page: true,
            myValue: '',
            myOptions: ['op1', 'op2', 'op3'], // or [{id: key, text: value}, {id: key, text: value}]

            response_alert: false,
            created_user: null,
            api: '/api/personnel/employee/',
            permission: 'hrms.employee.create',
            data_loaded: false,
            form_data: {
                position: [],
                bank_account_name: [],
                branch: [],
                regions: []
            },
            errors: {},
            errorStatus: false
        }
    },

    mounted() {
        this.load_table_data()
    },

    methods: {
        get_class_link(l) {
            if (l == this.table.current_page) {
                return 'paginate_button active'
            }
            return 'paginate_button'
        },
        load_this_page(page) {
            this.table_is_loading = true
            var api = this.ktable_api + 'table?page=' + page
            if (this.searched) {
                api = api + '&search=' + this.search_text
            }
            this.$axios
                .get(api)
                .then(response => {
                    this.table = response.data
                    this.table_is_loading = false
                })
                .catch(error => {
                    this.errored = true
                })
        },
        load_table_data() {
            this.table_is_loading = true
            this.$axios
                .get(this.ktable_api)
                // .get(this.ktable_api+'table')
                .then(response => {
                    this.errorStatus = false
                    this.searched = false
                    this.table = response.data
                })
                .catch(error => {
                    this.errorStatus = error.response.status
                }).finally(() => this.table_is_loading = false)
        },
        evenodd(c) {
            if (c % 2 == 0) {
                return "odd"
            }
            return "even"
        },
        search_table() {
            this.table_is_loading = true
            this.$axios
                .get(this.ktable_api + 'table?search=' + this.search_text)
                .then(response => {
                    this.searched = true
                    this.table = response.data
                    this.table_is_loading = false
                })
                .catch(error => {
                    this.errored = true
                })
        },
        delete_item(id) {
            this.$swal({
                title: 'Are you sure?',
                text: 'You will not be able to recover this record!',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'No, keep it'
            }).then((result) => {
                if (result.value) {
                    // Delete
                    let formData = new FormData();
                    const config = {
                        headers: {
                            'content-type': 'multipart/form-data',
                            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                        }
                    }
                    formData.append('id', id)
                    this.$axios.delete(this.ktable_api + id, formData, config)
                        // this.$axios.post(this.ktable_api+'destroy', formData, config)
                        .then(response => {
                            var message = 'Your record has been deleted.';
                            if (response.data.status_message) {
                                message = response.data.status_message
                            }
                            this.load_table_data()
                            this.$swal(
                                'Deleted!',
                                message,
                                'success'
                            ).then((result) => {
                                // return to all.vue
                                // console.log(result)
                            })
                        }).catch(error => {
                            console.log(error)
                            if (error.response.status == 401) {
                                this.$swal(
                                    'Unauthorized!',
                                    "You can't delete this record",
                                    'error'
                                )
                            } else {
                                this.$swal(
                                    'Something went wrong!',
                                    'Please try again',
                                    'error'
                                )
                            }
                        });
                } else if (result.dismiss === "cancel") {
                    this.$swal(
                        'Cancelled',
                        'Your record is safe',
                        'error'
                    )
                }
            })
        },

    }


}

</script>
