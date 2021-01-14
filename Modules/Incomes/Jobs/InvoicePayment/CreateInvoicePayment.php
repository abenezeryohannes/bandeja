<?php

namespace Modules\Incomes\Jobs\InvoicePayment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Incomes\Entities\InvoicePayment;

class CreateInvoicePayment implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $invoice_payment = null;
    protected $response = null;
    protected $request;

    /**
     * Create a new job instance.
     *
     * @param  $request
     */
    public function __construct($request)
    {
        $this->request = ($request);
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        \DB::transaction(function() {

            if($this->request['invoice_id']==null){
                $this->response = "Must be connected to invoice to make payment!";
                return;
            }
            $this->invoice_payment = InvoicePayment::create($this->request);

            if($this->invoice_payment == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->invoice_payment : $this->response;
    }
}
