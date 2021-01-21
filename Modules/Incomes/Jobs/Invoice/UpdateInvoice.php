<?php

namespace Modules\Incomes\Jobs\Invoice;

use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Jobs\InvoicePayment\CreateInvoicePayment;
use Modules\Incomes\Jobs\InvoicePayment\UpdateInvoicePayment;
use Modules\Properties\Entities\Property;

class UpdateInvoice implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $invoice = null;
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


                //can't change invoices start and end date also price
                $this->request['start_date'] = $this->invoice->start_date;
                $this->request['end_date'] = $this->invoice->end_date;
                $this->request['price'] = $this->invoice->price;


                if(array_key_exists('due_date_diff', $this->request->all())) {
                    //get the difference in days between invoice date and due date
                    $dueDiff = $this->request['due_date_diff'];
                    //change properties for invoice payments after this change date

                    $inv_payments = $this->invoice->invoicePayments->where('invoice_date', '>', Carbon::now());

                    foreach ($inv_payments as $i) {
                        $edit_invoice_payment = $this->request;
                        $edit_invoice_payment['due_date'] = Carbon::parse($i->invoice_date)->addDays($dueDiff);
                        $this->response = UpdateInvoicePayment::dispatchNow($edit_invoice_payment, $i->id);
                        if (is_string($this->response)) return;
                        else $this->response = null;
                    }
                }

                //save the new invoice
                $this->invoice = $this->invoice->update($this->request->all());


                //update properties available_after
                Property::where('id', '=', $this->invoice->property_id)->update([
                    'available_after' => Carbon::parse($this->invoice->end_date)
                ]);
            }
        });
        return ($this->response == null || !is_string($this->response))? $this->invoice : $this->response;
    }
}
