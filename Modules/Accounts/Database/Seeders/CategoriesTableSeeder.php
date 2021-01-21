<?php

namespace Modules\Accounts\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Accounts\Entities\Category;

class CategoriesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        if(Category::all()->count()<4) {
            Category::create([
                'name' => 'Rent', 'type' => 'income', 'color' => '#243545'
            ]);
            Category::create([
                'name' => 'Late Payment Penalty', 'type' => 'income', 'color' => '#243545'
            ]);
            Category::create([
                'name' => 'Electric bill', 'type' => 'expense', 'color' => '#243545'
            ]);
            Category::create([
                'name' => 'Payroll', 'type' => 'expense', 'color' => '#243545'
            ]);
            Category::create([
                'name' => 'Others', 'type' => 'expense', 'color' => '#243545'
            ]);
        }
        // $this->call("OthersTableSeeder");
    }
}
