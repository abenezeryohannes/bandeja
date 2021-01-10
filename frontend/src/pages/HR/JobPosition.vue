<template>
    <div slot="extra2" class="row">
        <!--                Job Position -->
        <div class="col-sm-12">
            <k-add-item :kadd_api="position.add.url" :kadd_title="position.add.title" :kadd_icon="position.add.icon" :kfield_groups="position.add.field_groups" :kbutton_text="position.add.button_text" :kevent_added="position_added" />
        </div>
        <div class="col-sm-12">
            <k-table :ktable_title="position.ktable.title" :ktable_api="position.ktable.api" :ktable_headers="position.ktable.headers" :ktable_row="position.ktable.row" :kevent_refresh="position.ktable.refresh" />
        </div>
    </div>
</template>
<script>
export default {

    props: [],

    mixins: [],

    components: {
    },
    data() {
        return {
            position: {
                ktable: {
                    refresh: 1,
                    title: 'List of Positions',
                    api: '/api/v1/hr/job-position/',

                    headers: [
                        { 'name': 'Title' },
                        { 'name': 'Role' },
                        // { 'name' : 'Xys' },
                        { 'name': 'Actions' },
                    ],
                    row: [
                        { 'type': 'string', 'key': 'title' },
                        { 'type': 'list2', 'key': 'roles' },
                        {
                            'type': 'actions',
                            'key': 'actions',
                            'actions': [
                                { 'type': 'delete' },
                                // { 'link': 'HREmployeeSingle', 'name': 'Detail', 'class': 'btn btn-sm btn-success' }
                            ]
                        },
                    ]
                },
                add: {
                    url: '/api/v1/hr/job-position/',
                    icon: 'fa fa-user',
                    title: 'Add Position',
                    button_text: [
                        'Add Position',
                        '',
                        'Adding'
                    ],
                    field_groups: [{
                        'name': '',
                        'fields': [
                            { 'col': 'col-sm-4', 'name': 'Title', 'key': 'title', 'type': 'text' },
                            { 'col': 'col-sm-8', 'name': 'Roles', 'key': 'roles', 'type': 'vselect-c', 'options': 'roles' },
                        ]
                    }]
                },
            },

        }
    },

    mounted() {

    },
    created() {

    },

    methods: {
        position_added(){
        this.position.ktable.refresh = Math.random()
      },
    }


}

</script>
