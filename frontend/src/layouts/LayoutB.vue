<template>
    <div>
        <sidebar-b :header_info="{
            'main_menu': main_menu,
            'user_info': user_info,
            'home_img': home_img,
            'locale': locale
        }" :page="page" :boot_the_app="boot_the_app" />
        <div class="main-content" id="panel">
            <navbar-b :header_info="{
                    'main_menu': main_menu,
                    'user_info': user_info,
                    'home_img': home_img,
                    'locale': locale
                }" :page="page" :boot_the_app="boot_the_app" />
            <div id="main-body">
                <header-b  :page="page">
                </header-b> 
                <div class="container-fluid content-layout mt--6">
                    <div id="app">                    
                        <slot v-if="page_status_code == '1'" ></slot>
                        <div v-else-if="page_status_code == 401" >Unauthorized</div>
                        <div v-else >Loading ...</div>
                    </div>
                    <footer class="footer">
                        <div class="row">
                            <div class="col-xs-12 col-sm-6">
                                <div class="text-sm float-left text-muted footer-texts">
                                    <a :href="developer_link" target="_blank" class="text-muted">{{developer_name}}</a></div>
                            </div>
                            <div class="col-xs-12 col-sm-6">
                                <div class="text-sm float-right text-muted footer-texts">
                                    Version {{sys_version}}
                                </div>
                            </div>
                        </div>
                    </footer>
                </div>
            </div>
        </div>
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

import SidebarB from './SidebarB'
import HeaderB from './HeaderB'
import NavbarB from './NavbarB'

export default {
    props: {
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
        page_status_code: {
            default: 0
        },
        loaded: {
            default: false
        },
    },
    components: {
        HeaderB,
        SidebarB,
        NavbarB
    },
    data: () => ({
        page_status: 'loading',

        main_menu: [],
        sys_version: null,
        main_menu_header: null,
        home_img: null,
        developer_link: 'https://minjaerp.com',
        copyright_text: 'Copyright &copy; 2020',
        developer_name: 'Minja Solutions',
        all_rights: 'All rights reserved.',

        user_info: {

        },
        locale: null,

        see_more_class: 'dropdown',





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
        // d: {
        //     handler: 'checkNotification',
        //     immediate: true
        // },
        page_status_code: {
            handler: 'determinePageStatus',
            immediate: true
        },
    },
    computed: {

    },



    methods: {
        determinePageStatus() {
            // console.log("layout status"+ this.page_status_code)
            switch (this.page_status_code) {
                case "1":
                    this.page_status = "active";
                    break;
                case 401:
                    this.page_status = "unauthorized";
                    break;
                default:
                    this.page_status = "loading";
                    break;
            }
            // console.log(this.page_status)
        },


        boot_the_app() {
            this.$axios
                .get('/api/v1/boot')
                .then(response => {
                    store.state.boot_info = response.data
                    store.state.loaded = true
                    this.boot_from_state()
                })
                .catch(error => {
                    this.load_page = 'error';
                    // reject();
                })
        },

        boot_from_state() {
            this.main_menu = store.state.boot_info.main_menu
            this.sys_version = store.state.boot_info.version
            this.home_img = store.state.boot_info.home_img
            this.developer_link = store.state.boot_info.developer.link
            this.developer_name = store.state.boot_info.developer.name
            this.copyright_text = store.state.boot_info.copyright.text
            this.all_rights = store.state.boot_info.copyright.all_rights
            this.main_menu_header = store.state.boot_info.main_menu_header
            this.user_info = store.state.boot_info.user
            this.locale = store.state.boot_info.user.locale
        },

    },

    mounted() {
        if (!store.state.loaded) {
            this.boot_the_app()
        } else {
            this.boot_from_state()
        }
    },
    updated() {},
};

</script>
