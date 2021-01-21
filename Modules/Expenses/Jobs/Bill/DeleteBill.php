<?php

namespace Modules\Expenses\Jobs\Bill;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Expenses\Entities\Bill;
use Modules\Expenses\Jobs\BillPayment\DeleteBillPayment;

class DeleteBill implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $bill = null;
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
            $this->bill = Bill::find($this->id);
            if($this->bill == null){
                $this->response =  "No bill found with this id!";
            }else {
                //to delete bill delete the bill payment created with that bill;
                $bill_payments_id = $this->bill->billPayments()->pluck('id');

                if($bill_payments_id!=null) {
                    foreach ($bill_payments_id as $id)
                        $this->response =  DeleteBillPayment::dispatchNow($id);
                    if(is_string($this->response) || !$this->response)
                    {$this->response = "Can't delete bill payments";return;}
                    else $this->response = null;
                }

                $this->bill->delete();

            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
