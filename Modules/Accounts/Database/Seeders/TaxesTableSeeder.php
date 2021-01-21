<?php

namespace Modules\Accounts\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Accounts\Entities\Tax;

class TaxesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();
        if(Tax::all()->count()<2) {
            Tax::create(['name' => 'VAT', 'rate' => 10, 'description' => 'value added tax']);
            Tax::create(['name' => 'rental tax', 'rate' => 15, 'description' => 'rental tax']);
        }
        // $this->call("OthersTableSeeder");
    }
}
