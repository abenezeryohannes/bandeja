<template>
<div>
  <h2>Department : {{department.name}}</h2>
  <button class="btn btn-primary btn-sm" v-on:click="current='view'">View Previous Plans</button>
  <button class="btn btn-primary btn-sm" v-on:click="current='finance'">Financial Plan</button>
  <button class="btn btn-primary btn-sm" v-on:click="current='file'">Add plan file</button>
  <div v-if="current=='file'">
              <k-add-item
                      :kadd_api="add_item.url"
                      :kadd_title="add_item.title"
                      :kadd_icon="add_item.icon"
                      :kfield_groups="add_item.field_groups"
                      :kbutton_text="add_item.button_text"
              />
  </div>
  <div v-if="current=='finance'">
              <financial-plan :department="department" />
  </div>
  <div v-if="current=='view'">
    <h4>Plans </h4>
    <ul>
      <li v-for="p in prev_plans">
        {{p.title}} 
        <a v-if="view_prev_plan !=  p.id"  v-on:click="view_prev_plan = p.id" >View</a>
        <a v-if="view_prev_plan ==  p.id" v-on:click="view_prev_plan =null" >close</a>
         <financial-plan-single v-if="view_prev_plan ==  p.id" :plan="p" />

      </li>
    </ul>
  </div>

</div>
</template>

<script>
  // import AllItems from './AllItems'
  // import AddItem from './AddItem'
  // import ItemCategory from './ItemCategory'
  // import KTable from '../../../../common/KTable'
  // import KAddItem from '../../../../common/KAddItem'
// import Overview from "../Inventory/Overview";
import FinancialPlan from "./FinancialPlan";
import FinancialPlanSingle from "./FinancialPlanSingle";
// import InventoryTransaction from "../InventoryTransaction";
export default {

  props: [
    'check_permission', 'load_page', 'tell_active', 'user_avatar', 'user_name',
    'active_tab_init', 'department'
  ],

  components: {
    FinancialPlan,
    FinancialPlanSingle
  },
data() {
  return {
    view_prev_plan: null,
    prev_plans: [],
    current: "view",
    api: '/api/org/my',
    permission: 'setting.org',
    loading: true,

    add_category: {
      url: '/api/inventory/category/',
      icon: 'fa fa-user',
      title: 'Add new Category',
      button_text : [
        'Add',
        null,
        'Adding'
      ],
      field_groups: [
        {
          'name': '', 'fields': [
            { 'col': 'col-sm-6', 'name': 'Name', 'key' : 'name', 'type': 'text', 'placeholder': 'Name of the category', 'required': 'yes'  },
            ]
        }
      ]
    },

    add_item: {
      url: '/api/test/media/',
      icon: 'fa fa-user',
      title: this.department.name+' - Add new Plan',
      button_text : [
        'Add',
        '',
        'Adding'
      ],
      field_groups: [
        {
          'name': 'Info', 'fields': [
            { 'col': 'col-sm-6', 'name': 'Title', 'key' : 'name', 'type': 'text', 'placeholder': 'Title of the file', 'required': 'yes'  },
            { 'col': 'col-sm-4', 'name': 'File', 'key' : 'picture', 'type': 'picture'  },
            // { 'col': 'col-sm-2', 'name': 'Quantity', 'key' : 'quantity', 'type': 'number', 'step' : '0.01'  },
            // { 'col': 'col-sm-2', 'name': 'Unit Price', 'key' : 'unit_price', 'type': 'number', 'step' : '0.01'  },
            // { 'col': 'col-sm-4', 'name': 'Material Status', 'key' : 'status', 'type': 'text'  },
            // { 'col': 'col-sm-4', 'name': 'Remark', 'key' : 'remark', 'type': 'textarea'  },

          ]
        }
      ]
    },
    all_items_ktable : {
      title: 'List of Inventory Items',
      api : '/api/inventory/item/',
      headers: [
        { 'name' : 'Name' },
        { 'name' : 'Image' },
        { 'name' : 'Status' },
        { 'name' : 'Quantity' },
        { 'name' : 'Serial' },
        { 'name' : 'Unit Price' },
        { 'name' : 'Total Price' },
        { 'name' : 'Categories' },
        { 'name' : 'Actions' },
      ],
      row: [
        { 'type' : 'string', 'key': 'name' },
        { 'type' : 'image', 'key': 'image' },
        { 'type' : 'string', 'key': 'status' },
        { 'type' : 'string', 'key': 'quantity' },
        { 'type' : 'string', 'key': 'serial' },
        { 'type' : 'string', 'key': 'unit_price' },
        { 'type' : 'string', 'key': 'total_price' },
        { 'type' : 'list2', 'key': 'categories' },
        { 'type' : 'actions', 'key': 'name', 
            'actions' : [
              { 'type': 'delete' },
              // { 'link': 'InventoryItemSingle', 'name': 'Detail', 'class': 'btn btn-sm btn-success' }
            ] 
        },
      ]
    },



    all_categories_ktable : {
      title: 'List of Inventory Categories',
      api : '/api/inventory/category/',
      headers: [
        { 'name' : '#' },
        { 'name' : 'Name' },
        { 'name' : 'Actions' },
      ],
      row: [
        { 'type' : '#' },
        { 'type' : 'string', 'key': 'name' },
        { 'type' : 'actions', 'key': 'name', 
            'actions' : [
              { 'type': 'delete' }
            ] 
        },
      ]
    },

    logo_url: null,
    user: {
      name: null,
      pic: null,
    },
    org: {
      name: null,
      logo_url: null,
      update_class: 'btn btn-default'
    },
    org_errors: {},

    active_tab: "1",
    password2: null,
    password1: null,
    password_error: false,
  }
},

watch: {
  current: 'load_previous'
},

mounted() {
  this.load_previous()
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
  load_previous(){
    if (this.current != "view") {
      return;
    }
    this.$axios
          .get("/api/v1/plan/"+this.department.id)
          .then(response => {
              this.prev_plans = response.data.plans
          })
          .catch(error => {
          })
  },

  check_pwds(){
    if (!this.password1 || !this.password2) {
      this.password_error = false
    }else if (this.password1 != this.password2) {
      this.password_error = true;
    }else{
      this.password_error = false
    } 
    console.log(this.password1, this.password1, this.password_error)
  },
  change_active_tab(t){
    this.active_tab = t
  },

  active_class_link(l){
    if (this.active_tab == l) {
      return "active"
    }
    return ""
  },

  change_pw(){
    if (!this.password1 || !this.password1) {
      this.$swal({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: false,
        onOpen: (toast) => {
          toast.addEventListener('mouseenter', Swal.stopTimer)
          toast.addEventListener('mouseleave', Swal.resumeTimer)
        },
        icon: 'error',
        title: 'Empty field found',
      })
      return ;
    }
    if (this.password1 != this.password2) {
      this.$swal({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: false,
        onOpen: (toast) => {
          toast.addEventListener('mouseenter', Swal.stopTimer)
          toast.addEventListener('mouseleave', Swal.resumeTimer)
        },
        icon: 'error',
        title: 'Passwords do not match',
      })
      return ;
    }

    let formData = new FormData();
    formData.append('password',this.password1)
    const config = {
      headers: {
        'content-type' : 'multipart/form-data',
        'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').content,
      }
    }
    axios.post('/api/usermgt/change_pwd', formData, config)
        .then(response => {
            if (response.data.status == "success") {
                this.$swal({
                  toast: true,
                  position: 'top-end',
                  showConfirmButton: false,
                  timer: 3000,
                  timerProgressBar: false,
                  onOpen: (toast) => {
                    toast.addEventListener('mouseenter', Swal.stopTimer)
                    toast.addEventListener('mouseleave', Swal.resumeTimer)
                  },
                  icon: 'success',
                  title: 'Password updated',
                })
            }
            this.password1 = null
            this.password2 = null
    }).catch(error => {
      if(error.response.status === 422 ){
        this.org_errors = error.response.data.errors || {};
        this.$swal({
          toast: true,
          position: 'top-end',
          showConfirmButton: false,
          timer: 3000,
          timerProgressBar: false,
          icon: 'error',
          title: error.response.data.message,
        })
      }
    });
  },

  get_org_data() {
    
    axios
          .get(this.api)
          .then(response => {
              if(response.data.redirect){
                window.location = response.data.redirect
              }else{
                this.loading = false
                this.org = {
                  name: response.data.data.org.name,
                  name_am: response.data.data.org.name_am,
                  logo_url: response.data.data.org.logo,
                  update_class: 'btn btn-default'
                };
                this.logo_url = response.data.data.org.logo
                this.branch.lists = response.data.data.branches
              }
          })
          .catch(error => {
              console.log(error)
              this.errored = true
          })
          .finally(() => this.loading = false)
  },
}


}
</script>
