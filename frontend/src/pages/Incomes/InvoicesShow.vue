<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
            <div class="card">
                <div class="card-body">
                    <div data-timeline-content="axis" data-timeline-axis-style="dashed" class="timeline timeline-one-side">
                        <div class="timeline-block"><span class="timeline-step badge-primary"><i class="fas fa-plus"></i></span>
                            <div class="timeline-content">
                                <h2 class="font-weight-500">Create Invoice</h2>
                                 <small>Status:</small> <small>Created on {{page_info.data.created_at}}</small>
                            </div>
                        </div>
                        <div class="timeline-block"><span class="timeline-step badge-success"><i class="far fa-money-bill-alt"></i></span>
                            <div class="timeline-content">
                                <h2 class="font-weight-500">Get Paid</h2> <small>Status:</small> <small>{{page_info.data.status}}</small>
                                <!-- <div class="mt-3"><a class="btn btn-white btn-sm header-button-top">Mark Paid</a> <button id="button-payment" class="btn btn-success btn-sm header-button-bottom">Add Payment</button></div> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                <invoice-card :the_data="page_info.data" />
        <div class="row">
            
                <!-- <invoice-card-table title="Histories" /> -->
                <invoice-card-table title="Transactions" />
        </div>


        <!-- boot_api="/api/v1/user/profile/create" -->
    </layout-b>
</template>
<script>
import pageLoader from "../../mixins/PageLoader"
import InvoiceCard from "./InvoiceCard"
import InvoiceCardTable from "./InvoiceCardTable"
export default {

    props: [],

    mixins: [pageLoader],

    components: {
        InvoiceCard,
        InvoiceCardTable
    },
    data() {
        return {
            page_meta: {
                title: 'Invoices',
                permission: 'plan',
                active_link: 'Invoices',
                parent: 'Incomes',
                breadcrumb: []
            },
            api: '/api/v1/invoices/show/' + this.$route.params.id,
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

            this.page_meta.title = this.page_info.data.title
        },
    },

    mounted() {
        if (this.page_info.data) {

        }
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
