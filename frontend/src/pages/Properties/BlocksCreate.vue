<template>
    <layout-b :page="page_meta"   :page_status_code="page_status_code">

        <ak-form-a 
        :extra_models="extra_models"
            :boot_data="page_info"
            action_api="/api/v1/blocks/store"
            method="patch"
            :return_url="{ name: 'Blocks' }"
        >
        <template v-slot:types>
                    <ak-input  label="Types of properties" icon="fa fa-envelope" v-model="type_count" type="number"  column="col-sm-3"  />
                <div class="col-sm-9 row" v-if="type_count">
                    <template v-for="i in Number(type_count)">
                            <ak-select v-if="i==1" label="Properties Categories"  innerClassName="el-input__inner" v-model="prty_categories[i]" column="col-sm-4" :options="page_info.form.extra_fields.data.categories"  />
                            <ak-select v-else  innerClassName="el-input__inner" column="col-sm-4" v-model="prty_categories[i]" :options="page_info.form.extra_fields.data.categories"  />

                            <ak-input v-if="i==1" label="Properties Numbers" icon="fa fa-envelope" column="col-sm-8" v-model="prty_numbers[i]" type="text"   />
                            <ak-input v-else icon="fa fa-envelope" v-model="prty_numbers[i]" type="text" column="col-sm-8""  />

                    </template>
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

    computed: {

    },
    watch: {
        prty_categories: 'calculate_prtys',
        prty_numbers: 'calculate_prtys',
    },
    data() {
        return {
            type_count: null,
            prty_categories: {},
            prty_numbers: {},
            extra_models: {
                properties: null,
            },
            page_meta: {
                title: 'Blocks',
                permission: 'plan',
                active_link: 'Blocks',
                parent: 'PropertiesM',
                breadcrumb: []
            },
            api: '/api/v1/blocks/create',
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
        calculate_prtys(){
            console.log(this.prty_categories)
            console.log(this.prty_numbers)
            var t =  []
            for (var i = this.type_count - 1; i >= 0; i--) {
                var t1 = this.prty_categories[i] || null
                var t2 = this.prty_numbers[i] || null
                if (t1 && t2) {
                    t.push( {
                        "property_category_id": t1,"properties": t2
                        // this.prty_categories[i] 
                    } )
                }
            }
            this.extra_models.properties = JSON.stringify({"data":t})
        }
    }
}

</script>
