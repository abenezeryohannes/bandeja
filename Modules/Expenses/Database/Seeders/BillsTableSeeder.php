<?php

namespace Modules\Expenses\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;
use Modules\Expenses\Entities\Bill;
use Modules\Expenses\Entities\Payment;
use Modules\Expenses\Entities\Vendor;

class BillsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        $vendors = Vendor::all();
        $category = Category::where('name', '=', 'Payroll')->first();
        foreach ($vendors as $vendor){
            $amount = rand(100, 5000);
                $bill = Bill::create([
                    'vendor_id'=>$vendor->id,
                    'category_id'=>($category!=null)?$category->id:1,
                    'tax_id'=>1,
                    'recurring_id'=>1,
                    'note'=>'random note',
                    'canceled'=>false,
                    'fixed'=>true,
                    'price'=>$amount
                ]);
        }
        // $this->call("OthersTableSeeder");
    }
}
