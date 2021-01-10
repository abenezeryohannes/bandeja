 <template>

    <layout-a :page="page_meta" :loaded="loaded" :page_status_code="page_status_code">
        <section class="content" >
            <div v-if="modal_show" v-click-outside="modal_remove" class="modal modal-info fade in" id="modal-info" style="display: block; padding-right: 15px;">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button v-on:click="modal_remove" type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">×</span></button>
                    <h4 class="modal-title">Id Card</h4>
                  </div>
                  <div class="modal-body">
                    <img :src="generate_id" class="img-responsive img-fluid">
                  </div>
                  <div class="modal-footer">
                    <button v-on:click="modal_remove" type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>
                    <a :href="download_id" type="button" class="btn btn-outline">Download Image</a>
                  </div>
                </div>
                <!-- /.modal-content -->
              </div>
              <!-- /.modal-dialog -->
            </div>
            <div class="row" >
                <div class="col-md-2">
                    <div class="box box-primary" v-if="page_info.user">
                        <avatar-mgt :url="page_info.user.pp">
                            <h3 class="profile-username text-center">{{page_info.user.name}}</h3>
                            <p class="text-muted text-center">{{employee.org}}</p>
                        </avatar-mgt>
                    </div>

                        <several-actions class="box" style="background-color: white; float: right" btnType="btn-primary">
                            <i class="fa fa-users"></i> Actions 
                            <template slot="list">
                                <li><a v-on:click="reset_pwd">Reset Password</a></li>
<!--                                <li><a v-on:click="generate_idcard">Generate ID card</a></li>-->
                            </template>
                        </several-actions>

                </div>
                <div class="col-md-10">
                    <k-tab total="5">
                        <template slot="title1">Basic Info</template>
                        <div slot="body1" v-if="page_info.user">
                            <k-view-edit
                                    :kapi="kview.api"
                                    :ksource="page_info.user"
                                    :kform_data="kview.form_data"
                                    :kfield_groups="kview.field_groups"
                            />
                        </div>


                        <template slot="title2">Payroll History</template>
                        <div slot="body2">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Salaries</label>
                                    <div class="col-sm-10 row">



                                        <table id="example2" class="table table-bordered table-hover dataTable" role="grid" aria-describedby="example2_info">
                                            <thead>
                                            <tr role="row">
                                                <th class="sorting_asc" tabindex="0" aria-controls="example2" rowspan="2" colspan="1" aria-sort="ascending" >Time</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="4" style="text-align: center;" >ገቢ</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="4" style="text-align: center;" >ተቀናናሽ ወጪ</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="2" colspan="1" >ጡረታከድርጅቱ</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="2" colspan="1" >ጠቅላላ ተቀናሽ</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="2" colspan="1" >የተጣራ ክፍያ</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="2" colspan="1" >Remark</th>
                                            </tr>
                                            <tr role="row">
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" >Salary</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" >ትራንስፖርት አሎዋንስ</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" >ሀውስ አሎዋንስ</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" >ጠቅላላ ድምር</th>

                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" >የስራ ግብር</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" >የብድር ተቀናሽ</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" >ጡረታ ከሰራተኛው</th>
                                                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" >ቅጣት</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr  role="row" v-for="e, x in employee.salaries" :class="evenodd(x)">
                                                <td class="sorting_1"  style="font-weight: bold;">{{ e.year }} -{{ e.month }}</td>
                                                <td>{{e.salary}}</td>
                                                <td>{{e.plus.transport}}</td>
                                                <td>{{e.plus.house}}</td>
                                                <td>{{e.plus.total_income}}</td>

                                                <td>{{e.minus.tax}}</td>
                                                <td>{{e.minus.loan}}</td>
                                                <td>{{e.minus.retirement}}</td>
                                                <td>{{e.minus.punishment}}</td>

                                                <td>{{e.other.retirement_by_org}}</td>
                                                <td>{{e.minus.total_minus}}</td>
                                                <td>{{e.net_pay}}</td>
                                                <td>{{e.remark}}</td>
                                            </tr>
                                            </tbody>
                                        </table>


                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <a v-on:click="change_pw" class="btn btn-primary">Update</a>
                                    </div>
                                </div>
                            </form>
                        </div>


                        <template slot="title3">Attendance</template>
                        <div slot="body3">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Day</label>
                                    <div class="col-sm-10 row" style="text-align: center;">
                                        <div class="col-md-4">
                                            Morning
                                        </div>
                                        <div class="col-md-4">
                                            Afternoon
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" v-for="e in employee.attendances">
                                    <label for="inputName" style="font-weight: bold;" class="col-sm-2 control-label">{{e.attendance_date}}</label>
                                    <div class="col-sm-10 row" style="text-align: center; font-weight: bold; color: white;">
                                        <div style="background-color: green" class="col-md-4" v-if="e.shift_1">
                                            Present
                                        </div>
                                        <div style="background-color: red" class="col-md-4" v-else>
                                            Absent
                                        </div>

                                        <div style="background-color: green" class="col-md-4" v-if="e.shift_2">
                                            Present
                                        </div>
                                        <div style="background-color: red" class="col-md-4" v-else>
                                            Absent
                                        </div>

                                    </div>
                                </div>
                            </form>
                        </div>


                        <template slot="title4">Activity Log</template>
                        <div slot="body4">

                        </div>


                        <template slot="title5">Note</template>
                        <div slot="body5">
                            <single-employee-notes :employee="employee" />
                        </div>
                    </k-tab>

                </div>
            </div>
        </section>
    </layout-a>
</template>
<script>
    
  // import SingleEmployeeNotes from '../business-cloud/components/pages/HR/HREmployeeSingleNotes'
    // import SeveralActions from "./low/SeveralActions";
  // import KTab from "./low/KTab";
  // import AvatarMgt from "./low/AvatarMgt";

import pageLoader from "../../mixins/PageLoader"

import HrOverview from "./HrOverview"
import JobPosition from "./JobPosition"
import AddEmployee from "./AddEmployee"
export default {

    props: ['check_permission', 'load_page', 'tell_active', 'user_avatar', 'user_name'],
    mixins: [pageLoader],

    components: {
        HrOverview,
        JobPosition,
        AddEmployee
    },
    // components: {
        // SingleEmployeeNotes,
        // SeveralActions,
        // KTab,
        // AvatarMgt
      // },

    data() {
        return {
            loaded: false,
            page_meta: {
                title: 'Single Employee',
                permission: 'hr',
                active_link: 'HR',
                breadcrumb: [
                    { label: 'Home', icon: 'dashboard' },
                    { label: 'HR', icon: 'person' },
                    { label: 'Employee', icon: '' },
                ]
            },


            api: '/api/v1/hr/employee/'+this.$route.params.id,

            img_status: 'a',
            the_image_url: null,
            the_image: null,

            generate_idcard_label : "Generate ID Card",
            modal_show: false,
            download_id: null,
          employee: {},
            permission: 'setting.org',
            loading: true,

            logo_url: null,
            user: {
                name: null,
                pic: null,
            },
            org: {
                name: null,
                logo_url: null,
                update_class: 'btn btn-default'
            },
            org_errors: {},

            active_tab: "basic_info",
            password2: null,
            password1: null,
            password_error: false,

            kview: {
                api: '/api/v1/hr/employee/',
                form_data: [],
                field_groups: [
                    {
                        'name': 'Basic Info', 'fields': [
                            { 'col': 'col-sm-8', 'name': 'Name', 'key' : 'name', 'type': 'text', 'placeholder': 'Full Name of the Employee', 'required': 'yes'  },
                            { 'col': 'col-sm-2', 'name': 'Sex', 'key' : 'sex', 'type': 'select', 'options' : [{'code': 'F', 'label': 'Female'},{'code': 'M', 'label': 'Male'}]  },
                            { 'col': 'col-sm-2', 'name': 'Age', 'key' : 'age', 'type': 'number'  },
                            // { 'col': 'col-sm-4', 'name': 'Employee Picture', 'key' : 'image', 'type': 'picture'  },
                            { 'col': 'col-sm-4', 'name': 'Educational background', 'key' : 'educational_background', 'type': 'vselect-b',  'options': 'educational_background'  },
                            { 'col': 'col-sm-4', 'name': 'Password', 'key' : 'the_password', 'type': 'viewonly'  },
                        ]
                    }, {
                        'name': 'Address', 'fields': [
                            { 'col': 'col-sm-4', 'name': 'Email', 'key' : 'email', 'type': 'text' },
                            { 'col': 'col-sm-4', 'name': 'Generated Email', 'key' : 'the_email', 'type': 'viewonly'  },
                            { 'col': 'col-sm-4', 'name': 'Phone Number', 'key' : 'phone_number', 'type': 'text'  },
                            { 'col': 'col-sm-3', 'name': 'Region', 'key' : 'region', 'type': 'vselect-b',  'options': 'regions'  },
                            { 'col': 'col-sm-3', 'name': 'Zone', 'key' : 'zone', 'type': 'text'  },
                            { 'col': 'col-sm-3', 'name': 'Woreda', 'key' : 'woreda', 'type': 'text'  },
                            { 'col': 'col-sm-3', 'name': 'Kebele', 'key' : 'kebele', 'type': 'text'  },
                        ] 
                    }, {
                        'name': 'Employment', 'fields': [
                            { 'col': 'col-sm-4', 'name': 'Position', 'key' : 'position', 'type': 'vselect-b',  'options': 'positions'  },
                            { 'col': 'col-sm-4', 'name': 'Employement type', 'key' : 'employement_type', 'type': 'vselect-b', 'options' : 'employement_types' },
                            { 'col': 'col-sm-4', 'name': 'Branch', 'key' : 'the_branch', 'type': 'vselect-b',  'options': 'branches'  },
                        ]
                    }, {
                        'name': 'Financial', 'fields': [
                            { 'col': 'col-sm-4', 'name': 'Bank Name', 'key' : 'bank_name', 'type': 'vselect-b',  'options': 'banks'  },
                            { 'col': 'col-sm-4', 'name': 'Bank account Number', 'key' : 'bank_account_number', 'type': 'text'  },
                            { 'col': 'col-sm-4', 'name': 'Salary', 'key' : 'salary', 'type': 'number'  },
                        ]
                    }
                  ]
            }

        }
    },

    mounted() {
        // this.check_permission(this.permission)
        this.get_org_data();
        // this.$nextTick(function() {
        //     this.tell_active('HR')
        // })
    },
    created() {
        // this.fields.id = 1;
        // this.api = ;
    },

    methods: {
        evenodd(c) {
            if (c % 2 == 0) {
                return "odd"
            }
            return "even"
        },
        onLogoInput(event){
            this.the_image = event.target.files[0]
            this.the_image_url = URL.createObjectURL(this.the_image)
            this.img_status = "b"
        },
        cancel_upload_image(){
            this.the_image = null
            this.the_image_url = null
            this.img_status = 'a'
        },
        upload_image(){
            let formData = new FormData();
            formData.append('id', this.$route.params.id)
            formData.append('image', this.the_image)
            const config = {
                headers: {
                    'content-type': 'multipart/form-data',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                }
            }
            this.img_status = 'z'
            this.$axios.post('/api/personnel/employee/change_pp', formData, config)
                .then(response => {
                    if (response.data.status == "success") {
                        this.$swal({
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,
                            timerProgressBar: false,
                            onOpen: (toast) => {
                                toast.addEventListener('mouseenter', Swal.stopTimer)
                                toast.addEventListener('mouseleave', Swal.resumeTimer)
                            },
                            icon: 'success',
                            title: 'Image updated',
                        })
                        this.item.image = response.data.data.image
                        this.img_status = 'a'
                        this.the_image = null
                        this.the_image_url = null
                    }
                }).catch(error => {
                    if (error.response.status === 422) {
                        this.org_errors = error.response.data.errors || {};
                    }else{
                        this.$swal({
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,
                            timerProgressBar: false,
                            icon: 'error',
                            title: error.response.data.message,
                        })
                    }
                    this.img_status = 'a'
                });
        },
        reset_pwd(){
            this.$axios
                .get('/api/user/reset_password/'+this.$route.params.id)
                .then(response => {
                    this.get_org_data()
                    this.$swal({
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 3000,
                        timerProgressBar: false,
                        onOpen: (toast) => {
                            toast.addEventListener('mouseenter', Swal.stopTimer)
                            toast.addEventListener('mouseleave', Swal.resumeTimer)
                        },
                        icon: 'success',
                        title: 'new password generated',
                    })
                })
                .catch(error => {
                    this.$swal({
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 3000,
                        timerProgressBar: false,
                        icon: 'error',
                        title: 'You can not reset the passsword',
                    })
                })
        },
        modal_remove(){
            this.modal_show = false;
        },
        generate_idcard(){
            this.generate_idcard_label = "Generating ..."
            this.$axios
                .get('/api/personnel/generate_id/'+this.$route.params.id)
                .then(response => {
                    this.generate_idcard_label = "Generate ID Card"
                    this.modal_show = true;
                    this.generate_id = response.data.generate_id;
                    this.download_id = response.data.download_id
                })
                .catch(error => {
                    this.generate_idcard_label = "Generate ID Card"
                    console.log(error)
                    this.errored = true
                })
        },
        check_pwds() {
            if (!this.password1 || !this.password2) {
                this.password_error = false
            } else if (this.password1 != this.password2) {
                this.password_error = true;
            } else {
                this.password_error = false
            }
            console.log(this.password1, this.password1, this.password_error)
        },

        change_pw() {
            if (!this.password1 || !this.password1) {
                this.$swal({
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 3000,
                    timerProgressBar: false,
                    onOpen: (toast) => {
                        toast.addEventListener('mouseenter', Swal.stopTimer)
                        toast.addEventListener('mouseleave', Swal.resumeTimer)
                    },
                    icon: 'error',
                    title: 'Empty field found',
                })
                return;
            }
            if (this.password1 != this.password2) {
                this.$swal({
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 3000,
                    timerProgressBar: false,
                    onOpen: (toast) => {
                        toast.addEventListener('mouseenter', Swal.stopTimer)
                        toast.addEventListener('mouseleave', Swal.resumeTimer)
                    },
                    icon: 'error',
                    title: 'Passwords do not match',
                })
                return;
            }

            let formData = new FormData();
            formData.append('password', this.password1)
            const config = {
                headers: {
                    'content-type': 'multipart/form-data',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                }
            }
            this.$axios.post('/api/usermgt/change_pwd', formData, config)
                .then(response => {
                    if (response.data.status == "success") {
                        this.$swal({
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,
                            timerProgressBar: false,
                            onOpen: (toast) => {
                                toast.addEventListener('mouseenter', Swal.stopTimer)
                                toast.addEventListener('mouseleave', Swal.resumeTimer)
                            },
                            icon: 'success',
                            title: 'Password updated',
                        })
                    }
                    this.password1 = null
                    this.password2 = null
                }).catch(error => {
                    if (error.response.status === 422) {
                        this.org_errors = error.response.data.errors || {};
                        this.$swal({
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,
                            timerProgressBar: false,
                            icon: 'error',
                            title: error.response.data.message,
                        })
                    }
                });
        },

        // get_org_data() {


        //     this.$axios
        //         .get('/api/hr/employee/show/'+this.$route.params.id)
        //         .then(response => {
        //             this.employee = response.data.data.employee
        //             // this.load_page = true
        //             this.loading = false
        //         })
        //         .catch(error => {
        //             console.log(error)
        //             this.errored = true
        //         })
        //     this.$axios
        //         .get('/api/hr/employee/create/')
        //         .then(response => {
        //             this.kview.form_data = response.data.data
        //         })
        //         .catch(error => {
        //         })
        //         // .finally(() => this.loading = false)
        // },
    }


}

</script>
