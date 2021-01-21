<template>
    <div id="header" class="header pb-6">
        <div class="container-fluid content-layout">
            <div class="header-body">
                <div class="row py-4 align-items-center">
                    <div class="col-xs-12 col-sm-4 col-md-5 align-items-center">
                        <h2 class="d-inline-flex mb-0 long-texts">{{page.title }}</h2> 
                        <slot name="left"></slot>

                    </div>
                    <div class="col-xs-12 col-sm-8 col-md-7">
                        <div class="text-right">
<!--                             <span><a  class="btn btn-white btn-sm header-button-top"><span class="fa fa-plus"></span> &nbsp;Add ssss</a></span>
                            <span><a  class="btn btn-success btn-sm header-button-top" style="color: white;"><span class="fa fa-plus"></span> &nbsp;Add ssss</a></span> -->

                        	<slot name="buttons-panel"></slot>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
        // d: {
        //     handler: 'checkNotification',
        //     immediate: true
        // },
        // header_info: 'set_data'
    },
    computed: {

    },
}

</script>