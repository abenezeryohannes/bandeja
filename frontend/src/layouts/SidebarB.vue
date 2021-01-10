<template>
    <nav class="sidenav navbar navbar-vertical fixed-left navbar-expand-xs navbar-light bg-default" id="sidenav-main">
        <div class="scrollbar-inner">
            <div class="sidenav-header d-flex align-items-center">
                <ul class="navbar-nav" v-click-outside="close_company">
                    <li :class="company_class">
                        <a class="nav-link" v-on:click="toggle_company" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="avatar menu-avatar background-unset">
                                <img class="border-radius-none border-0 mr-3" alt="Akaunting" :src="header_info.home_img">
                            </span>
                            <span class="nav-link-text long-texts pl-2 mwpx-100">My Company</span>
                            <i class="fas fa-sort-down pl-2"></i>
                        </a>
                        <!-- <div class="dropdown-menu dropdown-menu-right menu-dropdown menu-dropdown-width"> -->
                        <div :class="company_class2">
                            <a href="http://localhost:8000/common/companies/1/switch" class="dropdown-item">
                                <i class="fas fa-building"></i>
                                <span>My Company</span>
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="http://localhost:8000/common/companies" class="dropdown-item">
                                <i class="fas fa-cogs"></i>
                                <span>Manage Companies</span>
                            </a>
                        </div>
                    </li>
                </ul>
                <div class="ml-auto left-menu-toggle-position overflow-hidden">
                    <div class="sidenav-toggler d-none d-xl-block left-menu-toggle active" data-action="sidenav-unpin" data-target="#sidenav-main">
                        <div class="sidenav-toggler-inner">
                            <i class="sidenav-toggler-line"></i>
                            <i class="sidenav-toggler-line"></i>
                            <i class="sidenav-toggler-line"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="navbar-inner">
                <!-- Collapse -->
                <div class="collapse navbar-collapse" id="sidenav-collapse-main">
                    <!-- Nav items -->
                    <ul class="navbar-nav">
                        <li class="nav-item" v-for="l in main_menu">
                            <template v-if="l.dropdown"  >
                                <a class="nav-link"  data-toggle="collapse" role="button" :aria-expanded="get_aria_expanded(l)"   v-on:click="l.expand = !l.expand" >
                                    <i :class="l.icon"></i>
                                    <span class="nav-link-text">{{l.label}}</span>
                                </a>
                                <div :class="get_collapse_class(l)" id="navbar-property-management">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item " v-for="ll in l.li"> <router-link  :to="{ name : ll.name }" :class="get_page_class(ll.name)"> <span class="nav-link-text">{{ll.label}}</span> </router-link> </li>
                                    </ul>
                                </div>
                            </template>
                            <router-link v-else  :to="{ name : l.name }" :class="get_page_class(l.name)"> 
                                <i :class="l.icon"></i> <span class="nav-link-text">{{l.label}}</span> 
                            </router-link>
                        </li>
                    </ul>
                </div>
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
                    parent: '',
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
        page_status: 'loading',
        user_info: {},
        main_menu: [
        ],
        main_menu_header: null,
        home_img: null,
        see_more_class: 'dropdown',

        locale: null,

        company_class: 'nav-item dropdown',
        company_class2: 'dropdown-menu dropdown-menu-right menu-dropdown menu-dropdown-width',
        company_show: false,

        expanded_menus: [],




        user_account_expanded: "false",
        user_account_class: "dropdown user user-menu",

        navbar_collapse: false,
        navbar_toggle_class: 'collapse navbar-collapse pull-left',

        notification_count: 0,


        search_query: null,

        menu: [
            { label: 'Home', icon: 'fa fa-tachometer-alt', name: 'Home' },
            { label: 'Properties', name: 'Properties', icon: 'fa fa-trash-o', dropdown: true, 
                expand: false, li: [
                { label: 'ddd', name: 'Plan' },
                { label: 'Sales', name: 'Sales' },
            ] }
        ]


    }),

    events: {

    },
    watch: {
        d: {
            handler: 'checkNotification',
            immediate: true
        },
        header_info: 'set_data'
    },
    computed: {

    },



    methods: {
        get_aria_expanded(l){
            var p = this.page.parent || null;
            if (p == l.name) {
                return "true"
            }
            return l.expand.toString()
        },
        get_page_class(n){
            if (this.page.active_link == n) {
                return "nav-link active"
            }
            return "nav-link"
        },
        get_collapse_class(t){
            // todo 'collapsing'
            var p = this.page.parent || null;
            if (p == t.name) {
                return "collapse show"
            }
            if (t.expand) {
                return "collapse show"
            }
            return "collapse"
        },
        close_company() {
            this.company_show = true
            this.toggle_company()
        },
        toggle_company() {
            if (this.company_show) {
                this.company_class = "nav-item dropdown"
                this.company_class2 = "dropdown-menu dropdown-menu-right menu-dropdown menu-dropdown-width"
            } else {
                this.company_class = "nav-item dropdown show"
                this.company_class2 = "dropdown-menu dropdown-menu-right menu-dropdown menu-dropdown-width show"
            }
            this.company_show = !this.company_show
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
