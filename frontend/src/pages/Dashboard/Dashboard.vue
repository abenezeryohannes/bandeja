<template>
    <layout-b  :page="page_meta" :page_status_code="page_status_code">
        <div class="card shadow"><div class="card-body"><div class="row"><div class="col-md-4"><a href="http://localhost:8001/settings/company"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fa fa-building"></i></div></div> <div class="col ml--2"><h4 class="mb-0">Company</h4> <p class="text-sm text-muted mb-0">Change company name, email, address, tax number etc</p></div></div></button></a></div> <div class="col-md-4"><a href="http://localhost:8001/settings/localisation"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fas fa-map-marker-alt"></i></div></div> <div class="col ml--2"><h4 class="mb-0">Localisation</h4> <p class="text-sm text-muted mb-0">Set fiscal year, time zone, date format and more locals</p></div></div></button></a></div> <div class="col-md-4"><a href="http://localhost:8001/settings/invoice"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fas fa-file-alt"></i></div></div> <div class="col ml--2"><h4 class="mb-0">Invoice</h4> <p class="text-sm text-muted mb-0">Customize invoice prefix, number, terms, footer etc</p></div></div></button></a></div> <div class="col-md-4"><a href="http://localhost:8001/settings/default"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fa fa-sliders-h"></i></div></div> <div class="col ml--2"><h4 class="mb-0">Default</h4> <p class="text-sm text-muted mb-0">Default account, currency, language of your company</p></div></div></button></a></div> <div class="col-md-4"><a href="http://localhost:8001/settings/email"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fa fa-envelope"></i></div></div> <div class="col ml--2"><h4 class="mb-0">Email</h4> <p class="text-sm text-muted mb-0">Change the sending protocol and email templates</p></div></div></button></a></div> <div class="col-md-4"><a href="http://localhost:8001/settings/schedule"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fas fa-history"></i></div></div> <div class="col ml--2"><h4 class="mb-0">Scheduling</h4> <p class="text-sm text-muted mb-0">Automatic reminders and command for recurring</p></div></div></button></a></div> <div class="col-md-4"><a href="http://localhost:8001/settings/categories"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fa fa-folder"></i></div></div> <div class="col ml--2"><h4 class="mb-0">Categories</h4> <p class="text-sm text-muted mb-0">Unlimited categories for income, expense, and item</p></div></div></button></a></div> <div class="col-md-4"><a href="http://localhost:8001/settings/currencies"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fa fa-dollar-sign"></i></div></div> <div class="col ml--2"><h4 class="mb-0">Currencies</h4> <p class="text-sm text-muted mb-0">Create and manage currencies and set their rates</p></div></div></button></a></div> <div class="col-md-4"><a href="http://localhost:8001/settings/taxes"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fas fa-percent"></i></div></div> <div class="col ml--2"><h4 class="mb-0">Taxes</h4> <p class="text-sm text-muted mb-0">Fixed, normal, inclusive, and compound tax rates</p></div></div></button></a></div> <div class="col-md-4"><a href="http://localhost:8001/paypal-standard/settings"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fab fa-paypal"></i></div></div> <div class="col ml--2"><h4 class="mb-0">PayPal Standard</h4> <p class="text-sm text-muted mb-0">Enable the standard payment option of PayPal</p></div></div></button></a></div> <div class="col-md-4"><a href="http://localhost:8001/offline-payments/settings"><button type="button" class="btn-icon-clipboard p-2"><div class="row mx-0"><div class="col-auto"><div class="badge badge-secondary settings-icons"><i class="fas fa-credit-card"></i></div></div> <div class="col ml--2"><h4 class="mb-0">Offline Payments</h4> <p class="text-sm text-muted mb-0">Create unlimited payment options for admin usage</p></div></div></button></a></div></div></div></div>
    </layout-b>
</template>
<script>
import PageLoader from "../../mixins/PageLoader"
export default {

    props: [],

    mixins: [PageLoader],

    components: {},
    data() {
        return {
            api: '/api/v1/invoices/create',
            departments: [],
            loaded: false,
            page_meta: {
                title: 'Dashboard',
                permission: 'plan',
                active_link: 'Home',
                breadcrumb: [
                    { label: 'Home', icon: 'dashboard' },
                    { label: 'Plan', icon: '' },
                ]
            },
        }
    },
}
</script>
