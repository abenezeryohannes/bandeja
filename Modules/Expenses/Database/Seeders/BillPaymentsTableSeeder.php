<?php

namespace Modules\Expenses\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;
use Modules\Expenses\Entities\Bill;
use Modules\Expenses\Entities\BillPayment;
use Modules\Expenses\Entities\Recurring;

class BillPaymentsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();
        $bills = Bill::all();
        $category = Category::where('name', '=', 'Payroll')->first();
        $count = 0;
        foreach ($bills as $bill){
            $count++;
            $amount = rand(100, 5000);
                if($count%3==0) {
                    $transaction = Transaction::create([
                        'type' => 'expense',
                        'category_id' => ($category != null) ? $category->id : 1,
                        'account_id' => 1,
                        'tax_id' => 1,
                        'amount' => $amount,
                        'note' => 'random note',
                        'transaction_date' => Carbon::now(),
                        'payment_method_id' => 1
                    ]);
                }
                $recurring = Recurring::where('id', '=', $bill->recurring_id)->first();
                BillPayment::create([
                    'bill_id'=>$bill->id,
                    'bill_date'=> Carbon::parse($bill->start_date)->addDays($recurring->interval),
                    'price'=>$amount,
                    'due_date'=> Carbon::parse($bill->due_date)->addDays($recurring->interval),
                    'transaction_id'=>($count%3==0)?$transaction->id:null,
                ]);
        }
        // $this->call("OthersTableSeeder");
    }
}
