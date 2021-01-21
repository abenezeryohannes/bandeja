<?php

namespace Modules\Expenses\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Expenses\Entities\VendorCategory;

class VendorCategoriesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        VendorCategory::create([
           'name'=>'Employee'
        ]);
        VendorCategory::create([
           'name'=>'Private Company'
        ]);
        VendorCategory::create([
           'name'=>'Government Institution'
        ]);

        // $this->call("OthersTableSeeder");
    }
}
