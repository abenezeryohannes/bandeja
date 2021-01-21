<?php

namespace Modules\Incomes\Jobs\Invoice;

use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Jobs\Transaction\DeleteTransaction;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Jobs\InvoicePayment\DeleteInvoicePayment;
use Modules\Properties\Entities\Property;

class DeleteInvoice implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $invoice = null;
    protected $response = null;


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


                //update properties available_after
                Property::where('id', '=', $this->invoice->property_id)->update([
                    'available_after' => Carbon::now()
                ]);
                //delete invoice
                $this->invoice->delete();

            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
