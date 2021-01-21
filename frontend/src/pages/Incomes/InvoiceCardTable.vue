<template>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6">
        <div class="accordion">
            <div class="card">
                <div id="accordion-histories-header" data-toggle="collapse" data-target="#accordion-histories-body" aria-expanded="true" aria-controls="accordion-histories-body" class="card-header">
                    <h4 class="mb-0">{{title}}</h4>
                </div>
                <div id="accordion-histories-body" aria-labelledby="accordion-histories-header" class="hide collapse show" style="">
                    <div class="table-responsive">
                        <table class="table table-flush table-hover">
                            <thead class="thead-light">
                                <tr class="row table-head-line">
                                    <th class="col-xs-4 col-sm-1">Number</th>
                                    <th class="col-xs-4 col-sm-2 text-right">Amount</th>
                                    <th class="col-sm-3 d-none d-sm-block text-left">Invoice Date</th>
                                    <th class="col-sm-3 d-none d-sm-block text-left">Due Date</th>
                                    <th class="col-xs-4 col-sm-2">Status</th>
                                </tr>
                            </thead>
                            <tbody v-if="transactions.length">
                                <tr v-for="i in invoices" class="row align-items-center border-top-1 tr-py">

                                    <td class="col-xs-4 col-sm-1">{{i.invoice_number}}</td>
                                    <td class="col-xs-4 col-sm-2 text-right">{{i.price}}</td>
                                    <td class="col-sm-3 d-none d-sm-block text-left">{{i.invoice_date}}</td>
                                    <td class="col-sm-3 d-none d-sm-block text-left">{{i.due_date}}</td>
                                    <td class="col-xs-4 col-sm-2">{{i.status}}</td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer py-4 table-action" v-if="!transactions.length">
                        <div class="row">
                            <div id="datatable-basic_info" role="status" aria-live="polite" class="col-xs-12 col-sm-12"><small>No records.</small></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {

    props: ['the_data', 'title'],


    data() {
        return {
            transactions: []
        }
    },

    mounted(){
        this.get_tranactions()
    },

    methods: {
        get_tranactions(){
            this.$axios
                .get('/api/v1/invoices/transactions/'+this.$route.params.id)
                .then(response => {
                    this.transactions = response.data.data

                })
                .catch(error => {

                })
        },
    }
}

</script>
