<?php

namespace Modules\Expenses\Jobs\Bill;

use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Category;
use Modules\Expenses\Entities\Bill;
use Modules\Expenses\Entities\Recurring;
use Modules\Expenses\Entities\Vendor;
use Modules\Expenses\Jobs\BillPayment\CreateBillPayment;
use Modules\Properties\Entities\Property;

class CreateBill implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;


    protected $bill = null;
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

            if(Category::find($this->request['category_id']) == null){
                $this->response = "No category with this id!";
                return;
            }

            if(Vendor::find($this->request['vendor_id']) == null){
                $this->response = "No vendor with this id!";
                return;
            }
            //check if end date and due date is prior to start date
            if(Carbon::parse($this->request['start_date'])->isAfter($this->request['due_date'])){
                $this->response = "Bill due date must be before bill date!";
                return;
            }
            //create bill
            $this->bill = Bill::create($this->request->all());
            if($this->request['bill_number']==null)
                $this->bill->update(['bill_number'=> "BLL" . $this->bill->id]);
            //get the month deference between bill date and end date
            //get the difference in days between bill date and due date
            //for each month create bill payment table


                $recurring = Recurring::where('id', '=', $this->bill->recurring_id)->first();
                $dueDiff = Carbon::parse($this->bill->start_date)->diffInDays(Carbon::parse($this->bill->due_date));

                $new_bill_payment = [
                    'bill_id' => $this->bill->id,
                    'price' => $this->request['price'],
                    'due_date' => Carbon::parse($this->bill->start_date)->addDays($recurring->interval + $dueDiff),
                    'bill_date' => Carbon::parse($this->bill->start_date)->addDays($recurring->interval),
                ];
                $this->response =  CreateBillPayment::dispatchNow($new_bill_payment);
                if( is_string($this->response) ) { return; }
                else $this->response = null;


            if($this->bill == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->bill : $this->response;
    }
}
