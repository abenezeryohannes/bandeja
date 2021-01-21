
import FourOFour from './src/pages/Misc/FourOFour'

import Dashboard from './src/pages/Dashboard/Dashboard'

import Profile from './src/pages/User/Profile'
import Accounts from './src/pages/Banking/Accounts'

import Categories from './src/pages/Properties/Categories'
import CategoriesCreate from './src/pages/Properties/CategoriesCreate'
import CategoriesShow from './src/pages/Properties/CategoriesShow'
import Properties from './src/pages/Properties/Properties'
import PropertiesCreate from './src/pages/Properties/PropertiesCreate'
import PropertiesShow from './src/pages/Properties/PropertiesShow'
import Sites from './src/pages/Properties/Sites'
import SitesCreate from './src/pages/Properties/SitesCreate'
import SitesShow from './src/pages/Properties/SitesShow'
import Blocks from './src/pages/Properties/Blocks'
import BlocksCreate from './src/pages/Properties/BlocksCreate'
import BlocksShow from './src/pages/Properties/BlocksShow'

import Invoices from './src/pages/Incomes/Invoices'
import InvoicesCreate from './src/pages/Incomes/InvoicesCreate'
import InvoicesShow from './src/pages/Incomes/InvoicesShow'
import InvoicePay from './src/pages/Incomes/InvoicePay'
import Revenues from './src/pages/Incomes/Revenues'
import RevenuesCreate from './src/pages/Incomes/RevenuesCreate'
import RevenuesShow from './src/pages/Incomes/RevenuesShow'
import Tenants from './src/pages/Incomes/Tenants'
import TenantsCreate from './src/pages/Incomes/TenantsCreate'
import TenantsShow from './src/pages/Incomes/TenantsShow'

export const routes = [


    { path: '/app/incomes/invoices', component: Invoices, name: 'Invoices' },
    { path: '/app/incomes/invoices/create', component: InvoicesCreate, name: 'InvoicesCreate' },
    { path: '/app/incomes/invoices/update/:id', component: InvoicesCreate, name: 'InvoicesUpdate' },
    { path: '/app/incomes/invoices/show/:id', component: InvoicesShow, name: 'InvoicesShow' },
    { path: '/app/incomes/invoices/pay/:id', component: InvoicePay, name: 'InvoicesPay' },

    { path: '/app/incomes/revenues', component: Revenues, name: 'Revenues' },
    { path: '/app/incomes/revenues/create', component: RevenuesCreate, name: 'RevenuesCreate' },
    { path: '/app/incomes/revenues/update/:id', component: RevenuesCreate, name: 'RevenuesUpdate' },
    { path: '/app/incomes/revenues/show/:id', component: RevenuesShow, name: 'RevenuesShow' },

    { path: '/app/incomes/tenants', component: Tenants, name: 'Tenants' },
    { path: '/app/incomes/tenants/create', component: TenantsCreate, name: 'TenantsCreate' },
    { path: '/app/incomes/tenants/update/:id', component: TenantsCreate, name: 'TenantsUpdate' },
    { path: '/app/incomes/tenants/show/:id', component: TenantsShow, name: 'TenantsShow' },


    { path: '/app/properties/categories', component: Categories, name: 'Categories' },
    { path: '/app/properties/categories/create', component: CategoriesCreate, name: 'CategoriesCreate' },
    { path: '/app/properties/categories/update/:id', component: CategoriesCreate, name: 'CategoriesUpdate' },
    { path: '/app/properties/categories/show/:id', component: CategoriesShow, name: 'CategoriesShow' },

    { path: '/app/properties/sites', component: Sites, name: 'Sites' },
    { path: '/app/properties/sites/create', component: SitesCreate, name: 'SitesCreate' },
    { path: '/app/properties/sites/update/:id', component: SitesCreate, name: 'SitesUpdate' },
    { path: '/app/properties/sites/show/:id', component: SitesShow, name: 'SitesShow' },

    { path: '/app/properties/properties', component: Properties, name: 'Properties' },
    { path: '/app/properties/properties/create', component: PropertiesCreate, name: 'PropertiesCreate' },
    { path: '/app/properties/properties/update/:id', component: PropertiesCreate, name: 'PropertiesUpdate' },
    { path: '/app/properties/properties/show/:id', component: PropertiesShow, name: 'PropertiesShow' },

    { path: '/app/properties/blocks', component: Blocks, name: 'Blocks' },
    { path: '/app/properties/blocks/create', component: BlocksCreate, name: 'BlocksCreate' },
    { path: '/app/properties/blocks/update/:id', component: BlocksCreate, name: 'BlocksUpdate' },
    { path: '/app/properties/blocks/show/:id', component: BlocksShow, name: 'BlocksShow' },



    { path: '/app/user/profile', component: Profile, name: 'Profile' },



    { path: '/app', component: Dashboard, name: 'Home' },
    { path: '/app/*', component: FourOFour, name: 'FourOFour' },


]; 

