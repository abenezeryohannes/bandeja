<?php

namespace Modules\Expenses\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;
use Modules\Expenses\Entities\Payment;
use Modules\Expenses\Entities\Vendor;

class PaymentsTableSeeder extends Seeder
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
        $categories = Category::where('type', '=', 'expense')->get();;
        foreach ($vendors as $vendor){
            $amount = rand(100, 5000);
            foreach ($categories as $category) {
                $transaction = Transaction::create([
                    'type'=>'expense',
                    'category_id'=>$category->id,
                    'account_id'=>1,
                    'tax_id'=>1,
                    'amount'=>$amount,
                    'note'=>'random note',
                    'transaction_date'=>Carbon::now(),
                    'payment_method_id'=>1
                ]);
                Payment::create([
                    'vendor_id'=>$vendor->id,
                    'category_id'=>$category->id,
                    'tax_id'=>1,
                    'transaction_id'=>$transaction->id,
                    'amount'=>$amount
                ]);
            }
        }
        // $this->call("OthersTableSeeder");
    }
}
