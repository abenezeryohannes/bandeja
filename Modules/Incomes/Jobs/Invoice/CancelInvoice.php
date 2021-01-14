<?php

namespace Modules\Incomes\Jobs\Invoice;

use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Incomes\Entities\CanceledInvoice;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Jobs\InvoicePayment\DeleteInvoicePayment;
use Modules\Incomes\Jobs\InvoicePayment\UpdateInvoicePayment;

class CancelInvoice implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $invoice = null;
    protected $canceled_invoice = null;
    protected $id = 0;
    protected $request;
    protected $response = null;

    /**
     * Create a new job instance.
     *
     * @param  $request
     */
    public function __construct($request, $id)
    {
        $this->request = ($request);
        $this->id = $id;
    }


    public function handle()
    {

        \DB::transaction(function() {

            $this->invoice = Invoice::find($this->id);

            if($this->invoice == null){
                $this->response =  "No invoice found with this id!";
            }else {


                $cancel_date = Carbon::now()->addMonths($this->request['months']);

                $dif_in_month = Carbon::parse($cancel_date)->diffInMonths(Carbon::parse($this->invoice->start_date));

                $this->request['previous_end_date'] = $this->invoice->end_date;
                $this->request['invoice_id'] = $this->id;
                $this->canceled_invoice = CanceledInvoice::create($this->request->all());

                $new_end_date =  Carbon::parse($this->invoice->start_date)->addMonths($dif_in_month);

                //delete all invoice payments after cancel date
                $invoice_payments_id = $this->invoice->invoicePayments()->where('invoice_date', '>=', $new_end_date)->pluck('id');
                if($invoice_payments_id!=null) {
                    foreach ($invoice_payments_id as $id)
                        $this->response =  DeleteInvoicePayment::dispatchNow($id);
                    if(is_string($this->response) || !$this->response)
                    { $this->response = "Can't delete invoice payments"; return; }
                    else $this->response = null;
                }

                $this->invoice->update(["end_date"=>$new_end_date]);
            }
        });
        return ($this->response == null || !is_string($this->response))? $this->canceled_invoice : $this->response;
    }
}
