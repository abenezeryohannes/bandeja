<?php

namespace Modules\Accounts\Transformers\Show;

use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Transformers\Mini\Category;
use Modules\Accounts\Transformers\Mini\PaymentMethod;
use Modules\Accounts\Transformers\Mini\Tax;
use Modules\Expenses\Entities\BillPayment;
use Modules\Expenses\Entities\Payment;
use Modules\Incomes\Entities\InvoicePayment;
use Modules\Incomes\Entities\Revenue;

class Transaction extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request
     * @return array
     */
    public function toArray($request)
    {
        $pm = $this->paymentMethod()->first();
        $tax = $this->tax;
        $type = $this->type;

        $response =  [
            'id' => $this->id,
            'type'=>$type,
            'transaction_number'=>"TR" . ($this->id),
            'transaction_date' => $this->transaction_date,
            'amount' => $this->amount,
            'payment_method' => ($pm!=null)?null:new PaymentMethod($pm),
            'attachment' => $this->attachment,
            'note' => $this->note,
            'tax' => ($tax!=null)?new Tax($this->tax):null,
            'category' => new Category($this->category),
            'account' => new \Modules\Accounts\Transformers\Mini\Account($this->account),

        ];

        if(strtolower($type) == "invoice"){
            $inv_payment = InvoicePayment::where('transaction_id', '=', $this->id)->first();
            if($inv_payment!=null) $response['invoice_payment_id'] = $inv_payment->id;
        }
        else if(strtolower($type) == "bill"){
            $bill_payment = BillPayment::where('transaction_id', '=', $this->id)->first();
            if($bill_payment!=null) $response['bill_payment_id'] = $bill_payment->id;

        }
        else if(strtolower($type) == "revenue"){
            $revenue = Revenue::where('transaction_id', '=', $this->id)->first();
            if($revenue!=null) $response['revenue_id'] = $revenue->id;

        }
        else if(strtolower($type) == "payment"){
            $payment = Payment::where('transaction_id', '=', $this->id)->first();
            if($payment!=null) $response['payment_id'] = $payment->id;
        }

        return $response;

    }
}
