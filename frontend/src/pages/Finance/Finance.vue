<template>
  <layout-a :page="page_info" :loaded="loaded" 
  >

  
  <section class="content" >
    
      <div class="row" >
        <div class="col-md-2">
          
          <div class="box box-solid">
            <div class="box-header with-border">
              <h3 class="box-title">Departments</h3>
              <div class="box-tools">
              </div>
            </div>
            <div class="box-body no-padding">
              <ul class="nav nav-pills nav-stacked">
                <li :class="active_class_link('extra1')"><a v-on:click="change_active_tab('extra1')"><i class="fa fa-inbox"></i> Admin</a></li>
                <li :class="active_class_link('extra2')"><a v-on:click="change_active_tab('extra2')"><i class="fa fa-inbox"></i> Prayer</a></li>
                <li :class="active_class_link('extra3')"><a v-on:click="change_active_tab('extra3')"><i class="fa fa-inbox"></i> Usher</a></li>
                <li :class="active_class_link('extra4')"><a v-on:click="change_active_tab('extra4')"><i class="fa fa-inbox"></i> Teachers</a></li>
                <li :class="active_class_link('extra5')"><a v-on:click="change_active_tab('extra5')"><i class="fa fa-inbox"></i> Melkam Zer</a></li>
                <li :class="active_class_link('extra6')"><a v-on:click="change_active_tab('extra6')"><i class="fa fa-inbox"></i> Choir</a></li>
                <li :class="active_class_link('extra7')"><a v-on:click="change_active_tab('extra7')"><i class="fa fa-inbox"></i> Counciling</a></li>
                <li :class="active_class_link('extra8')"><a v-on:click="change_active_tab('extra8')"><i class="fa fa-inbox"></i> አፍ-ኤል</a></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="col-md-10">
          <k-tab total="1" extra="8"  :active="active_tab">

            <template slot="title1">Overview</template>
            <div slot="body1" class="row"> 
              <h2>Overview</h2>
              <button v-on:click="cm">click me</button>
            </div>

            <div slot="extra1">
              <plan-single department="Admin" />
            </div>
            <div slot="extra2">
              <plan-single department="Prayer" />
            </div>
            <div slot="extra3">
              <plan-single department="Usher" />
            </div>
            <div slot="extra4">
              <plan-single department="Teachers" />
            </div>
            <div slot="extra5">
              <plan-single department="Melkam Zer" />
            </div>
            <div slot="extra6">
              <plan-single department="Choir" />
            </div>
            <div slot="extra7">
              <plan-single department="Counciling" />
            </div>
            <div slot="extra8">
              <plan-single department="አፍ-ኤል" />
            </div>
          </k-tab>


        </div>

      </div>


  </section>


</layout-a>
</template>

<script>
  // import AllItems from './AllItems'
  // import AddItem from './AddItem'
  // import ItemCategory from './ItemCategory'
  // import KTable from '../../../../common/KTable'
  // import KAddItem from '../../../../common/KAddItem'
// import Overview from "../Inventory/Overview";
import PlanSingle from "../Plan/PlanSingle";
// import InventoryTransaction from "../InventoryTransaction";
export default {

  props: [
  ],

  components: { 
    // AllItems,
    // AddItem,
    // ItemCategory,
    // KTable,
    // KAddItem,
    // Overview,
    PlanSingle
    // InventoryTransaction
  },
data() {
  return {
    loaded: false,
    page_info: {
      title: 'Finance',
      permission: 'plan',
      active_link: 'Finance',
      breadcrumb : [
        { label: 'Home', icon: 'dashboard' },
        { label: 'Finance', icon: '' },
      ]
    },


    api: '/api/org/my',
    permission: 'setting.org',
    loading: true,
    load_page: false,

    add_category: {
      url: '/api/inventory/category/',
      icon: 'fa fa-user',
      title: 'Add Category',
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
      url: '/api/inventory/item/',
      icon: 'fa fa-user',
      title: 'Add Item',
      button_text : [
        'Register',
        'Register and View',
        'Registering'
      ],
      field_groups: [
        {
          'name': 'Info', 'fields': [
            { 'col': 'col-sm-6', 'name': 'Name', 'key' : 'name', 'type': 'text', 'placeholder': 'Name of the Item', 'required': 'yes'  },
            { 'col': 'col-sm-6', 'name': 'Serial Number', 'key' : 'serial', 'type': 'text'  },
            { 'col': 'col-sm-4', 'name': 'Item Picture', 'key' : 'picture', 'type': 'picture'  },
            { 'col': 'col-sm-2', 'name': 'Quantity', 'key' : 'quantity', 'type': 'number', 'step' : '0.01'  },
            { 'col': 'col-sm-2', 'name': 'Unit Price', 'key' : 'unit_price', 'type': 'number', 'step' : '0.01'  },
            { 'col': 'col-sm-4', 'name': 'Material Status', 'key' : 'status', 'type': 'text'  },
            { 'col': 'col-sm-4', 'name': 'Remark', 'key' : 'remark', 'type': 'textarea'  },
            { 'col': 'col-sm-4', 'name': 'Category', 'key' : 'category', 'type': 'vselect-b',  'options': 'categories'  },

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

mounted() {
  // if (this.active_tab_init) {
  //   this.active_tab = this.active_tab_init
  // }
  // this.check_permission(this.permission)
  // this.load_page = true
  this.get_org_data();
  // this.$nextTick(function() {
  //     this.tell_active('Plan')
  // })
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

  pre_page_process(){
    console.log("pre page - plan")
    this.get_org_data();
  },

  cm(){
    console.log(this.$axios.get('api/usermgt/change_pwd'))
    // this.hello()
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
    this.$axios.post('/api/usermgt/change_pwd', formData, config)
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
    var self = this
    this.$axios
          .get(this.api)
          .then(response => {
              if(response.data.redirect){
                window.location = response.data.redirect
              }else{
                self.loaded = true
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
