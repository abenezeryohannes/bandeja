<?php

namespace Modules\Expenses\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Expenses\Entities\Vendor;

class VendorsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        Vendor::factory(5)->create();
        // $this->call("OthersTableSeeder");
    }
}
