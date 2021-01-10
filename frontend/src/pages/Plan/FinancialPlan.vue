<template>
    <div class="table-responsive">
        <table class="table table-bordered table-hover dataTable" role="grid">
            <thead>
                <tr role="row">
                    <th rowspan="2" colspan="1" style="width: 30px">ተ.ቁ</th>
                    <th rowspan="2" colspan="3">የወጪው ዓይነት</th>
                    <th rowspan="2" colspan="1">መጠን</th>
                    <th rowspan="2" colspan="1">ስንት ጊዜ</th>
                    <th rowspan="2" colspan="1">የአንዱ ዋጋ</th>
                    <th rowspan="2" colspan="1">ጠ/ዋጋ</th>
                    <th rowspan="1" colspan="4">የክንውን ጊዜ</th>
                    <th rowspan="2" colspan="1">ምንጭ</th>
                    <th rowspan="2" colspan="1">አስፈፃሚ</th>
                    <th rowspan="2" colspan="1">ምርመራ</th>
                </tr>
                <tr role="row">
                    <th rowspan="1" colspan="1">ኳ1</th>
                    <th rowspan="1" colspan="1">ኳ2</th>
                    <th rowspan="1" colspan="1">ኳ3</th>
                    <th rowspan="1" colspan="1">ኳ4</th>
                </tr>
            </thead>
            <tbody>
                <tr role="row" v-for="r in rows">
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].no" style="width: 50px;" type="number" name=""></td>
                    <td rowspan="1" colspan="3"><input v-model="plans[r-1].name" style="width: 150px;" class="form-control" type="text" name=""></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].amount" style="width: 80px;" class="form-control" type="number" name=""></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].time" style="width: 80px;" class="form-control" type="number" name=""></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].price" style="width: 80px;" class="form-control" type="number" name=""></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].total_price" style="width: 80px;" class="form-control" type="number" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].q1" style="width: 80px;" class="form-control" type="number" name=""></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].q2" style="width: 80px;" class="form-control" type="number" name=""></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].q3" style="width: 80px;" class="form-control" type="number" name=""></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].q4" style="width: 80px;" class="form-control" type="number" name=""></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].source" style="width: 80px;" class="form-control" type="text" name=""></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].person" style="width: 80px;" class="form-control" type="text" name=""></td>
                    <td rowspan="1" colspan="1"><input v-model="plans[r-1].mrmra" style="width: 80px;" class="form-control" type="text" name=""></td>
                </tr>
            </tbody>
            <tfoot>
                <tr role="row">
                    <td rowspan="1" colspan="2">
                        <button v-on:click="rows++" class="btn btn-sm btn-success">
                            <i class="fa fa-plus"></i>
                        </button>
                    </td>
                    <td rowspan="1" colspan="3"><input v-model="title" class="form-control" type="text" placeholder="Title"></td>
                    <td rowspan="1" colspan="2" style="text-align: right;">
                        <button v-on:click="save" class="btn btn-sm btn-success">
                            <i class="fa fa-save"></i> Save
                        </button>
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>
</template>
<style>
thead tr th {
    text-align: center;
}

</style>
<script>
// import AllItems from './AllItems'
// import AddItem from './AddItem'
// import ItemCategory from './ItemCategory'
// import KTable from '../../../../common/KTable'
// import KAddItem from '../../../../common/KAddItem'
// import Overview from "../Inventory/Overview";
// import InventoryTransaction from "../InventoryTransaction";
export default {

    props: [
        'department'
    ],

    components: {
        // AllItems,
        // AddItem,
        // ItemCategory,
        // KTable,
        // KAddItem,
        // Overview,
        // FinancialPlan
        // InventoryTransaction
    },
    data() {
        return {
            current: null,
            rows: 1,
            plans: [
                {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
            ],
            title: null,
            api: '/api/org/my',
            permission: 'setting.org',
            loading: true,

            
        }
    },

    mounted() {

    },
    watch: {
        plans: 'recalc_total_price'
    },
    created() {
        // this.fields.id = 1;
        // this.api = '/api/personnel/employee/single/'+this.fields.id;
    },
    // updated() {
    //   if (!this.active_tab_init) {
    //     this.active_tab = "overview"
    //   }else{
    //     this.active_tab = this.active_tab_init
    //   }
    // },
    methods: {
        recalc_total_price() {
            for (var i = 0; i < this.rows; i++) {
                var plan = this.plans[i]
                this.plans[i].total_price = plan.price * plan.time * plan.amount

            }
        },
        save() {
            var r = this.plans.slice(0, this.rows)
            console.log(r)


            let formData = new FormData();
            
            formData.append('title', this.title)
            formData.append('department_id', this.department.id)
            formData.append('content',JSON.stringify(r))
            // formData.append('_method', "put")
            const config = {
                headers: {
                    'content-type': 'multipart/form-data',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                }
            }
            this.$axios.post('/api/v1/plan', formData, config)
                .then(response => {

                }).catch(error => {

                });
        },


    }


}

</script>
