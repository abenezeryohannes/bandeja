<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <ak-form-a :boot_data="page_info" :action_api="action_api" :extra_models="extra_models" method="post" :return_url="{ name: 'Invoices' }">
            <template v-slot:properties>
                <div class="col-sm-12 mb-4"><label for="items" class="form-control-label">Properties</label>
                    <div class="table-responsive overflow-x-scroll overflow-y-hidden">
                        <table id="items" class="table table-bordered">
                            <thead class="thead-light">
                                <tr>
                                    <th class="text-center border-right-0 border-bottom-0">Property</th>
                                    <!-- <th class="text-left border-right-0 border-bottom-0">FROM</th> -->
                                    <th class="text-center border-right-0 border-bottom-0 w-12">Period</th>
                                    <th class="text-right border-right-0 border-bottom-0">Price</th>
                                    <th class="text-right border-right-0 border-bottom-0">Tax</th>
                                    <th class="text-right border-bottom-0 item-total">Total</th>
                                </tr>
                            </thead>
                            <tbody id="invoice-item-rows">
                                <tr index="0">
                                    <td class="text-center border-right-0 border-bottom-0">
                                        <ak-select  innerClassName="el-input__inner" v-model="extra_models.property_id" :options="page_info.form.extra_fields.data.properties"  />
                                    </td>
                                    <td class="border-right-0 border-bottom-0 w-12">
                                        <ak-input  input_type="el-input__inner" v-model="extra_models.period" :options="page_info.form.extra_fields.data.periods"  />
                                    </td>
                                    <td class="text-right total-column border-bottom-0 long-texts">

                                         <span id="item-total">ETB {{extra_models.price}}</span>
                                        
                                    </td>
                                    <td class="border-right-0 border-bottom-0">
                                        <ak-select  innerClassName2="el-input__inner" v-model="extra_models.tax" :options="page_info.form.extra_fields.data.taxes"  />
                                    </td>
                                    <td class="text-right total-column border-bottom-0 long-texts">
                                        <div data-v-27d909ce="" class="form-group d-none">
                                            <div data-v-27d909ce="" class="input-group input-group-merge">
                                                <input data-v-27d909ce="" type="tel" class="v-money form-control" name="total" placeholder=""></div>
                                        </div> <span id="item-total">ETB {{extra_models.price}}</span>
                                    </td>
                                </tr>
<!--                                 <tr id="addItem">
                                    <td class="text-center border-right-0 border-bottom-0"><button type="button" id="button-add-item" data-toggle="tooltip" title="Add" data-original-title="Add" class="btn btn-icon btn-outline-success btn-lg"><i class="fa fa-plus"></i></button></td>
                                    <td colspan="4" class="text-right border-bottom-0"></td>
                                </tr> -->
                                <tr id="tr-subtotal">
                                    <td colspan="4" class="text-right border-right-0 border-bottom-0"><strong>Subtotal</strong></td>
                                    <td class="text-right border-bottom-0 long-texts">
                                        <div data-v-27d909ce="" class="form-group required disabled text-right d-none" form-classes="[object Object]">
                                            <div data-v-27d909ce="" class="input-group input-group-merge">
                                                <input data-v-27d909ce="" type="tel" class="v-money form-control" name="sub_total" placeholder="" disabled="disabled"></div>
                                        </div> <span>ETB {{extra_models.subtotal}}</span>
                                    </td>
                                </tr>
                                <tr id="tr-tax">
                                    <td colspan="4" class="text-right border-right-0 border-bottom-0"><strong>Tax</strong></td>
                                    <td class="text-right border-bottom-0 long-texts">
                                        <div data-v-27d909ce="" class="form-group required disabled text-right d-none" form-classes="[object Object]">
                                            <div data-v-27d909ce="" class="input-group input-group-merge">
                                                <input data-v-27d909ce="" type="tel" class="v-money form-control" name="tax_total" placeholder="" disabled="disabled"></div>
                                        </div> <span>ETB {{extra_models.total_tax}}</span>
                                    </td>
                                </tr>
                                <tr id="tr-total">
                                    <td colspan="4" class="text-right border-right-0"><strong>Total</strong></td>
                                    <td class="text-right long-texts">
                                        <div data-v-27d909ce="" class="form-group required disabled text-right d-none" form-classes="[object Object]">
                                            <div data-v-27d909ce="" class="input-group input-group-merge">
                                                <input data-v-27d909ce="" type="tel" class="v-money form-control" name="grand_total" placeholder="" disabled="disabled"></div>
                                        </div> <span>ETB {{extra_models.price}}</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </template>

            <template v-slot:rental_contract>
                <div class="col-sm-6">
                    <button v-on:click="generate_prty_rental_contract" class="btn btn-primary btn-block" style="color: white;" >Generate Property Rental Contract</button>
                </div>
                
            </template>
        </ak-form-a>
        <!-- boot_api="/api/v1/user/profile/create" -->
    </layout-b>
</template>
<script>
import pageLoader from "../../mixins/PageLoader"
export default {

    props: [],

    mixins: [pageLoader],

    components: {},
    watch: {
        property_id: 'calculate_price',
        tax: 'calculate_price',
        period: 'calculate_price',
    },
    data() {
        return {
            extra_models: {
                property_id: null,
                from_date: null,
                tax: null,
                period: null,

                price: null,
                subtotal: null,
                total_tax: null,
            },


            page_meta: {
                title: 'Invoices',
                permission: 'plan',
                active_link: 'Invoices',
                parent: 'Incomes',
                breadcrumb: []
            },
            api: null,
            action_api: null,
            method: null,
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

    computed: {
        property_id(){
            return this.extra_models.property_id
        },
        tax(){
            return this.extra_models.tax
        },
        period(){
            return this.extra_models.period
        },
    },

    methods: {
        generate_prty_rental_contract(){
            open('/print/invoice/1')
        },
        calculate_price(){
            var ps = this.page_info.form.extra_fields.data.properties
            var p = null
            for (var i = ps.length - 1; i >= 0; i--) {
                if (ps[i].value == this.property_id) {
                    p = ps[i]
                    break;
                }
            }


            var ts = this.page_info.form.extra_fields.data.taxes
            var t = null
            for (var i = ts.length - 1; i >= 0; i--) {
                if (ts[i].value == this.tax) {
                    t = ts[i]
                    break;
                }
            }


            var total = (p.price || 0 ) * this.period
            // x+(rate/100)x = total
            // (100+rate)x = 100 * total
            // x = (100*total)/ (100+rate)
            var subtotal = (100*total)/(100+t.rate)
            var total_tax = total - subtotal

            this.extra_models.price = Math.round(total*100)/100
            this.extra_models.subtotal = Math.round(subtotal*100)/100
            this.extra_models.total_tax = Math.round(total_tax*100)/100

        }
    },

    mounted() {
        var p = this.$route.params.id
        if (p) {
            this.api = '/api/v1/invoices/edit/' + p
            this.action_api = '/api/v1/invoices/update/' + p
            this.method = 'put'
        } else {
            this.api = '/api/v1/invoices/create'
            this.action_api = '/api/v1/invoices/store'
            this.method = 'post'
        }
        console.log(p)
    }
}

</script>
