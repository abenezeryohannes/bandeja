export default {
    data: function() {
        return {

            active_tab: "1",
            page_info: {

            },
            error_page_info: {

            },
            api: null,
            page_status_code: 0
        }
    },
    mounted: function() {
        this.get_page_info()
    },
    watch: {
        api: 'get_page_info'
    },
    methods: {
        change_active_tab(t) {
            this.active_tab = t
        },
        active_class_link(l) {
            if (this.active_tab == l) {
                return "active"
            }
            return ""
        },

        get_page_info() {
            if (!this.api) {
                return ;
            }
            console.log("PAGE API = " + this.api)
            // var self = this
            this.$axios
                .get(this.api)
                .then(response => {
                    // console.log("PAGE SUCCESS CODE = 1")
                    this.page_info = response.data
                    if (typeof this.set_strings != "undefined") {
                    	this.set_strings()
                    }
                    this.page_status_code = "1"
                })
                .catch(error => {

                    console.log(this.api)
                    console.log("PAGE ERROR CODE = " + error.response.status)
                    this.page_status_code = error.response.status
                    this.error_page_info = error.response.data
                    // if (error.response.status == "302") {
                    //     window.location.replace(error.response.data.to);
                    // }
                    // if (error.response.status == "401") {
                    //     alert("You are not authorized");
                    // }
                    // console.log(error)
                    // 
                    // this.errored = true
                })
            // .finally(() => this.loading = false)
        },
    }
}
