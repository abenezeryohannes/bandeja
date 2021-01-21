<?php

namespace Modules\Accounts\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Accounts\Entities\PaymentMethod;

class PaymentMethodsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        if(PaymentMethod::all()->count()<2) {
            PaymentMethod::create(['name' => 'CASH']);
            PaymentMethod::create(['name' => 'Bank transfer']);
        }
        // $this->call("OthersTableSeeder");
    }
}
