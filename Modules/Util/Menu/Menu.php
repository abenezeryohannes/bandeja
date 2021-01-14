<?php


namespace Modules\Util\Menu;


use Modules\User\Services\RoleHasPermissions;

class Menu
{
    protected $menu_type;
    protected $menu = [];
    protected $all_menu = [
        'main' => [
            ['expand'=>false, 'name'=> 'Home' , 'label' => 'dashboard', 'min_permission' => 'PLAN.INDEX', 'order' => 0, 'icon' => 'fa fa-comment'],
            ['expand'=>false,  'icon' => 'fa fa-home', 'name'=> 'Properties' , 'label' => 'properties', 'min_permission' => 'PLAN.INDEX', 'order' => 4, 'dropdown' => true,       'li' => [
                ['expand'=>false, 'label' => 'properties', 'name' => 'Properties' ],
                ['expand'=>false, 'label' => 'categories', 'name' => 'Categories' ],
                ['expand'=>false, 'label' => 'sites', 'name' => 'Sites' ],
                ['expand'=>false, 'label' => 'blocks', 'name' => 'Blocks' ],
            ]],
            ['expand'=>false,  'icon' => 'fa fa-money-bill-alt', 'name'=> 'Incomes' , 'label' => 'incomes', 'min_permission' => 'PLAN.INDEX', 'order' => 4, 'dropdown' => true,       'li' => [
                ['expand'=>false, 'label' => 'invoices', 'name' => 'Invoices' ],
                ['expand'=>false, 'label' => 'revenues', 'name' => 'Revenue' ],
                ['expand'=>false, 'label' => 'tenants', 'name' => 'Tenants' ],
            ]],
            ['expand'=>false,  'icon' => 'fa fa-lemon', 'name'=> 'Expenses' , 'label' => 'expenses', 'min_permission' => 'PLAN.INDEX', 'order' => 4, 'dropdown' => true,       'li' => [
                ['expand'=>false, 'label' => 'bills', 'name' => 'Bills' ],
                ['expand'=>false, 'label' => 'payment', 'name' => 'Payment' ],
                ['expand'=>false, 'label' => 'vendors', 'name' => 'Vendors' ],
            ]],
            ['expand'=>false,   'icon' => 'fa fa-kiss','name'=> 'Shares' , 'label' => 'shares', 'min_permission' => 'PLAN.INDEX', 'order' => 4, 'dropdown' => true,       'li' => [
                ['expand'=>false, 'label' => 'share_ledgers', 'name' => 'ShareLedgers' ],
                ['expand'=>false, 'label' => 'dividend_incomes', 'name' => 'DividendIncomes' ],
                ['expand'=>false, 'label' => 'share_holders', 'name' => 'ShareHolders' ],
            ]],
            ['expand'=>false,  'icon' => 'fa fa-money-bill-alt', 'name'=> 'Banking' , 'label' => 'banking', 'min_permission' => 'PLAN.INDEX', 'order' => 4, 'dropdown' => true,       'li' => [
                ['expand'=>false, 'label' => 'transactions', 'name' => 'Transactions' ],
                ['expand'=>false, 'label' => 'interests', 'name' => 'Interests' ],
                ['expand'=>false, 'label' => 'accounts', 'name' => 'Accounts' ],
            ] ],
            ['expand'=>false,  'icon' => 'fa fa-chart-bar', 'name'=> 'Reports' , 'label' => 'reports', 'min_permission' => 'PLAN.INDEX', 'order' => 4, 'dropdown' => true,       'li' => [
                ['expand'=>false, 'label' => 'dividend_income', 'name' => 'DividendIncome' ],
                ['expand'=>false, 'label' => 'shareholders', 'name' => 'Shareholders' ],
                ['expand'=>false, 'label' => 'rental', 'name' => 'Rental' ],
                ['expand'=>false, 'label' => 'accounts', 'name' => 'Accounts' ],
            ]],
            ['expand'=>false,  'icon' => 'fa fa-copy', 'name'=> 'Settings' , 'label' => 'settings', 'min_permission' => 'PLAN.INDEX', 'order' => 4],
        ],
    ];
    protected $roles = [];
    protected $permissions = [];
    public function __construct($menu_type)
    {
        $this->menu_type = $menu_type;
    }

    public function setRole($role)
    {
        $this->roles = collect($this->roles)->push($role);
        $permissions = collect($this->permissions);

        $ps = RoleHasPermissions::get( $role );
        $permissions = $permissions->merge($ps);

        $this->permissions = $permissions->unique()->toArray();
        return $this;
    }

    public function setRoles($roles)
    {
        $this->roles = $roles;
        $permissions = collect([]);
        foreach ($this->roles as $r){
            $ps = RoleHasPermissions::get($r);
            $permissions = $permissions->merge($ps);
        }
        $this->permissions = $permissions->unique()->toArray();
        return $this;
    }

    public function getMenu()
    {

        // menu: [
        //     { label: 'Home', icon: 'fa fa-tachometer-alt', name: 'Home' },
        //     { label: 'Properties', name: 'Properties', icon: 'fa fa-trash-o', dropdown: true, 
        //         expand: false, li: [
        //         { label: 'ddd', name: 'Plan' },
        //         { label: 'Sales', name: 'Sales' },
        //     ] }
        // ]
        $menu = collect([]);
        foreach ($this->all_menu[$this->menu_type] as $m){
            $f = true;
            if($m['min_permission']){
                $f = array_search($m['min_permission'], $this->permissions );
            }
            $li = $m['li'] ?? [];
            $rli = collect([]);
            foreach ($li as $l) {
                $l['label'] = __('menu.'. strtolower($l['label']) );
                $rli = $rli->push($l);
            }
            if ($rli->count()) {
                $m['li'] = $rli->values()->toArray();
            }
            if($f!== false){
                $m['label'] = __('menu.'. strtolower($m['label']) );
                $menu = $menu->push($m);
            }

        }
        $this->menu = $menu->sortBy('order')->values()->toArray();
        return $this->menu;
    }

}