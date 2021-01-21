<?php

namespace Modules\Expenses\Jobs\Bill;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Expenses\Entities\Bill;
use Modules\Expenses\Entities\BillPayment;
use Modules\Expenses\Jobs\BillPayment\DeleteBillPayment;
use Modules\Expenses\Jobs\BillPayment\UpdateBillPayment;

class CancelBill implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $bill = null;
    protected $id = 0;
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
            $this->bill = Bill::where('id', '=', $this->id)->first();

            if($this->bill == null){
                $this->response =  "No bill found with this id!";
            }else {
                //delete the last bill payment if its not payed
                $bill_payment = BillPayment::where('bill_id', '=', $this->bill->id)->orderBy('id', 'desc')->first();
                if($bill_payment->transaction_id == null) {
                    $this->response = DeleteBillPayment::dispatchNow($bill_payment->id);
                    if (is_string($this->response)) return;
                    else $this->response = null;
                }

                //save the new bill
                //can't change bills start and dye date also price
                $this->bill = $this->bill->update(["canceled"=>true]);
            }
        });
        return ($this->response == null || !is_string($this->response))? $this->bill : $this->response;
    }
}
