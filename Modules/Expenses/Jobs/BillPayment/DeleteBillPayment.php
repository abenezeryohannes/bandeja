<?php

namespace Modules\Expenses\Jobs\BillPayment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Jobs\Transaction\DeleteTransaction;
use Modules\Expenses\Entities\BillPayment;

class DeleteBillPayment implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $bill_payment = null;
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
            $this->bill_payment = BillPayment::find($this->id);
            if($this->bill_payment == null){
                $this->response =  "No bill payment found with this id!";
            }else {
                //to delete bill_payment delete the transaction created with that bill payment;

                $transaction = $this->bill_payment->transaction_id;

                //delete bill
                $this->bill_payment->delete();
                //delete transactions
                if ($transaction != null) {
                    $this->response = DeleteTransaction::dispatchNow($transaction);
                    if (is_string($this->response) || !$this->response) {
                        $this->response = "Can't delete transactions related to this bill payment";
                        return;
                    } else $this->response = null;
                }

            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
