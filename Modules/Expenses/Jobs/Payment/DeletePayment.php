<?php

namespace Modules\Expenses\Jobs\Payment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Jobs\Transaction\DeleteTransaction;
use Modules\Expenses\Entities\Payment;

class DeletePayment implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $payment = null;
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
            $this->payment = Payment::find($this->id);
            if($this->payment == null){
                $this->response =  "No payment found with this id!";
            }else {

                $trans_id = $this->payment->transaction_id;
                //delete payment
                $this->payment->delete();
                //delete the transaction created with that payment;
                if($trans_id!=null) {
                    DeleteTransaction::dispatchNow($trans_id);
                }

            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
