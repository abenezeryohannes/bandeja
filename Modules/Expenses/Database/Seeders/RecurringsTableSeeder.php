<?php

namespace Modules\Expenses\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Expenses\Entities\Recurring;

class RecurringsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        Recurring::create([
            'name'=>'Monthly',
            'interval'=>30
        ]);
        Recurring::create([
            'name'=>'Daily',
            'interval'=>1
        ]);
        Recurring::create([
            'name'=>'Weekly',
            'interval'=>365
        ]);
        Recurring::create([
            'name'=>'Yearly',
            'interval'=>365
        ]);

        // $this->call("OthersTableSeeder");
    }
}
