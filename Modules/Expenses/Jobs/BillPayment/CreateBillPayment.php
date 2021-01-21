<?php

namespace Modules\Expenses\Jobs\BillPayment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Expenses\Entities\BillPayment;

class CreateBillPayment implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $bill_payment = null;
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

            if($this->request['bill_id']==null){
                $this->response = "Must be connected to bill to make payment!";
                return;
            }
            $this->bill_payment = BillPayment::create($this->request);

            if($this->bill_payment == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->bill_payment : $this->response;
    }
}
