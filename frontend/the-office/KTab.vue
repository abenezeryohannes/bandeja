<template>
    <div class="nav-tabs-custom">
        <ul class="nav nav-tabs" style="background-color: #ecf0f5">
            <li v-for="i in the_total" :class="active_class_link(i)"><a v-on:click="change_active_tab(i)"><slot :name="'title'+i"></slot></a></li>
        </ul>
        <div class="tab-content">
            <div class="active tab-pane">
                <div v-for="i in the_total" v-if="active_tab == i" class="post"><slot :name="'body'+i"></slot></div>


                <div v-for="i in the_extras" v-if="active_tab == 'extra'+i" class="post"><slot :name="'extra'+i"></slot></div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "KTab",
        props: ["total",'active', 'extra','active_changed'],
        data() {
            return {
                the_total: 1,
                the_extras: 0,
                active_tab: "1",
            }
        },
        watch : {
            active: 'mount_active',
            active_tab : 'notify_up'
        },
        methods : {
            notify_up(){
              if(this.active_changed)
                  this.active_changed(this.active_tab)
            },
            active_class_link(l) {
                if (this.active_tab == l) {
                    return "active"
                }
                return ""
            },
            change_active_tab(t) {
                this.active_tab = t
            },

            mount_active(){
                console.log(this.active)
                if(this.active){
                    this.active_tab = this.active
                }
            }
        },
        mounted(){
            if(this.total){
                this.the_total = Number(this.total)
            }
            this.mount_active()
            if(this.extra){
                this.the_extras = Number(this.extra)
            }
        }
    }
</script>

<style scoped>

</style>