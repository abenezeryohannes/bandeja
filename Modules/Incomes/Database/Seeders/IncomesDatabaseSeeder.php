<?php

namespace Modules\Incomes\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;

class IncomesDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();
        $this->call("\Modules\Incomes\Database\Seeders\TenantsTableSeeder");
        $this->call("\Modules\Incomes\Database\Seeders\RevenuesTableSeeder");

        $this->call("\Modules\Incomes\Database\Seeders\InvoicesTableSeeder");
        $this->call("\Modules\Incomes\Database\Seeders\InvoicePaymentsTableSeeder");

    }
}
