<?php

namespace Modules\Expenses\Transformers\Bill;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Transformers\Mini\Tax;
use \Modules\Expenses\Transformers\Vendor\Show as ShowVendor;
class Show extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request
     * @return array
     */
    public function toArray($request)
    {
        $status= "waiting";
        $last_bill_payment = $this->billPayments()->orderBy('id', 'desc')->first();


        $due_date = Carbon::parse($last_bill_payment->due_date);
        $bill_date = Carbon::parse($last_bill_payment->bill_date);

        $days_left = Carbon::now()->diffInDays($due_date);


        if($last_bill_payment->transaction_id!=null) $status = "payed";
        else if(Carbon::parse($last_bill_payment->due_date)->isAfter(Carbon::now())) $status = "defaulted";

        $tax = $this->tax()->first();
        return [
            "id"=>$this->id,
            "bill_payment_id"=>$last_bill_payment->id,
            "number"=>$this->bill_number,
            "amount"=>$this->price,
            "bill_date"=>$bill_date->toFormattedDateString(),
            "due_date"=>$due_date->toFormattedDateString(),
            "status"=>( $this->canceled )? "canceled" :$status,
            "days_left"=>(Carbon::now()->isBefore($due_date))?$days_left:(-1 * $days_left),
            "fixed"=>$this->fixed,
            "vendor"=>new ShowVendor($this->vendor()->first()),
            "tax"=>($tax!=null)?new Tax($tax):null,
        ];
    }
}
