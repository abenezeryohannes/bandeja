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
                <tr role="row" v-for="r in plan.content">
                    <td rowspan="1" colspan="1"><input v-model="r.no" style="width: 50px;" type="number" name="" disabled></td>
                    <td rowspan="1" colspan="3"><input v-model="r.name" style="width: 150px;" class="form-control" type="text" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.amount" style="width: 80px;" class="form-control" type="number" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.time" style="width: 80px;" class="form-control" type="number" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.price" style="width: 80px;" class="form-control" type="number" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.total_price" style="width: 80px;" class="form-control" type="number" name="" disabled disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.q1" style="width: 80px;" class="form-control" type="number" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.q2" style="width: 80px;" class="form-control" type="number" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.q3" style="width: 80px;" class="form-control" type="number" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.q4" style="width: 80px;" class="form-control" type="number" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.source" style="width: 80px;" class="form-control" type="text" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.person" style="width: 80px;" class="form-control" type="text" name="" disabled></td>
                    <td rowspan="1" colspan="1"><input v-model="r.mrmra" style="width: 80px;" class="form-control" type="text" name="" disabled></td>
                </tr>
            </tbody>
            <tfoot>
                <tr role="row">
                    <td rowspan="1" colspan="2">
                        
                    </td>
                    <td rowspan="1" colspan="3"><input v-model="plan.title" class="form-control" type="text" placeholder="Title" disabled></td>
                    <td rowspan="1" colspan="2" style="text-align: right;">
                        <button  class="btn btn-sm btn-success">
                            <i class="fa fa-edit"></i> Edit
                        </button>
                    </td>
                    <td rowspan="1" colspan="2" style="text-align: right;">
                        <button  class="btn btn-sm btn-danger">
                            <i class="fa fa-trash"></i> Delete
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
        'plan'
    ],

    components: {
    },
    data() {
        return {      
        }
    },

    mounted() {

    },
    created() {
        // this.fields.id = 1;
        // this.api = '/api/personnel/employee/single/'+this.fields.id;
    },
    methods: {



    }


}

</script>
