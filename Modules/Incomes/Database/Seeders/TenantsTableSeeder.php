<?php

namespace Modules\Incomes\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Incomes\Entities\Tenant;

class TenantsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();


        Tenant::factory(10)->create();

        // $this->call("OthersTableSeeder");
    }
}
