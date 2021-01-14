<?php

namespace Modules\Incomes\Transformers\Invoice;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Entities\Tax;

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

        $last_payment_request = $this->invoicePayments->where('invoice_date', '>=', Carbon::now())->first();
        if($last_payment_request==null) {
            $status = "Cancelled";
            $total = 0;
            $tax = $this->tax()->first();
            $tax_price =0;
            $period = 0;

        }
        else {
            $transaction = $last_payment_request->transaction()->first();
            $status = null;

            if ($transaction == null) {
                if (Carbon::parse($last_payment_request->due_date)->isBefore(Carbon::now())) {
                    $status = "defaulted";
                } else {
                    $status = "waiting";
                }
            } else $status = "paid";


            //if first time payment make period 3
            $period = 1;
            if ($this->invoice_date == $last_payment_request->invoice_date) {
                $period = 3;
            }

            $total = $last_payment_request->price * $period;
            $tax = $this->tax()->first();
            $tax_price = ($tax == null) ? 0 : ($total * (1 / $tax->rate));
        }

        return [
            "invoice_id"=>$this->id,
            "invoice_payment_id"=>($last_payment_request==null)?null:$last_payment_request->id,
            "invoice_number"=>$this->invoice_number,
            "price"=>($last_payment_request==null)?0:$last_payment_request->price,
            "invoice_date"=> ($last_payment_request==null)?$this->start_date:$last_payment_request->invoice_date,
            "due_date"=> ($last_payment_request==null)?$this->due_date:$last_payment_request->due_date,
            "status"=> ($this->canceled_invoice_id!=null)?"canceled":$status,
            "created_at"=>$this->created_at,
            "day_left"=>($last_payment_request==null)?0:Carbon::now()->diffInDays($last_payment_request->due_date),
            "tenant"=> new \Modules\Incomes\Transformers\Tenant\Profile($this->tenant()->first()),
            "tax"=> ($tax==null)?null:$tax->name,
            "subtotal"=>$total - $tax_price,
            "period"=>$period,
            "tax_price"=>$tax_price,
            "canceled"=> \Modules\Incomes\Transformers\Cancel\Index::collection($this->canceled()->get()),
            "total"=>$total,
        ];
    }
}
