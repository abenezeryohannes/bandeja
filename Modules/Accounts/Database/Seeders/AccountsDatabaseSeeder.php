<?php

namespace Modules\Accounts\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Accounts\Entities\Account;

class AccountsDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        Account::create([
            'name'=>'CBE 1000***4343', 'account_number'=>'10003489754343',
            'opening_balance'=>1200000,
            'bank'=>'CBE', 'main_account'=> Account::all()->count()==0,
        ]);

         $this->call("\Modules\Accounts\Database\Seeders\CategoriesTableSeeder");
         $this->call("\Modules\Accounts\Database\Seeders\TaxesTableSeeder");
         $this->call("\Modules\Accounts\Database\Seeders\PaymentMethodsTableSeeder");
         $this->call("\Modules\Accounts\Database\Seeders\InterestsTableSeeder");
    }
}
