<template>
    <header class="main-header">
        <nav class="navbar navbar-static-top">
            <div class="container">
                <div class="navbar-header">
                    <img :src="home_img" style="height:50px;float:left;">
                    <router-link :to="{ name : 'Home' }" class="navbar-brand">
                        {{main_menu_header}}
                    </router-link>
                    <button type="button" v-click-outside="navbar_make_collapse" v-on:click="navbar_collapse_toggle" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse"><i class="fa fa-bars"></i></button>
                </div>
                <div :class="navbar_toggle_class" id="navbar-collapse">
                    <ul class="nav navbar-nav" style="height: 10">
                        <!-- <li :class="menu_link_activer('Home')">
                                <router-link :to="{ name : 'Home' }">Home</router-link>
                            </li> -->
                        <li v-for="l in main_menu.slice(0, 4)" :class="menu_link_activer(l.name)">
                            <router-link :to="{ name : l.name }">{{l.label}}</router-link>
                        </li>
                        <li v-click-outside="close_see_more" :class="see_more_class">
                            <a v-on:click="open_see_more" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">More .. <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li v-for="l in main_menu.slice(4)" :class="menu_link_activer(l.name)">
                                    <router-link :to="{ name : l.name }">{{l.label}}</router-link>
                                </li>
                                <li v-if="main_menu.slice(4).length" class="divider"></li>
                                <li>
                                    <router-link :to="{ name : 'Messages' }"><i class="fa fa-envelope-o"></i>Message</router-link>
                                </li>
                                <li>
                                    <router-link :to="{ name : 'ToDo' }"><i class="fa fa-th-list"></i>To do list</router-link>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <div class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input v-on:keyup.enter="search" type="text" v-model="search_query" class="form-control" id="navbar-search-input" placeholder="Search">
                            <!--            <span class="input-group-btn">-->
                            <button v-on:click="search" type="submit" name="search" id="search-btn" class="btn btn-sm">
                                <i class="fa fa-search"></i>
                            </button>
                            <!--            </span>-->
                        </div>
                    </div>
                </div>
                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <li :class="[ 'dropdown' , 'messages-menu', menu_link_activer('Notifications')  ]">
                            <router-link :to="{ name : 'Notifications' }" class="dropdown-toggle">
                                <i class="fa fa-bell-o"></i>
                                <span v-if="notification_count" class="label label-warning">{{notification_count}}</span>
                            </router-link>
                        </li>
                        <!-- User Account Menu -->
                        <li :class="[ user_account_class, menu_link_activer('UserAccount') ]" v-click-outside="toggle_user_remove">
                            <!-- Menu Toggle Button -->
                            <a v-on:click="toggle_user" class="dropdown-toggle" data-toggle="dropdown" :areaExpanded="user_account_expanded">
                                <!-- The user image in the navbar-->
                                <img :src="user_info.pp" class="user-image" alt="User">
                                <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                <span class="hidden-xs">{{user_info.name}}</span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- The user image in the menu -->
                                <li class="user-header">
                                    <img :src="user_info.pp" class="img-circle" alt="User Image">
                                    <p>
                                        {{user_info.name}}
                                        <small>{{user_info.org}}</small>
                                    </p>
                                </li>
                                <!-- Menu Body -->
                                <li class="user-body">
                                    <div class="row">
                                        <div class="col-xs-6 text-center">
                                            <router-link :to="{ name : 'MyAccount' }">My Account</router-link>
                                        </div>
                                        <div v-if="user_info.role == 'admin'" class="col-xs-6 text-center">
                                            <router-link :to="{ name : 'AdminCenter' }">Admin Center</router-link>
                                        </div>
                                    </div>
                                    <!-- /.row -->
                                </li>
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="pull-left">
                                        <!-- <a href="#" class="btn btn-default btn-flat">Profile</a> -->
                                        <li class="dropdown tasks-menu">
                                            <select v-model="locale" @change="toggle_lang($event)" class="form-control">
                                                <option value="am">Amharic</option>
                                                <option value="en">English</option>
                                                <!-- <option value="sd">Sidamic</option> -->
                                            </select>
                                        </li>
                                    </div>
                                    <div class="pull-right">
                                        <a href="/logout" class="btn btn-default btn-flat">Log out</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
</template>
<style>
</style>
<script>
import { store } from '../state/simpleState';

export default {
    props: {
        boot_the_app: {

        },
        header_info: {
            default: function() {
                return {
                }
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
        set_data(){
            this.main_menu  = this.header_info.main_menu
            this.user_info  = this.header_info.user_info
            this.home_img  = this.header_info.home_img
            this.locale  = this.header_info.locale
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
