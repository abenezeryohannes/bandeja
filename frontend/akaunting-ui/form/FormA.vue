<template>
    <div class="card">
            <div role="form" class="form-loading-button">
                <div class="card-body">
                    <div class="row">
                        <template v-for="f in fields">                        
                            <template v-if="f.type == 'input'">                            
                                <ak-input  :label="f.label" :icon="f.icon" v-model="models[f.name]" :type="f.input_type" required="required" :column="f.column"  :error_msg="[errors,f.name]" />
                            </template>                        
                            <template v-else-if="f.type == 'select'">
                                <ak-select  :label="f.label" :icon="f.icon" v-model="models[f.name]"  :column="f.column"  :options="f.options"  :error_msg="[errors,f.name]" />
                            </template>
                            <template v-else-if="f.type == 'file'">
                                <ak-file  :label="f.label" :icon="f.icon" v-model="models[f.name]"  :column="f.column"  :error_msg="[errors,f.name]" />
                            </template>
                            <template v-else-if="f.type == 'switcher'">
                                <ak-switcher v-model="models[f.name]" :multiple="f.multiple" :label="f.label" :options="f.options" :default="f.default" />
                            </template>                        
                            <template v-else-if="f.type == 'textarea'">
                                <ak-textarea  :label="f.label" :icon="f.icon" v-model="models[f.name]"  :column="f.column"  :options="f.options"  :error_msg="[errors,f.name]" />
                            </template>                        
                            <template v-else-if="f.type == 'blank'">
                                <ak-blank :column="f.column" />
                            </template>                        
                            <template v-else-if="f.type == 'custom'">
                                <slot :name="f.name"></slot>
                            </template>

                        </template>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row save-buttons">
                        <div class="col-md-12">
                            <button v-on:click="cancel" class="btn btn-icon btn-outline-secondary header-button-top">
                                <span class="btn-inner--icon"><i class="fas fa-times"></i></span> 
                                <span class="btn-inner--text">{{strings.cancel}}</span>
                            </button>
                            <button v-on:click="save" class="btn btn-icon btn-success button-submit header-button-top" :disabled="loading == 1">
                                <div v-if="loading" class="aka-loader"></div>
                                <span class="btn-inner--icon"><i class="fas fa-save"></i></span>
                                <span class="btn-inner--text">{{strings.save}}</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</template>
<script>
export default {
    props: ["boot_api","boot_data", "action_api","method","return_url","extra_models","form_watcher"],
    data() {
        return {
            loading: 0,
            file_name: 'select file',
            img_preview: null,
            errors: null,
            name: null,

            strings: {},
            fields: [],

            models: {

            }
        }
    },
    watch: {
        models: 'model_watcher',
        // active_tab : 'notify_up'
    },
    methods: {
        model_watcher(){
            console.log('change')
            if (this.form_watcher) {
                this.form_watcher(this.model)
            }
        },
        cancel(){
            this.$router.push({ name: this.return_url.name })
        },
        save(){
            this.errors = null
            let formData = new FormData();
            this.loading = 1
            formData.append('_method', this.method)
            for (var i = this.fields.length - 1; i >= 0; i--) {
                var field = this.fields[i]
                var v = this.models[field.name]
                if (v) {
                    formData.append(field.name, v)
                }
            }
            if (this.boot_data.form && this.boot_data.form.extra_fields && this.boot_data.form.extra_fields.fields) {
                for (var i = this.boot_data.form.extra_fields.fields.length - 1; i >= 0; i--) {
                    var v = this.boot_data.form.extra_fields.fields[i]
                    var vv = this.extra_models[v]
                    if (vv) {
                        formData.append(v, vv)
                    }
                }
            }else{
                console.log(this.boot_data)
            }

            const config = {
                headers: {
                    'content-type': 'multipart/form-data',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                }
            }
            this.$axios.post(this.action_api, formData, config)
                .then(response => {
                    this.$router.push({ name: this.return_url.name })
                }).catch(error => {
                    if (error.response.status == 422) {
                        this.errors = error.response.data.errors
                    }
                }).finally( ()=>{
                    this.loading = 0
                });
        },

        onUpload(event){
            var file = event.target.files[0]
            this.file_name = file.name
            if (
                file.type == 'image/jpeg' &&
                file.type == 'image/png'
            ) {
                this.img_preview = URL.createObjectURL(file)
            }
            // console.log(file)
        },

        boot_from_source(){
            this.fields = this.boot_data.form.fields
            this.strings = this.boot_data.form.strings
            for (var i = this.fields.length - 1; i >= 0; i--) {
                var field = this.fields[i]
                this.models[field.name] = field.default
            }

        },

        boot_from_api(){

        },

        boot(){
            if (this.boot_data) {
                this.boot_from_source()
            }else{
                this.boot_from_api()
            }
        }
    },
    mounted() {
        this.boot()
    }
}

</script>
<style scoped>
</style>
