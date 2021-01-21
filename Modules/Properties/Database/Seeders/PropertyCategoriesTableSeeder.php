<?php

namespace Modules\Properties\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Properties\Entities\PropertyCategory;

class PropertyCategoriesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();
        PropertyCategory::factory(3)->create();
        

        // $this->call("OthersTableSeeder");
    }
}
