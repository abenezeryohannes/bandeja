<?php

namespace Modules\Incomes\Jobs\InvoicePayment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Jobs\Transaction\DeleteTransaction;
use Modules\Incomes\Entities\InvoicePayment;

class DeleteInvoicePayment implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $invoice_payment = null;
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
            $this->invoice_payment = InvoicePayment::find($this->id);
            if($this->invoice_payment == null){
                $this->response =  "No invoice payment found with this id!";
            }else {
                //to delete invoice_payment delete the transaction created with that invoice payment;

                $transaction = $this->invoice_payment->transaction()->first();

                if ($transaction != null) {
                    $this->response = DeleteTransaction::dispatchNow($transaction);
                    if (is_string($this->response) || !$this->response) {
                        $this->response = "Can't delete transactions made related to this invoice payment";
                        return;
                    } else $this->response = null;
                }

                $this->invoice_payment->delete();
            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
