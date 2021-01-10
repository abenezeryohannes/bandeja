<template>
    <div>
        <header-a :header_info="{
            'main_menu': main_menu,
            'user_info': user_info,
            'home_img': home_img,
            'locale': locale
        }" :page="page" :boot_the_app="boot_the_app" />
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                {{page.title}}
                <small></small>
            </h1>
            <ol class="breadcrumb">
                <template v-for="(b,k) in page.breadcrumb">
                    <li v-if="k==page.breadcrumb.length-1" class="active">{{b.label}}</li>
                    <li v-else>
                        <a href="#"><i :class="'fa fa-'+b.icon"></i>{{b.label}}</a>
                    </li>
                </template>
            </ol>
        </section>
        <slot v-if="page_status == 'active'"></slot>
        <section class="content" v-else-if="page_status == 'loading'" style="text-align: center;">
            <h1><i class="fa fa-spin fa-refresh"></i> <br />Loading ...</h1>
        </section>
        <section class="content" v-else-if="page_status == 'unauthorized'" style="text-align: center;">
            <h1><i class="fa fa-close"></i> <br />Unauthorized!</h1>
        </section>
    </div>
    <footer class="main-footer">
        <div class="container">
            <div class="pull-right hidden-xs">
                <b>Version</b> {{sys_version}}
            </div>
            <strong v-html="copyright_text"> </strong><strong> <a :href="developer_link" target="_blank"> {{developer_name}}</a>.</strong> {{all_rights}}
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

import HeaderA from './HeaderA'

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
        HeaderA
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
            switch(this.page_status_code){
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
        }else{
            this.boot_from_state()
        }
    },
    updated() {
    },
};

</script>
