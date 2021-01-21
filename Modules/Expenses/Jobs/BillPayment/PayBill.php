<?php

namespace Modules\Expenses\Jobs\BillPayment;

use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Jobs\Transaction\CreateTransaction;
use Modules\Expenses\Entities\Bill;
use Modules\Expenses\Entities\BillPayment;
use Modules\Expenses\Entities\Recurring;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Entities\InvoicePayment;
use Modules\Incomes\Jobs\InvoicePayment\DeleteInvoicePayment;

class PayBill implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $bill_payment = null;
    protected $bill_payment_id;
    protected $bill_id;
    protected $bill = null;
    protected $response = null;
    protected $request;

    /**
     * Create a new job instance.
     *
     * @param  $request
     */
    public function __construct($request, $bill_id)
    {
        $this->request = ($request);
        $this->bill_id = ($bill_id);
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        \DB::transaction(function() {

            $this->bill_payment_id = $this->request['bill_payment_id'];
            if($this->bill_payment_id ==null || $this->bill_id == null){
                $this->response = "Bill id or payment id is not provided"; return;
            }

            $this->bill_payment = BillPayment::find($this->bill_payment_id);
            $this->bill = Bill::find($this->bill_id);

            if($this->bill == null || $this->bill_payment_id == null){
                $this->response = "Bill or bill payment is not known"; return;
            }

            if($this->bill_payment->bill_id!=$this->bill->id){
                {$this->response = "This Bill payment id and bill don't match!";return;}
            }

            if($this->bill_payment->transaction_id!=null)
            {$this->response = "This bill is already paid!";return;}

            $this->request['type'] = "bill";
            $this->request['category_id'] = $this->bill->category_id;

            if($this->request['account_id']==null){
                //No account provided so using main account!";
                $account = Account::where('main_account', '=', 1)->first();
                //if no main account -> show errror
                if($account==null)
                    {$this->response = "No account provided to use.";return;}
                else
                    $this->request['account_id'] = $account->id();
            }

            //save the new transaction
            $this->response =  CreateTransaction::dispatchNow($this->request);
            if(is_string($this->response)) return;
            else{
                //save payment info to bill payment
                $this->bill_payment->transaction_id = $this->response->id;
                $this->bill_payment->period = $this->request['period'];
                $this->bill_payment->price = $this->bill_payment->price * $this->bill_payment->period;
                $this->bill_payment->save();


                //create new bill payment
                $recurring = Recurring::where('id','=', $this->bill->recurring_id)->first();
                $new_bill_date = Carbon::parse($this->bill_payment->bill_date)->addDays($recurring->interval);
                $due_deference = Carbon::parse($this->bill_payment->bill_date)->diffInDays($this->bill_payment->due_date);
                BillPayment::create([
                    'bill_id'=>$this->bill->id,
                    'bill_date'=>$new_bill_date,
                    'price'=>$this->bill->price,
                    'due_date'=>$new_bill_date->addDays($due_deference)
                ]);

            }
        });

        return ($this->response ==null)? $this->bill_payment : $this->response;
    }
}
