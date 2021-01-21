<?php

namespace Modules\Expenses\Jobs\Bill;

use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Expenses\Entities\Bill;
use Modules\Expenses\Jobs\BillPayment\UpdateBillPayment;

class UpdateBill implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $bill = null;
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

            $this->bill = Bill::find($this->id);

            if($this->bill == null){
                $this->response =  "No bill found with this id!";
            }else {
                //update the last bill payment's bill and due date
                $bill_payment = $this->bill->billPayments->orderBy('id', 'desc')->first();
                $this->response = UpdateBillPayment::dispatchNow($this->request, $bill_payment->id);
                if (is_string($this->response)) return;
                else $this->response = null;



                //save the new bill
                //can't change bills start and dye date also price
                $this->request['due_date'] = $this->bill->due_date;
                $this->request['start_date'] = $this->bill->start_date;
                $this->request['price'] = $this->bill->price;
                $this->bill = $this->bill->update($this->request->all());
            }
        });
        return ($this->response == null || !is_string($this->response))? $this->bill : $this->response;
    }
}
