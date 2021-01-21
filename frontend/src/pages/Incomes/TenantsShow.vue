<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <div class="row">
            <div class="col-xl-3">
                <ul class="list-group mb-4">
                    <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                        Invoices
                        <span class="badge badge-primary badge-pill">{{page_info.data.total_invoices}}</span></li>
                    <li class="list-group-item d-flex justify-content-between align-items-center border-0 border-top-1">
                        Transactions
                        <span class="badge badge-primary badge-pill">{{page_info.data.total_transactions}}</span></li>
                </ul>
                <ul class="list-group mb-4">
                    <li class="list-group-item border-0">
                        <div class="font-weight-600">Email</div>
                        <div><small class="">{{page_info.data.email_address}}</small></div>
                    </li>
                    <li class="list-group-item border-0 border-top-1">
                        <div class="font-weight-600">Phone</div>
                        <div><small class="">{{page_info.data.phone_number}}</small></div>
                    </li>
                    <li class="list-group-item border-0 border-top-1">
                        <div class="font-weight-600">Physical Address</div>
                        <div><small class="">{{page_info.data.physical_address}}</small></div>
                    </li>
                    <li class="list-group-item border-0 border-top-1">
                        <div class="font-weight-600">Tin number</div>
                        <div><small class="">{{page_info.data.tin_number}}</small></div>
                    </li>
                </ul> 
                <!-- <a  class="btn btn-info btn-block edit-sv"><i class="fas fa-edit"></i><b>Edit</b></a> -->
            </div>
            <div class="col-xl-9">
                <div class="row mb--3">
                    <div class="col-md-4">
                        <div class="card bg-gradient-success border-0">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="text-uppercase text-muted mb-0 text-white">Paid</h5>
                                        <div class="dropdown-divider"></div> <span class="h2 font-weight-bold mb-0 text-white">{{page_info.data.total_paid}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-gradient-warning border-0">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="text-uppercase text-muted mb-0 text-white">Total Transactions</h5>
                                        <div class="dropdown-divider"></div> <span class="h2 font-weight-bold mb-0 text-white">{{page_info.data.total_transactions}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-gradient-danger border-0">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="text-uppercase text-muted mb-0 text-white">Total waiting</h5>
                                        <div class="dropdown-divider"></div> <span class="h2 font-weight-bold mb-0 text-white">{{page_info.data.total_waiting}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="nav-wrapper">
                            <ul id="tabs-icons-text" role="tablist" class="nav nav-pills nav-fill flex-column flex-md-row">
                                <li class="nav-item"><a v-on:click="table_show='transactions'" aria-controls="transactions-content" aria-selected="true" class="nav-link mb-sm-3 mb-md-0 " :class="{ active: table_show=='transactions' }" > Transactions</a></li>
                                <li class="nav-item"><a v-on:click="table_show='invoices'" aria-controls="invoices-content" aria-selected="false" class="nav-link mb-sm-3 mb-md-0"  :class="{ active: table_show=='invoices' }">Invoices</a></li>
                            </ul>
                        </div>
                        <div class="card">
                            <div id="myTabContent" class="tab-content">
                                <div v-if="table_show=='transactions'" id="transactions-content" class="tab-pane fade show active">
                                    <div class="table-responsive">
                                        <table id="tbl-transactions" class="table table-flush table-hover">
                                            <thead class="thead-light">
                                                <tr class="row table-head-line">
                                                    <th class="col-xs-6 col-sm-2">Date</th>
                                                    <th class="col-xs-6 col-sm-2 text-right">Amount</th>
                                                    <th class="col-sm-4 d-none d-sm-block">Category</th>
                                                    <th class="col-sm-4 d-none d-sm-block">Account</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                    <div class="card-footer py-4 table-action"  v-if="!transactions.length">
                                        <div class="row">
                                            <div id="datatable-basic_info" role="status" aria-live="polite" class="col-xs-12 col-sm-12"><small>No records.</small></div>
                                        </div>
                                    </div>
                                </div>
                                <div v-if="table_show=='invoices'" id="invoices-content" role="tabpanel" aria-labelledby="invoices-tab" class="tab-pane fade show active">
                                    <div class="table-responsive">
                                        <table id="tbl-invoices" class="table table-flush table-hover">
                                            <thead class="thead-light">
                                                <tr class="row table-head-line">
                                                    <th class="col-xs-4 col-sm-1">Number</th>
                                                    <th class="col-xs-4 col-sm-3 text-right">Amount</th>
                                                    <th class="col-sm-3 d-none d-sm-block text-left">Invoice Date</th>
                                                    <th class="col-sm-3 d-none d-sm-block text-left">Due Date</th>
                                                    <th class="col-xs-4 col-sm-2">Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr v-for="i in invoices" class="row table-head-line">
                                                    <td class="col-xs-4 col-sm-1">{{i.invoice_number}}</td>
                                                    <td class="col-xs-4 col-sm-3 text-right">{{i.price}}</td>
                                                    <td class="col-sm-3 d-none d-sm-block text-left">{{i.invoice_date}}</td>
                                                    <td class="col-sm-3 d-none d-sm-block text-left">{{i.due_date}}</td>
                                                    <td class="col-xs-4 col-sm-2">{{i.status}}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="card-footer py-4 table-action" v-if="!invoices.length">
                                        <div class="row">
                                            <div id="datatable-basic_info" role="status" aria-live="polite" class="col-xs-12 col-sm-12"><small>No records.</small></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
            table_show: 'transactions',
            invoices: [],
            transactions: [],
            page_meta: {
                title: 'Tenants',
                permission: 'plan',
                active_link: 'Tenants',
                parent: 'Incomes',
                breadcrumb: []
            },
            api: '/api/v1/tenants/show/' + this.$route.params.id,
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

        set_strings() {

            this.page_meta.title = this.page_info.data.name
        },
        get_tranactions(){
            this.$axios
                .get('/api/v1/tenants/transactions/'+this.$route.params.id)
                .then(response => {
                    this.transactions = response.data.data

                })
                .catch(error => {

                })
        },
        get_invoices(){
            this.$axios
                .get('/api/v1/tenants/invoices/'+this.$route.params.id)
                .then(response => {
                    this.invoices = response.data.data
                })
                .catch(error => {

                })
        }
    },

    mounted() {
        if (this.page_info.data) {

        }
        this.get_tranactions()
        this.get_invoices()
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
