<?php

namespace Modules\Incomes\Jobs\InvoicePayment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Incomes\Entities\InvoicePayment;

class UpdateInvoicePayment implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $invoice_payment = null;
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

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {

        \DB::transaction(function() {

            $this->invoice_payment = InvoicePayment::find($this->id);

            if($this->invoice_payment == null){

                $this->response =  "No invoice payment found with this id!";

            }else {
                $this->invoice_payment->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->invoice_payment : $this->response;
    }
}
