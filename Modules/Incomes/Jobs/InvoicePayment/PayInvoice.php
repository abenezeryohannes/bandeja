<?php

namespace Modules\Incomes\Jobs\InvoicePayment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Jobs\Transaction\CreateTransaction;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Entities\InvoicePayment;

class PayInvoice implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $invoice_payment = null;
    protected $invoice_payment_id;
    protected $invoice_id;
    protected $invoice = null;
    protected $response = null;
    protected $request;

    /**
     * Create a new job instance.
     *
     * @param  $request
     */
    public function __construct($request, $invoice_id)
    {
        $this->request = ($request);
        $this->invoice_id = ($invoice_id);
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        \DB::transaction(function() {


            if( $this->invoice_id == null){
                $this->response = "Invoice id is not provided"; return;
            }
            $this->invoice = Invoice::find($this->invoice_id);


            if($this->request['invoice_payment_id'] == null){
                $this->invoice_payment = InvoicePayment::where('invoice_id', '=', $this->invoice_id)->where('transaction_id', '=', null)->first();
            }else{
                $this->invoice_payment = InvoicePayment::find($this->request['invoice_payment_id']);
            }

            if($this->invoice == null || $this->invoice_payment == null){
                $this->response = "Invoice or invoice payment is not known"; return;
            }

            if($this->invoice_payment->invoice_id!=$this->invoice->id){
                {$this->response = "This invoice payment id and invoice don't match!";return;}
            }

            if($this->invoice_payment->status == "payed") {
                if($this->invoice_payment->transaction_id!=null)
                {$this->response = "This invoice is already paid!";return;}
            }

            $this->request['type'] = "invoice";
            $this->request['category_id'] = $this->invoice->category_id;

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
                //get transaction id
                $this->invoice_payment->transaction_id = $this->response->id;

                //if period is more than one delete the next payment requests
                if($this->request['period']>1) {
                    $invoice_payments_id = $this->invoice->invoicePayments()->where('id', '>', $this->invoice_payment->id)->pluck('id');

                    if($this->request['period']-1 > count($invoice_payments_id)) {
                        $this->response = "the maximum period allowed to pay is ".(count($invoice_payments_id)+1);return;
                    }

                    if ($invoice_payments_id != null) {
                        for ($i = 0;$i<$this->request['period']-1;$i++) {
                            $this->response = DeleteInvoicePayment::dispatchNow($invoice_payments_id[$i]);
                            if (is_string($this->response) || !$this->response) {
                                $this->response = "Can't delete invoice payments";
                                return;
                            } else $this->response = null;
                        }
                    }
                }

                // $this->invoice_payment->payment_type_id = $this->request['payment_type_id'];
                $this->invoice_payment->period = $this->request['period'];
                $this->invoice_payment->price = $this->invoice_payment->price * $this->invoice_payment->period;
                $this->invoice_payment->status = "payed";
                $this->invoice_payment->save();
                $this->response = null;
            }
        });

        return ($this->response ==null)? $this->invoice_payment : $this->response;
    }
}