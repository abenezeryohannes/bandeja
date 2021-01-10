<template>
    <div>
        <div class="box box-info">
            <div class="box-header" v-if="ktitle">
                <i v-if="kicon" :class="kicon"></i>
                <h3 class="box-title">{{ktitle}}</h3>
            </div>
            <div class="box-body">
              <div v-if="api_load" class="form-horizontal">
                Loading ...
              </div>
                <div v-else class="form-horizontal">
                    <div class="form-group" v-for="field_group in kfield_groups">
                        <label class="col-sm-2 control-label">{{field_group.name}}</label>
                        <div class="col-sm-10 row">
                            <div v-for="f in field_group.fields" :class="f.col">
                                {{f.name}} <sup v-if="f.required" style="font-weight: bolder; color: red">*</sup>
                                <i v-if="f.type!='viewonly' && being_edited.key==f.key && updating!=f.key" v-on:click="cancel_edit(f)" class="fa fa-close" style="float: right; cursor: pointer; color: red;"></i>
                                <i v-if="f.type!='viewonly' && being_edited.key==f.key  && updating!=f.key" v-on:click="update()" class="fa fa-check" style="float: right; cursor: pointer; color: green;"></i>
                                <i v-else-if="f.type!='viewonly' && updating==f.key" class="fa fa-refresh fa-spin" style="float: right;"></i>
                                <i v-else-if="f.type!='viewonly'" v-on:click="edit(f)" class="fa fa-edit" style="float: right; cursor: pointer;"></i>

                                <input v-if="f.type == 'text' && being_edited.key==f.key " v-model="fields[f.key]" type="text" class="form-control" :placeholder="f.placeholder" v-on:keyup.enter="update" />
                                <input v-else-if="f.type == 'text'" v-model="fields[f.key]" type="text" class="form-control" :placeholder="f.placeholder" readonly />
                                <input v-else-if="f.type == 'number' && being_edited.key==f.key " v-model="fields[f.key]" type="number" :step="f.step" class="form-control" v-on:keyup.enter="update" />
                                <input v-else-if="f.type == 'number'" v-model="fields[f.key]" type="number" :step="f.step" class="form-control" readonly />
                                <input v-else-if="f.type == 'picture'" type="file" v-on:change="onFileChange($event, f)" class="form-control" />
                                <textarea v-else-if="f.type == 'textarea'" v-model="fields[f.key]" rows="6" class="form-control"></textarea>

                                <select v-else-if="f.type == 'select' && being_edited.key==f.key" v-model="fields[f.key]" class="form-control">
                                    <option v-for="o in f.options" :value="o.code">{{o.label}}</option>
                                </select>
                                <input v-else-if="f.type == 'select'" type="text" v-model="fields[f.key]" class="form-control" readonly>
                                <v-select v-else-if="f.type == 'vselect-b' && being_edited.key==f.key" v-model="fields[f.key]" v-on:change="update()" :options="form_data[f.options]" :clearable="false"></v-select>
                                <input v-else-if="f.type == 'vselect-b'" v-model="fields[f.key]" type="text" class="form-control" readonly />
                                <input v-else-if="f.type == 'viewonly'" v-model="fields[f.key]" type="text" class="form-control"  readonly />

                                <p v-if="errors && errors[f.key]" class="text-danger">{{ errors[f.key][0] }}</p>
                                <p v-else-if="errors" class="text-danger"><br></p>
                            </div>
                        </div>
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
        'ksource',
        'ktitle', 'kicon',
        'kfield_groups',
        'kapi', 'kform_data',
        'kdata_dont_load'
    ],

    data() {
        return {
          api_load: false,
            fields: {},
            errors: null,
            form_data: {},
            updating: false,

            can_add: true,
            load_page: true,
            data_loaded: false,

            being_edited: {},
            being_edited_original: null,
        }
    },

    mounted() {
        this.boot()
    },

    watch: {
        kform_data : 'boot',
        ksource: 'boot'
    },

    beforeUpdate() {
        if (!this.data_loaded) {
            // this.fill_page_data()
        }
    },

    methods: {
        boot(){
            if (this.ksource == 'api') {
                this.fill_page_data()
            } else {
                this.fields = this.ksource
                this.form_data = this.kform_data
            }
        },
        cancel_edit(f) {
            this.being_edited = {}
            this.fields[f.key] = this.being_edited_original
        },
        update() {
            this.updatee()
        },
        updatee() {
            this.updating = this.being_edited.key
            this.errors = null
            const config = {
                headers: {
                    'content-type': 'multipart/form-data',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                }
            }
            let formData = new FormData();
            let updatable = this.fields
            formData.append('id', this.fields.id)
            formData.append('updatable', this.being_edited.key)
            var updatableValue = this.fields[this.being_edited.key]
            if (this.being_edited.type == 'vselect-b') {
                updatableValue = this.fields[this.being_edited.key].code
                var options = this.form_data[this.being_edited.options]
                for(var i =0; i<options.length; i++){
                    if(options[i].code == updatableValue){
                        this.fields[this.being_edited.key] = options[i].label
                    }
                }
            }
            formData.append('updatable_value', updatableValue)
            formData.append('_method', "put")

            this.$axios.post(this.kapi +this.fields.id, formData, config)
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
                        title: this.being_edited.key + ' updated!',
                    })
                    if (this.being_edited.type == 'vselect-b') {
                        this.fields[this.being_edited.key] = this.fields[this.being_edited.key].label
                    }
                    this.errors = null
                    this.being_edited = {}
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
                }).finally(() => {
                    this.updating = false
                });


        },
        edit(f) {
            if (this.being_edited && this.being_edited.key) {
                this.updatee()
            }
            this.being_edited = f
            this.being_edited_original = this.fields[f.key]
        },
        onFileChange(e, f) {
            this.fields[f.key] = e.target.files[0]
        },
        fill_page_data() {
          this.api_load = true
            this.$axios
                .get(this.kadd_api + 'create')
                .then(response => {
                    this.form_data = response.data.data
                    this.data_loaded = true;
                  this.api_load = false
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
                        } else {
                            formData.append(f.key, this_fields[f.key])
                        }
                    }
                })
            })

            this.$axios.post(this.kadd_api + 'store', formData, config)
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