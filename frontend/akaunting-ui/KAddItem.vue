<template>
    <div class="box box-info">
        <div class="box-header">
            <i v-if="kadd_icon" :class="kadd_icon"></i>
            <h3 class="box-title">{{kadd_title}}</h3>
        </div>
        <div class="box-body">
            <div class="form-horizontal">
                <div class="form-group" v-for="field_group in kfield_groups">
                    <label class="col-sm-2 control-label">{{field_group.name}}</label>
                    <div class="col-sm-10 row">
                        <div v-for="f in field_group.fields" :class="f.col">
                            {{f.name}} <sup v-if="f.required" style="font-weight: bolder; color: red">*</sup>
                            <input v-if="f.type == 'text'" v-model="fields[f.key]" type="text" class="form-control" :placeholder="f.placeholder" />
                            <input v-else-if="f.type == 'picture'" type="file" v-on:change="onFileChange($event, f)" class="form-control" />
                            <input v-else-if="f.type == 'number'" v-model="fields[f.key]" type="number" :step="f.step" class="form-control" />
                            <textarea v-else-if="f.type == 'textarea'" v-model="fields[f.key]" rows="6" class="form-control"></textarea>
                            <select v-else-if="f.type == 'select'" v-model="fields[f.key]" class="form-control">
                                <option v-for="o in f.options" :value="o.code">{{o.label}}</option>
                            </select>
                            <v-select v-else-if="f.type == 'vselect-b'" v-model="fields[f.key]" :options="form_data[f.options]"></v-select>
                            <v-select v-else-if="f.type == 'vselect-c'" multiple v-model="fields[f.key]" :options="form_data[f.options]"></v-select>

                            <p v-if="errors && errors[f.key]" class="text-danger">{{ errors[f.key][0] }}</p>
                            <p v-else-if="errors" class="text-danger"><br></p>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button v-if="can_add" v-on:click="submit_form_r" class="pull-right btn btn-primary">{{kbutton_text[0]}} <i class="fa fa-arrow-circle-right"></i></button> &nbsp;
                        <button v-if="can_add && kbutton_text[1]" v-on:click="submit_form" class="pull-right btn btn-primary">{{kbutton_text[1]}} <i class="fa fa-arrow-circle-right"></i></button>
                        <button v-if="!can_add" class="pull-right btn btn-primary">
                            {{kbutton_text[2]}} <i class="fa fa-refresh fa-spin"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
// import Select2 from 'v-select2-component';

export default {
    // components: { Select2 },

    props: [
        'kadd_title', 'kadd_icon', 'kfield_groups', 'kadd_api', 'kbutton_text', 'kdata_dont_load', 'kevent_added'
    ],

    data() {
        return {
            fields: {},
            errors: null,
            form_data: {},

            can_add: true,
            load_page: true,
            data_loaded: false,
        }
    },

    mounted() {
        if (!this.kdata_dont_load) {
            this.fill_page_data()
        }

    },

    beforeUpdate() {
        if (!this.data_loaded) {
            // this.fill_page_data()
        }
    },

    methods: {
        onFileChange(e, f) {
            this.fields[f.key] = e.target.files[0]
        },
        fill_page_data() {
            this.$axios
                .get(this.kadd_api + 'create')
                .then(response => {
                    this.form_data = response.data.data
                    this.data_loaded = true;
                })
                .catch(error => {
                    // this.load_page = 'error';
                })
        },
        submit_form_r() {
            this.submit_form()
        },
        submit_form() {
            this.errors = null;
            this.can_add = false
            const config = {
                headers: {
                    'content-type': 'multipart/form-data',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                }
            }
            let formData = new FormData();
            let this_fields = this.fields
            this.kfield_groups.forEach(function(kfield_group) {
                kfield_group.fields.forEach(function(f) {
                    if (this_fields[f.key]) {
                        if (f.type == 'vselect-b') {
                            formData.append(f.key, this_fields[f.key].code)
                        }else if (f.type == 'vselect-c') {
                            formData.append(f.key, this_fields[f.key].map(f => f.code).join("|") )
                        } else {
                            formData.append(f.key, this_fields[f.key])
                        }
                    }
                })
            })

            this.$axios.post(this.kadd_api , formData, config)
            // this.$axios.post(this.kadd_api + 'store', formData, config)
                .then(response => {
                    this.$swal({
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 3000,
                        onOpen: (toast) => {
                            toast.addEventListener('mouseenter', Swal.stopTimer)
                            toast.addEventListener('mouseleave', Swal.resumeTimer)
                        },
                        icon: 'success',
                        title: response.data.toast,
                    })

                    this.fields = {}
                    if(this.kevent_added){
                        this.kevent_added()
                    }
                }).catch(error => {
                    if (error.response.status === 422) {
                        this.errors = error.response.data.errors || {};
                    } else {
                        this.$swal({
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,
                            onOpen: (toast) => {
                                toast.addEventListener('mouseenter', Swal.stopTimer)
                                toast.addEventListener('mouseleave', Swal.resumeTimer)
                            },
                            icon: 'error',
                            title: 'Something wrong occured!',
                        })
                    }
                }).finally(() => this.can_add = true);

        },

    }


}
</script>