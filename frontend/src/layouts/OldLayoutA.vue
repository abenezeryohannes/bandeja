<template>
    <div>
        <header class="main-header">
            <nav class="navbar navbar-static-top">
                <div class="container">
                    <div class="navbar-header">
                        <img :src="header_name2" style="height:50px;float:left;">
                        <router-link :to="{ name : 'Home' }" class="navbar-brand">
                            {{header_name1}}
                        </router-link>
                        <button type="button" v-click-outside="navbar_make_collapse" v-on:click="navbar_collapse_toggle" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse"><i class="fa fa-bars"></i></button>
                    </div>
                    <div :class="navbar_toggle_class" id="navbar-collapse">
                        <ul class="nav navbar-nav" style="height: 10">
                            <li :class="menu_link_activer('Home')">
                                <router-link :to="{ name : 'Home' }">Home</router-link>
                            </li>
                            <li v-for="l in my_main_menu" :class="menu_link_activer(l.name)">
                                <router-link :to="{ name : l.name }">{{l.label}}</router-link>
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
                            <li v-click-outside="toggle_toolbar_remove" :class="[toolbar_class, menu_link_activer('Tools')]">
                                <a v-on:click="toggle_toolbar" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                    <i class="fa fa-gears"></i>
                                    <!--                      <span class="label label-danger">9</span>-->
                                </a>
                                <ul class="dropdown-menu">
                                    <li class="header" style="text-align: center; font-weight: bold;">Tools</li>
                                    <li class="rows row" style="color:black; backgroud-color: red;">
                                        <div class="col-lg-6" style="text-align:center;">
                                            <router-link :to="{ name : 'Messages' }" class=" tool" style="color:black">
                                                <i class="fa fa-envelope-o"></i>
                                                Message
                                            </router-link>
                                        </div>
                                        <div class="col-lg-6" style="text-align:center;">
                                            <router-link :to="{ name : 'ToDo' }" class="tool" style="color:black">
                                                <i class="fa fa-th-list"></i>
                                                ToDo List
                                            </router-link>
                                        </div>
                                        <div class="col-lg-6" style="text-align:center;">
                                            <router-link :to="{ name : 'Messages' }" class="tool" style="color:black">
                                                <i class="fa fa-calculator"></i> Calculator
                                            </router-link>
                                        </div>
                                    </li>
                                    <li class="footer">
                                    </li>
                                </ul>
                            </li>
                            <!-- User Account Menu -->
                            <li :class="[ user_account_class, menu_link_activer('UserAccount') ]" v-click-outside="toggle_user_remove">
                                <!-- Menu Toggle Button -->
                                <a v-on:click="toggle_user" class="dropdown-toggle" data-toggle="dropdown" :areaExpanded="user_account_expanded">
                                    <!-- The user image in the navbar-->
                                    <img :src="user_avatar" class="user-image" alt="User">
                                    <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                    <span class="hidden-xs">{{user_name}}</span>
                                </a>
                                <ul class="dropdown-menu">
                                    <!-- The user image in the menu -->
                                    <li class="user-header">
                                        <img :src="user_avatar" class="img-circle" alt="User Image">
                                        <p>
                                            {{user_name}}
                                            <small>{{org_name}}</small>
                                        </p>
                                    </li>
                                    <!-- Menu Body -->
                                    <li class="user-body">
                                        <div class="row">
                                            <div class="col-xs-6 text-center">
                                                <router-link :to="{ name : 'MyAccount' }">My Account</router-link>
                                            </div>
                                            <div v-if="is_org_admin == true" class="col-xs-6 text-center">
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
                                        <select v-model="localee" @change="toggle_lang($event)" class="form-control">
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
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                {{page.title}}
                <small></small>
            </h1>
            <ol class="breadcrumb">
                <template v-for="(b,k) in page.breadcrumb">
                    <li v-if="k==page.breadcrumb.length-1" class="active">Plan</li>
                    <li v-else>
                        <a href="#"><i :class="'fa fa-'+b.icon"></i>{{b.label}}</a>
                    </li>
                </template>
            </ol>
        </section>
        <slot v-if="page_status == 'active'"></slot>
        <section class="content" v-else-if="page_status == 'loading'" style="text-align: center;">
            <h1><i class="fa fa-spin fa-refresh"></i> <br/>Loading ...</h1>
        </section>
    </div>
    <footer class="main-footer">
        <div class="container">
            <div class="pull-right hidden-xs">
                <b>Version</b> {{minja_version}}
            </div>
            <strong>Copyright &copy; 2020 <a href="https://minjaerp.com" target="_blank">Minja Solutions</a>.</strong> All rights
            reserved.
        </div>
    </footer>
    <a href="#" style="display: inline;position: fixed; right: 15px; bottom: 15px; z-index: 99999; ">
        <h1><i class="fa fa-arrow-circle-up"></i></h1>
    </a>
    </div>
</template>
<style>
a:hover {
    cursor: pointer;
}

.tool:hover {
    cursor: pointer;
    background-color: gray;
}

.tool {
    color: black;
    text-align: center;

    /*cursor:pointer;*/
}
</style>
<script>
import { store } from '../state/simpleState';

export default {
  props: {
    page: {
      type: Object,
      default: function () {
        return { 
          title: '',
          permission: '',
          active_link: '',
          breadcrumb : [
            { label: 'Home', icon: 'dashboard' },
          ]
        }
      }
    },
    loaded: {
      default: false
    },
    is_org_admin: {
      default: false      
    },
    // user_name: {
    //   default: 'User Name'      
    // },
    // org_name: {
    //   default: 'ORG Name'      
    // },
    // user_avatar: {
    //   default: null      
    // }
  },
    // props: [
    //     'page', 'loaded',

    //     '', 'role', 'logo', 'skin', '', '', 'locale', 'minja_app', 'is_org_admin'
    // ],
    components: {},
    data: () => ({
        page_status: 'loading',

        minja_version: null,
        localee: null,
        classNavA: 'sidebar-open',
        nav_show: true,
        lang: 'en',
        active_link: '',
        load_page: 'loading',
        permissions: [],

        navbar_collapse: false,
        navbar_toggle_class: 'collapse navbar-collapse pull-left',

        user_toggle_show: false,
        user_account_expanded: "false",
        user_account_class: "dropdown user user-menu",


        toolbar_expanded: "false",
        toolbar_class: "dropdown tasks-menu",


        qwerty: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        my_main_menu: [],

        notification_count: 0,
        message_count: 0,
        header_name2: null,
        header_name1: null,
        toolbar_is_open: true,

        search_query: null,
    }),

    events: {

    },
    watch: {
        d: {
            handler: 'checkNotification',
            immediate: true
        },
        loaded : {
            handler: 'determinePageStatus',
            immediate: true
        },
        page : {
            handler: 'determinePageStatus',
            immediate: true
        }
        // a: function (val, oldVal) {
        //   console.log('new: %s, old: %s', val, oldVal)
        //   setInterval(function () {
        //     this.checkNotification();
        //   }.bind(this), 30000); 
        // },
        // ready() {
        // this.checkNotification();
    },
    computed: {

        // langg: function () {
        //   var l = this.locale
        //   if (this.localee) {
        //     l = this.localee
        //   }
        //   return l
        // }
    },

    

    methods: {
        determinePageStatus(){
          if (this.loaded) {
            this.page_status = 'active'
          }else{
            this.page_status = 'loading'
          }
        },
        search() {
            this.$router.push({
                replace: true,
                name: 'SearchPage',
                params: { query: this.search_query }
            });
        },
        toggle_toolbar() {

            if (store.state.toolbar_opened) {
                this.toolbar_expanded = "false"
                this.toolbar_class = "dropdown tasks-menu"
            } else {
                this.toolbar_expanded = "true"
                this.toolbar_class = "dropdown tasks-menu open"
            }
            store.toggleToolbar()
        },
        toggle_open_class(t) {
            if (t == "Tools") {
                if (store.state.toolbar_opened) {
                    return "open";
                }
            }
            return "";
        },
        checkNotification() {
            setInterval(function() {
                this.$axios
                    .get('/api/notification?status=new')
                    .then(response => {
                        this.notification_count = response.data.data.count

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
        toggle_toolbar_remove(event) {
            store.state.toolbar_opened = true
            this.toggle_toolbar()
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
        tell_active(ac) {
            this.active_link = ac
            // ToDo scroll up
            window.scrollTo(0, 0)
        },
        check_permission(per, scope = null) {
            if (scope == 'module') {
                for (var i = 0; i < this.permissions.length; i++) {
                    if (this.permissions[i].substr(0, per.length) == per) {
                        return 'granted'
                    }
                }
            } else {
                for (var i = 0; i < this.permissions.length; i++) {
                    if (this.permissions[i] == per) {
                        return 'granted'
                    }
                }
            }
            var status = 'loading'
            status = true
            this.load_page = status
        },
        toggle_nav() {
            if (this.nav_show) {
                this.classNavA = 'sidebar-collapse';
            } else {
                this.classNavA = 'sidebar-open'
            }
            this.nav_show = !this.nav_show;
        },

        toggle_lang(event) {
            const la = event.target.value
            window.lang.getInstance().change(la)
            // console.log(window.lang)
            // console.log(this.)
            // if (this.localee != la) {
            this.localee = la;
            const config = {
                headers: {
                    'content-type': 'multipart/form-data',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                }
            }
            let formData = new FormData();
            formData.append('locale', event.target.value)
            this.$axios.post('/api/usermgt/setting/locale', formData, config)
                .then(response => {
                    this.get_myself_info()
                }).catch(error => {
                    if (error.response.status === 422) {
                        this.errors = error.response.data.errors || {};
                    }
                });
            // }
        },
        get_myself_info() {
            this.$axios
                .get('/api/minja/boot')
                .then(response => {
                    this.permissions = response.data.data.permissions
                    this.my_main_menu = response.data.data.main_menu
                    this.header_name1 = response.data.data.header_name1
                    this.header_name2 = response.data.data.header_name2
                    this.minja_version = response.data.data.version

                    // store.setPermissions(this.permissions)
                })
                .catch(error => {
                    this.load_page = 'error';
                    // reject();
                })
        },
    },

    created() {
        this.get_myself_info()
        this.localee = this.locale
        if (typeof this.pre_page_process !== 'undefined') {
            this.pre_page_process()
        }
    },
    updated() {
        this.active_link = this.page.active_link
        console.log(this.page.active_link)
    },
};
</script>