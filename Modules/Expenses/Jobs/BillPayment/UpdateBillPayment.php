<?php

namespace Modules\Expenses\Jobs\BillPayment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Expenses\Entities\BillPayment;

class UpdateBillPayment implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $bill_payment = null;
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

            $this->bill_payment = BillPayment::find($this->id);

            if($this->bill_payment == null){

                $this->response =  "No bill payment found with this id!";

            }else {
                $this->bill_payment->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->bill_payment : $this->response;
    }
}
