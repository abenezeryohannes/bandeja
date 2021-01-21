<?php

namespace Modules\Expenses\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;

class ExpensesDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();
        $this->call("\Modules\Expenses\Database\Seeders\VendorCategoriesTableSeeder");
        $this->call("\Modules\Expenses\Database\Seeders\VendorsTableSeeder");
        $this->call("\Modules\Expenses\Database\Seeders\RecurringsTableSeeder");

        $this->call("\Modules\Expenses\Database\Seeders\PaymentsTableSeeder");
        $this->call("\Modules\Expenses\Database\Seeders\BillsTableSeeder");
        $this->call("\Modules\Expenses\Database\Seeders\BillPaymentsTableSeeder");
    }
}
