<template>
    <nav class="navbar navbar-top navbar-expand navbar-dark border-bottom">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <form class="navbar-search navbar-search-light form-inline mb-0" id="navbar-search-main" autocomplete="off">
                    <div id="global-search" class="form-group mb-0 mr-sm-3">
                        <div class="input-group input-group-alternative input-group-merge">
                            <div class="input-group-prepend"><span class="input-group-text"><i class="fa fa-search"></i></span></div> <input type="text" name="search" autocomplete="off" placeholder="Search" class="form-control">
                            <div class="dropdown-menu dropdown-menu-xl dropdown-menu-center">
                                <div class="list-group list-group-flush"></div>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="close" data-action="search-close" data-target="#navbar-search-main" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </form>
                <ul class="navbar-nav align-items-center ml-md-auto">
                    <li class="nav-item d-xl-none">
                        <div class="pr-3 sidenav-toggler sidenav-toggler-dark active" data-action="sidenav-pin" data-target="#sidenav-main">
                            <div class="sidenav-toggler-inner">
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                            </div>
                        </div>
                    </li>
                    <li class="nav-item d-sm-none">
                        <a class="nav-link" href="#" data-action="search-show" data-target="#navbar-search-main">
                            <i class="fa fa-search"></i>
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-plus"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-dark dropdown-menu-right">
                            <div class="row shortcuts px-4">
                                <a href="http://localhost:8000/sales/invoices/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-info">
                                        <i class="fa fa-money-bill"></i>
                                    </span>
                                    <small class="text-info">Invoice</small>
                                </a>
                                <a href="http://localhost:8000/sales/revenues/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-info">
                                        <i class="fas fa-hand-holding-usd"></i>
                                    </span>
                                    <small class="text-info">Revenue</small>
                                </a>
                                <a href="http://localhost:8000/sales/customers/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-info">
                                        <i class="fas fa-user"></i>
                                    </span>
                                    <small class="text-info">Customer</small>
                                </a>
                                <a href="http://localhost:8000/purchases/bills/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-danger">
                                        <i class="fa fa-shopping-cart"></i>
                                    </span>
                                    <small class="text-danger">Bill</small>
                                </a>
                                <a href="http://localhost:8000/purchases/payments/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-danger">
                                        <i class="fas fa-hand-holding-usd"></i>
                                    </span>
                                    <small class="text-danger">Payment</small>
                                </a>
                                <a href="http://localhost:8000/purchases/vendors/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-danger">
                                        <i class="fas fa-user"></i>
                                    </span>
                                    <small class="text-danger">Vendor</small>
                                </a>
                            </div>
                        </div>
                    </li>
<!--                     <li class="nav-item dropdown show">
                        <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                            <i class="fas fa-plus"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-dark dropdown-menu-right show">
                            <div class="row shortcuts px-4">
                                <a href="http://localhost:8000/sales/invoices/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-info">
                                        <i class="fa fa-money-bill"></i>
                                    </span>
                                    <small class="text-info">Invoice</small>
                                </a>
                                <a href="http://localhost:8000/sales/revenues/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-info">
                                        <i class="fas fa-hand-holding-usd"></i>
                                    </span>
                                    <small class="text-info">Revenue</small>
                                </a>
                                <a href="http://localhost:8000/sales/customers/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-info">
                                        <i class="fas fa-user"></i>
                                    </span>
                                    <small class="text-info">Customer</small>
                                </a>
                                <a href="http://localhost:8000/purchases/bills/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-danger">
                                        <i class="fa fa-shopping-cart"></i>
                                    </span>
                                    <small class="text-danger">Bill</small>
                                </a>
                                <a href="http://localhost:8000/purchases/payments/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-danger">
                                        <i class="fas fa-hand-holding-usd"></i>
                                    </span>
                                    <small class="text-danger">Payment</small>
                                </a>
                                <a href="http://localhost:8000/purchases/vendors/create" class="col-4 shortcut-item">
                                    <span class="shortcut-media avatar rounded-circle bg-gradient-danger">
                                        <i class="fas fa-user"></i>
                                    </span>
                                    <small class="text-danger">Vendor</small>
                                </a>
                            </div>
                        </div>
                    </li> -->
                    <li class="nav-item dropdown">
                        <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span>
                                <i class="far fa-bell"></i>
                            </span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right py-0 overflow-hidden">
                            <div class="list-group list-group-flush">
                            </div>
                            <a class="dropdown-item text-center text-primary font-weight-bold py-3">You have no notification</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="http://localhost:8000/install/updates" title="0 Updates Available" role="button" aria-haspopup="true" aria-expanded="false">
                            <span>
                                <i class="fa fa-sync-alt"></i>
                            </span>
                        </a>
                    </li>
                    <li class="nav-item d-none d-md-block">
                        <a class="nav-link" href="https://akaunting.com/support" target="_blank" title="Help" role="button" aria-haspopup="true" aria-expanded="false">
                            <i class="far fa-life-ring"></i>
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav align-items-center ml-auto ml-md-0">
                    <li :class="user_menu_class" >
                        <a class="nav-link pr-0" v-click-outside="close_user_menu" v-on:click="toggle_user_menu" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                            <div class="media align-items-center">
                                <img :src="header_info.user_info.pp" class="user-img" alt="">
                            </div>
                        </a>
                        <div :class="user_menu_class2">
                            <div class="dropdown-header noti-title">
                                <h6 class="text-overflow m-0">Welcome</h6>
                            </div>
                            <router-link  class="dropdown-item"  :to="{ name : 'Profile' }">
                                <i class="fas fa-user"></i>
                                <span>Profile</span>
                            </router-link>
                            <div class="dropdown-divider"></div>
                            <a href="http://localhost:8000/auth/users" class="dropdown-item">
                                <i class="fas fa-users"></i>
                                <span>Users</span>
                            </a>
                            <a href="http://localhost:8000/auth/roles" class="dropdown-item">
                                <i class="fas fa-list"></i>
                                <span>Roles</span>
                            </a>
                            <a href="http://localhost:8000/auth/permissions" class="dropdown-item">
                                <i class="fas fa-key"></i>
                                <span>Permissions</span>
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="/logout" class="dropdown-item">
                                <i class="fas fa-power-off"></i>
                                <span>Logout</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</template>
<script>
import { store } from '../state/simpleState';

export default {
    props: {
        boot_the_app: {

        },
        header_info: {
            default: function() {
                return {}
            }
        },
        page: {
            type: Object,
            default: function() {
                return {
                    title: '',
                    permission: '',
                    active_link: '',
                    breadcrumb: [
                        { label: 'Home', icon: 'dashboard' },
                    ]
                }
            }
        },
    },
    components: {},
    data: () => ({
        show_user_menu: false,
        user_menu_class: "nav-item dropdown",
        user_menu_class2: "dropdown-menu dropdown-menu-right",

        page_status: 'loading',
        user_info: {},
        main_menu: [],
        main_menu_header: null,
        home_img: null,
        see_more_class: 'dropdown',

        locale: null,




        user_account_expanded: "false",
        user_account_class: "dropdown user user-menu",

        navbar_collapse: false,
        navbar_toggle_class: 'collapse navbar-collapse pull-left',

        notification_count: 0,


        search_query: null,
    }),

    events: {

    },
    watch: {
        // d: {
        //     handler: 'checkNotification',
        //     immediate: true
        // },
        header_info: 'set_data'
    },
    computed: {

    },



    methods: {
        close_user_menu(){
            this.show_user_menu = true
            this.toggle_user_menu()
        },
        toggle_user_menu(){
            if (this.show_user_menu) {
                this.user_menu_class =  "nav-item dropdown"
                this.user_menu_class2 = "dropdown-menu dropdown-menu-right"
            }else{
                this.user_menu_class =  "nav-item dropdown show"
                this.user_menu_class2 = "dropdown-menu dropdown-menu-right show"
            }
            this.show_user_menu = !this.show_user_menu
        },
        set_data() {
            this.main_menu = this.header_info.main_menu
            this.user_info = this.header_info.user_info
            this.home_img = this.header_info.home_img
            this.locale = this.header_info.locale
        },
        close_see_more() {
            this.see_more_class = 'dropdown'
        },
        open_see_more() {
            this.see_more_class = 'dropdown open'
        },

        search() {
            this.$router.push({
                replace: true,
                name: 'SearchPage',
                params: { query: this.search_query }
            });
        },
        checkNotification() {
            setInterval(function() {
                this.$axios
                    .get('/api/v1/notification?status=new')
                    .then(response => {
                        this.notification_count = response.data.count
                        // this.notification_count = Math.floor(Math.random()*10)
                        // this.notification_count = response.data.data.count

                    })
            }.bind(this), 30000);
        },
        navbar_make_collapse() {
            this.navbar_collapse = false
            this.navbar_toggle_class = 'collapse navbar-collapse pull-left'
        },
        navbar_collapse_toggle() {
            this.navbar_collapse = !this.navbar_collapse
            if (this.navbar_collapse) {
                this.navbar_toggle_class = 'navbar-collapse pull-left collapse in'
            } else {
                this.navbar_toggle_class = 'collapse navbar-collapse pull-left'
            }
        },
        toggle_user_remove(event) {
            store.state.my_account_opened = true
            this.toggle_user()
        },

        toggle_user() {
            if (store.state.my_account_opened) {
                this.user_account_expanded = "false"
                this.user_account_class = "dropdown user user-menu"
            } else {
                this.user_account_expanded = "true"
                this.user_account_class = "dropdown user user-menu open"
            }
            store.toggleMyAccount()
        },


        menu_link_activer(m) {
            if (m == this.page.active_link) {
                return "active";
            }
            return "";
        },

        toggle_lang(event) {
            const la = event.target.value
            const config = {
                headers: {
                    'content-type': 'multipart/form-data',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                }
            }
            let formData = new FormData();
            formData.append('locale', event.target.value)
            this.$axios.post('/api/v1/me/change_lang', formData, config)
                .then(response => {
                    this.boot_the_app()
                }).catch(error => {
                    if (error.response.status === 422) {
                        this.errors = error.response.data.errors || {};
                    }
                });
        },
    },

    mounted() {

    },
    updated() {

        this.active_link = this.page.active_link
    },
};

</script>
