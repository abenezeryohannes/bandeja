<?php

namespace Modules\Incomes\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Entities\InvoicePayment;

class InvoicePaymentsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        $invoices = Invoice::all();
        foreach ($invoices as $invoice){
            $months = Carbon::parse($invoice->start_date)->diffInMonths($invoice->end_date);
            $due_diff = Carbon::parse($invoice->start_date)->diffInDays($invoice->due_date);
            for($month = 1;$month<=$months;$month++){
                $invoice_date = Carbon::parse($invoice->start_date)->addMonths($month);
                InvoicePayment::create([
                    'period'=>1,
                    'invoice_id'=>$invoice->id,
                    'invoice_date'=> $invoice_date,
                    'price'=>$invoice->price,
                    'due_date'=>$invoice_date->addDays($due_diff),
                ]);
            }
        }
        // $this->call("OthersTableSeeder");
    }
}
