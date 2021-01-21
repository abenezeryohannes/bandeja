<?php

namespace Modules\Accounts\Jobs\Transaction;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Transaction;
use Modules\Expenses\Entities\Bill;
use Modules\Expenses\Entities\Payment;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Entities\Revenue;

class DeleteTransaction implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $transaction = null;
    protected $response = null;

    /**
     * Create a new job instance.
     *
     * @param  $request
     */
    public function __construct($id)
    {
        $this->id = $id;
    }


    public function handle()
    {
        \DB::transaction(function() {
            $this->transaction = Transaction::find($this->id);
            if($this->transaction == null){
                $this->response =  "No transaction is found with this id!";
            }else {


                //check if it is attached to invoice
                if(strtolower($this->transaction->type)=="invoice"){
                    Invoice::where('id', '=', $this->transaction->invoice_id)->update([
                        'transaction_id' => null
                    ]);
                }

                //check if it is attached to revenue
                if(strtolower($this->transaction->type)=="revenue"){
                    Revenue::where('id', '=', $this->transaction->revenue_id)->update([
                        'transaction_id' => null
                    ]);
                }

                //check if it is attached to payment
                if(strtolower($this->transaction->type)=="payment"){
                    Payment::where('id', '=', $this->transaction->payment_id)->update([
                        'transaction_id' => null,
                    ]);
                }
                //check if it is attached to bill
                if(strtolower($this->transaction->type)=="bill"){
                    Bill::where('id', '=', $this->transaction->bill_id)->update([
                        'transaction_id' => null,
                    ]);
                }

                $account = Account::find($this->transaction->account_id);
                if($account != null){
                    $type = $this->transaction->category->type;

                    if(strtolower($type) == "income" || strtolower($type) == "deposit")
                        $account->balance = $account->blance - abs($this->transaction->amount);
                    else
                        $account->balance = $account->blance + abs($this->transaction->amount);

                    $account->save();
                }

                $this->transaction->delete();
            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }

}
