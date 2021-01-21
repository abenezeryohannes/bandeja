<?php

namespace Modules\Expenses\Transformers\Bill;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;

class Index extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request
     * @return array
     */
    public function toArray($request)
    {
        $status=  "waiting";
        $last_bill_payment = $this->billPayments()->orderBy('id', 'desc')->first();
        if($last_bill_payment->transaction_id!=null) $status = "payed";
        else if(Carbon::parse($last_bill_payment->due_date)->isAfter(Carbon::now())) $status = "defaulted";

        return [
            "id"=>$this->id,
            "number"=>$this->bill_number,
            "vendor"=>$this->vendor()->first()->name,
            "amount"=>$this->price,
            "bill_date"=>Carbon::parse($last_bill_payment->bill_date)->toFormattedDateString(),
            "due_date"=>Carbon::parse($last_bill_payment->due_date)->toFormattedDateString(),
            "status"=>( $this->canceled )? "canceled" :$status
        ];
    }
}
