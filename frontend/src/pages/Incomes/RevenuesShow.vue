<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <div class="card">
            <div class="row">
                <div class="col-md-6 ">
                        <div class="table-responsive">
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th>Date</th>
                                        <td class="text-left">{{page_info.data.date}}</td>
                                    </tr>
                                    <tr>
                                        <th>Tenant</th>
                                        <td class="text-left">{{page_info.data.tenant.name}}</td>
                                    </tr>
                                    <tr>
                                        <th>Category</th>
                                        <td class="text-left">{{page_info.data.category}}</td>
                                    </tr>
                                    <tr>
                                        <th>Tax</th>
                                        <td class="text-left">{{page_info.data.tax}}</td>
                                    </tr>
                                    <tr>
                                        <th>Amount</th>
                                        <td class="text-left">{{page_info.data.tax_price}}</td>
                                    </tr>
                                    <tr>
                                        <th>Total</th>
                                        <td class="text-left">{{page_info.data.total}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                <div class="col-md-6 ">
                        <div class="table-responsive">
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th>Payment Method</th>
                                        <td class="text-left"></td>
                                    </tr>
                                    <tr>
                                        <th>To Account</th>
                                        <td class="text-left"></td>
                                    </tr>
                                    <tr>
                                        <th>Attachment</th>
                                        <td class="text-left"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th>Description</th>
                                        <td class="text-left"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                </div>
        </div>



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
            page_meta: {
                title: 'Revenues',
                permission: 'plan',
                active_link: 'Revenues',
                parent: 'Incomes',
                breadcrumb: []
            },
            api: '/api/v1/revenues/show/'+this.$route.params.id,
            isActive: [],

            table: {
                columns: [
                    { label: '', name: '#', column: 1 },
                    { label: 'Date', name: 'name', column: 2 },
                    { label: 'Amount', name: 'description', column: 3 },
                    { label: 'Customer / Tenant', name: 'rent_price', column: 2 },
                    { label: 'No of Properties', name: 'no_of_properties' },
                    { label: 'Category', name: 'enabled' },
                    { label: 'Actions', name: '##' },
                ]
            }
        }
    },

    methods: {

        set_strings(){

            // this.page_meta.title = this.page_info.data.name
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
