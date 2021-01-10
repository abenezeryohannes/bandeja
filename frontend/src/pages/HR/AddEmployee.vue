<template>
    <k-add-item
                        :kadd_api="add_employee.url"
                        :kadd_title="add_employee.title"
                        :kadd_icon="add_employee.icon"
                        :kfield_groups="add_employee.field_groups"
                        :kbutton_text="add_employee.button_text"
                />
</template>
<script>
export default {

    props: [],

    mixins: [],

    components: {
    },
    data() {
        return {
            add_employee: {
      url: '/api/v1/hr/employee/',
      icon: 'fa fa-user',
      title: 'Add Employee',
      button_text : [
        'Add Employee',
        null,
        'Adding'
      ],
      field_groups: [
        {
          'name': 'Basic Info', 'fields': [
            { 'col': 'col-sm-8', 'name': 'Name', 'key' : 'name', 'type': 'text', 'placeholder': 'Full Name of the Employee', 'required': 'yes'  },
            { 'col': 'col-sm-2', 'name': 'Sex', 'key' : 'sex', 'type': 'select', 'options' : [{'code': 'F', 'label': 'Female'},{'code': 'M', 'label': 'Male'}]  },
            { 'col': 'col-sm-2', 'name': 'Age', 'key' : 'age', 'type': 'number'  },
            { 'col': 'col-sm-5', 'name': 'Employee Picture', 'key' : 'image', 'type': 'picture'  },
            { 'col': 'col-sm-5', 'name': 'Educational background', 'key' : 'educational_background', 'type': 'vselect-b',  'options': 'educational_background'  },
          ]
        }, {
          'name': 'Address', 'fields': [
            { 'col': 'col-sm-6', 'name': 'Email', 'key' : 'email', 'type': 'text' },
            { 'col': 'col-sm-6', 'name': 'Phone Number', 'key' : 'phone', 'type': 'text'  },
            { 'col': 'col-sm-3', 'name': 'Region', 'key' : 'region', 'type': 'vselect-b',  'options': 'regions'  },
            { 'col': 'col-sm-3', 'name': 'Zone', 'key' : 'zone', 'type': 'text'  },
            { 'col': 'col-sm-3', 'name': 'Woreda', 'key' : 'woreda', 'type': 'text'  },
            { 'col': 'col-sm-3', 'name': 'Kebele', 'key' : 'kebele', 'type': 'text'  },
          ]
        }, {
          'name': 'Employment', 'fields': [
            { 'col': 'col-sm-4', 'name': 'Position', 'key' : 'position', 'type': 'vselect-b',  'options': 'positions'  },
            { 'col': 'col-sm-4', 'name': 'Employement type', 'key' : 'employement_type', 'type': 'vselect-b', 'options' : 'employement_types' },
            { 'col': 'col-sm-4', 'name': 'Branch', 'key' : 'branch', 'type': 'vselect-b',  'options': 'branches'  },
          ]
        }, {
          'name': 'Financial', 'fields': [
            { 'col': 'col-sm-4', 'name': 'Bank Name', 'key' : 'bank_account_name', 'type': 'vselect-b',  'options': 'banks'  },
            { 'col': 'col-sm-4', 'name': 'Bank account Number', 'key' : 'bank_account_number', 'type': 'text'  },
            { 'col': 'col-sm-4', 'name': 'Salary', 'key' : 'salary', 'type': 'number'  },
          ]
        }
      ]
    },

        }
    },

    mounted() {

    },
    created() {

    },

    methods: {

    }


}

</script>
