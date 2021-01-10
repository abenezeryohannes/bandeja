<template>
  <layout-a :page="page_meta" :loaded="loaded"  :page_status_code="page_status_code"
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
                <li v-for="(d, k) in departments" :class="active_class_link('extra'+(k+1))"><a v-on:click="change_active_tab('extra'+(k+1))"><i class="fa fa-inbox"></i> {{d.name}}</a></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="col-md-10">
          <k-tab total="1" :extra="departments.length"  :active="active_tab">

            <template slot="title1">Overview</template>
            <div slot="body1" class="row"> 
              <h2>Overview</h2>
              <!-- <button v-on:click="cm">click me</button> -->
            </div>

            <div v-for="(d, k) in departments" :slot="'extra'+(k+1)">
              <plan-single :department="d" />
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
import PlanSingle from "./PlanSingle";
import pageLoader from "../../mixins/PageLoader"
// import InventoryTransaction from "../InventoryTransaction";
export default {

  props: [
  ],

  mixins: [pageLoader],

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
    departments : [],
    loaded: false,
    page_meta: {
      title: 'Plan',
      permission: 'plan',
      active_link: 'Plan',
      breadcrumb : [
        { label: 'Home', icon: 'dashboard' },
        { label: 'Plan', icon: '' },
      ]
    },


    api: '/api/v1/plan',
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

  set_strings() {
      var strings = this.page_info.strings
      var departments = this.page_info.departments
      this.departments = departments

  },

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
    // var self = this
    // this.$axios
    //       .get(this.api)
    //       .then(response => {
    //           if(response.data.redirect){
    //             window.location = response.data.redirect
    //           }else{
    //             self.loaded = true
    //             this.org = {
    //               name: response.data.data.org.name,
    //               name_am: response.data.data.org.name_am,
    //               logo_url: response.data.data.org.logo,
    //               update_class: 'btn btn-default'
    //             };
    //             this.logo_url = response.data.data.org.logo
    //             this.branch.lists = response.data.data.branches
    //           }
    //       })
    //       .catch(error => {
    //           console.log(error)
    //           this.errored = true
    //       })
    //       .finally(() => this.loading = false)
  },
}


}
</script>
