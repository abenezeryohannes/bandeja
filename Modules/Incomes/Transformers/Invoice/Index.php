<?php

namespace Modules\Incomes\Transformers\Invoice;

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
        $last_payment_request = $this->invoicePayments->where('invoice_date', '>=', Carbon::now())->first();
        if($last_payment_request==null){
            $status = "canceled";
        }else {
            $transaction = $last_payment_request->transaction()->first();
            $status = null;


            if ($transaction == null) {
                if (Carbon::parse($last_payment_request->due_date)->isBefore(Carbon::now())) {
                    $status = "defaulted";
                } else {
                    $status = "waiting";
                }
            } else $status = "paid";
        }
        $price = ($last_payment_request==null)?$this->price:$last_payment_request->price;
        $invoice_date = ($last_payment_request==null)?$this->start_date:$last_payment_request->invoice_date;
        $due_date = ($last_payment_request==null)?$this->due_date:$last_payment_request->due_date;
        return [
            "id"=>$this->id,
            "invoice_id"=>$this->id,
            "invoice_payment_id"=>($last_payment_request==null)?null:$last_payment_request->id,
            "invoice_number"=>$this->invoice_number,
            "tenant_name"=> mb_strimwidth($this->tenant()->first()->name, 0, 16, '...'),
            "price"=>"ETB ". number_format($price, 2),
            "invoice_date"=> Carbon::parse($invoice_date)->toFormattedDateString(),
            "due_date"=> Carbon::parse($due_date)->toFormattedDateString(),
            "status"=> ($this->canceled_invoice_id!=null)?"canceled":$status
        ];
    }
}
