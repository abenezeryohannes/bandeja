// import ChurchMembers from './church-cloud/components/pages/ChurchMembers/ChurchMembers.vue';
// import ChurchMemberSingle from './church-cloud/components/pages/ChurchMembers/ChurchMemberSingle.vue';
// import Charity from './church-cloud/components/pages/Charity/Charity.vue'

// import Inventory from './common/Inventory.vue';
// import AdminCenter from './common/AdminCenter.vue';
// import Notifications from './common/Notifications.vue';
// import FourOFour from './common/404.vue'
// import FourOThree from './common/403.vue'
// import HR from './common/HR.vue';
// import ToDo from './common/ToDo.vue';
// import Messages from './common/Messages.vue';
// import MyAccount from './common/MyAccount.vue';
// import Dashboard from './church-cloud/components/pages/Dashboard/Dashboard.vue';
// import Finance from './church-cloud/components/pages/Finance/Finance.vue';
// import Payroll from './church-cloud/components/pages/Finance/Payroll.vue'
// import SearchPage from './common/SearchPage'
// import ChurchMemberGroup from './church-cloud/components/pages/ChurchMembers/Group/ChurchMemberGroup'
// import EventMgt from './church-cloud/components/pages/EventMgt/EventMgt'


import Finance from './src/pages/Finance/Finance'
import Plan from './src/pages/Plan/Plan'
import Sales from './src/pages/Sales/Sales'
import HR from './src/pages/HR/HR'
import HREmployeeSingle from './src/pages/HR/HREmployeeSingle.vue';

import Dashboard from './src/pages/Dashboard/Dashboard'

import Profile from './src/pages/User/Profile'
import Accounts from './src/pages/Banking/Accounts'


export const routes = [

    // { path: '/app/search/:query', component: SearchPage, name: 'SearchPage' },

    { path: '/app', component: Dashboard, name: 'Home' },
    // { path: '/app/notifications', component: Notifications, name: 'Notifications', },
    // { path: '/app/messages', component: Messages, name: 'Messages' },

    { path: '/app/plans', component: Plan, name: 'Plan' },
    { path: '/app/sales', component: Sales, name: 'Sales' },

    { path: '/app/banking/accounts', component: Accounts, name: 'Accounts' },



    { path: '/app/user/profile', component: Profile, name: 'Profile' },

    { path: '/app/hr', component: HR, name: 'HR', meta : { permission: "HR_EMPLOYEES" } },
    { path: '/app/hr/employee/:id', component: HREmployeeSingle, name: 'HREmployeeSingle', meta : { permission: "HR_EMPLOYEES" } },

    // { path: '/app/setting/my-account', component: MyAccount, name: 'MyAccount' },
    // { path: '/app/setting/admin-center', component: AdminCenter, name: 'AdminCenter', meta : { permission: "ADMIN_CENTER" } },

    // { path: '/app/todo', component: ToDo, name: 'ToDo' },

    // { path: '/app/event-mgt', component: EventMgt, name: 'EventMgt' },

    { path: '/app/finance', component: Finance, name: 'Finance' },
    // { path: '/app/finance/payroll', component: Payroll, name: 'Payroll' },

    // { path: '/app/charity', component: Charity, name: 'Charity' },

    // { path: '/app/church-members', component: ChurchMembers, name: 'ChurchMembers' },
    // { path: '/app/church-member/:id', component: ChurchMemberSingle, name: 'ChurchMemberSingle' },


    // { path: '/app/church-member-group/:id', component: ChurchMemberGroup, name: 'ChurchMemberGroupSingle' },
    // //


    // { path: '/app/403', component: FourOThree, name: '403' },
    // { path: '/app/*', component: FourOFour, name: 'FourOFour' },
  

    // { path: '/app/*', component: FourOFour, name: 'FourOFour' },


]; 

