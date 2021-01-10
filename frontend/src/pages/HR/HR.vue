<template>
    <layout-a :page="page_meta" :loaded="loaded" :page_status_code="page_status_code">
        <section class="content">
            <div class="row">
                <div class="col-md-2">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">{{strings.employee}}</h3>
                            <div class="box-tools">
                            </div>
                        </div>
                        <div class="box-body no-padding">
                            <ul class="nav nav-pills nav-stacked">
                                <li :class="active_class_link('extra1')"><a v-on:click="change_active_tab('extra1')"><i class="fa fa-inbox"></i> Add Employee</a></li>
                                <li :class="active_class_link('extra2')"><a v-on:click="change_active_tab('extra2')"><i class="fa fa-inbox"></i> Job Positions</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">Attendance</h3>
                            <div class="box-tools">
                            </div>
                        </div>
                        <div class="box-body no-padding">
                            <ul class="nav nav-pills nav-stacked">
                                <li :class="active_class_link('extra3')"><a v-on:click="change_active_tab('extra3')"><i class="fa fa-inbox"></i> Add Attendance</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-10">
                    <k-tab total="4" extra="3" :active="active_tab">
                        <template slot="title1">Overview</template>
                        <div slot="body1" class="row ">
                            <hr-overview />
                        </div>
                        <template slot="title2">All Employees</template>
                        <div slot="body2">
                            <k-table :ktable_title="all_employees_ktable.title" :ktable_api="all_employees_ktable.api" :ktable_headers="all_employees_ktable.headers" :ktable_row="all_employees_ktable.row" />
                        </div>
                        <add-employee slot="extra1"></add-employee>
                        <job-position slot="extra2"></job-position>

                    </k-tab>
                </div>
            </div>
        </section>
    </layout-a>
</template>
<script>
import pageLoader from "../../mixins/PageLoader"

import HrOverview from "./HrOverview"
import JobPosition from "./JobPosition"
import AddEmployee from "./AddEmployee"

export default {

    props: [],

    mixins: [pageLoader],

    components: {
        HrOverview,
        JobPosition,
        AddEmployee
    },
    data() {
        return {
            loaded: false,
            page_meta: {
                title: 'Human Resource',
                permission: 'hr',
                active_link: 'HR',
                breadcrumb: [
                    { label: 'Home', icon: 'dashboard' },
                    { label: 'Human Resource', icon: '' },
                ]
            },


            api: '/api/v1/hr',
            permission: 'setting.org',

            strings: {
                employee: 'Employee'
            },

            all_employees_ktable: {
                title: 'List of Employees',
                api: '/api/v1/hr/employee/',
                headers: [
                    { 'name': 'Name' },
                    { 'name': 'Positions Held' },
                    // { 'name' : 'Xys' },
                    { 'name': 'Actions' },
                ],
                row: [
                    { 'type': 'string', 'key': 'name' },
                    { 'type': 'list', 'key': 'roles_short' },
                    // { 'type' : 'string', 'key': 'name' },
                    {
                        'type': 'actions',
                        'key': 'name',
                        'actions': [
                            { 'link': 'HREmployeeSingle', 'name': 'Detail', 'class': 'btn btn-sm btn-success' }
                        ]
                    },
                ]
            },

        }
    },

    mounted() {

    },
    created() {

    },

    methods: {
        set_strings() {
            var strings = this.page_info.strings
            this.strings.employee = strings.employee
        }
    }


}

</script>
