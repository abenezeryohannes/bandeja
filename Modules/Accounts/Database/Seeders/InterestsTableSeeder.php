<?php

namespace Modules\Accounts\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Accounts\Entities\Interest;
use Modules\Accounts\Entities\Tax;

class InterestsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        Interest::create(['date' => Carbon::now(), 'amount' => rand(1000000, 999999), 'account_id' => 1]);

        // $this->call("OthersTableSeeder");
    }
}
