<template>
    <layout-b :page="page_meta" :page_status_code="page_status_code">
        <div class="card" v-if="page_info.data">
            <div class="card-header ">
                <div class="row">
                    <div  class="col-md-3">
                        <div class="card bg-gradient-info border-0">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="text-uppercase text-muted mb-0 text-white">Properties</h5>
                                        <div class="dropdown-divider"></div> 
                                        <span class="h2 font-weight-bold mb-0 text-white">{{page_info.data.no_of_available_properties}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div  class="col-md-3">
                        <div class="card bg-gradient-success border-0">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="text-uppercase text-muted mb-0 text-white">Available</h5>
                                        <div class="dropdown-divider"></div> 
                                        <span class="h2 font-weight-bold mb-0 text-white">{{page_info.data.no_of_properties}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div  class="col-md-3">
                        <div class="card bg-gradient-info border-0">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="text-uppercase text-muted mb-0 text-white">Occupied</h5>
                                        <div class="dropdown-divider"></div> 
                                        <span class="h2 font-weight-bold mb-0 text-white">{{page_info.data.no_of_occupied_properties}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div  class="col-md-3">
                        <div class="card bg-gradient-danger border-0">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="text-uppercase text-muted mb-0 text-white">Disabled</h5>
                                        <div class="dropdown-divider"></div> 
                                        <span class="h2 font-weight-bold mb-0 text-white">{{page_info.data.no_of_disabled_properties}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-3">
                        <ul class="list-group mb-4 ">
                            <li class="list-group-item border-0 ">
                                <div class="font-weight-600">Rent Price</div>
                                <div><small class="long-texts">{{page_info.data.rent_price}}</small></div>
                            </li>
                            <li class="list-group-item border-0 border-top-1">
                                <div class="font-weight-600">Sell Price</div>
                                <div><small class="long-texts">{{page_info.data.sell_price}}</small></div>
                            </li>
                            <li class="list-group-item border-0 border-top-1">
                                <div class="font-weight-600">Description</div>
                                <div><small  class="long-texts">{{page_info.data.description}}</small></div>
                            </li>
                        </ul> 
                    </div>
                    <div class="col-md-9" v-if="page_info.data">
                        <img :src="page_info.data.picture" class="img-fluid">
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
                title: 'Categories',
                permission: 'plan',
                active_link: 'Categories',
                parent: 'PropertiesM',
                breadcrumb: []
            },
            api: '/api/v1/propertycategories/show/'+this.$route.params.id,
            isActive: [],

            table: {
                columns: [
                    { label: '', name: '#', column: 1 },
                    { label: 'Name', name: 'name', column: 2 },
                    { label: 'Description', name: 'description', column: 3 },
                    { label: 'Price', name: 'rent_price', column: 2 },
                    { label: 'No of Properties', name: 'no_of_properties' },
                    { label: 'Status', name: 'enabled', type: 'status' },
                    { label: 'Actions', name: '##' },
                ]
            }
        }
    },

    methods: {

        set_strings(){

            this.page_meta.title = this.page_info.data.name
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
