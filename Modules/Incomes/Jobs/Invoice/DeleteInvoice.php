<?php

namespace Modules\Incomes\Jobs\Invoice;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Jobs\Transaction\DeleteTransaction;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Jobs\InvoicePayment\DeleteInvoicePayment;

class DeleteInvoice implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $invoice = null;
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
            $this->invoice = Invoice::find($this->id);
            if($this->invoice == null){
                $this->response =  "No invoice found with this id!";
            }else {
                //to delete invoice delete the invoice payment created with that invoice;
                $invoice_payments_id = $this->invoice->invoicePayments()->pluck('id');

                if($invoice_payments_id!=null) {
                    foreach ($invoice_payments_id as $id)
                    $this->response =  DeleteInvoicePayment::dispatchNow($id);
                    if(is_string($this->response) || !$this->response)
                        {$this->response = "Can't delete invoice payments";return;}
                    else $this->response = null;
                }

                $this->invoice->delete();

            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
