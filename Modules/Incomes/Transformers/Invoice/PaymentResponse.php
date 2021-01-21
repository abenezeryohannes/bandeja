<?php

namespace Modules\Incomes\Transformers\Invoice;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Transformers\Index\Transaction;

class PaymentResponse extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request
     * @return array
     */
    public function toArray($request)
    {

        $invoice = $this->invoice()->first();
        return [
            "invoice_id"=>$invoice->id,
            "invoice_payment_id"=>$this->id,
            "invoice_number"=>$invoice->invoice_number,
            "invoice_date"=> $this->invoice_date,
            "due_date"=> $this->due_date,
            "period"=> $this->period,
            "price"=> $this->price,
            "status"=> $this->status,
            "payment_method"=> "CASH",
            "transaction"=> new Transaction($this->transaction()->first())
        ];
    }
}
