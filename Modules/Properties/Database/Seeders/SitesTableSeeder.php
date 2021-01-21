<?php

namespace Modules\Properties\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Properties\Entities\Site;
class SitesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();
        Site::factory(3)->create();

        $this->call("\Modules\Properties\Database\Seeders\BlocksTableSeeder");
        $this->call("\Modules\Properties\Database\Seeders\PropertyCategoriesTableSeeder");
        $this->call("\Modules\Properties\Database\Seeders\PropertiesTableSeeder");
    }
}
