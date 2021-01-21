<?php

namespace Modules\Accounts\Transformers\Index;

use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Transformers\Mini\Category;
use Modules\Accounts\Transformers\Mini\PaymentMethod;

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

//        return $this->all();
        // $pm = $this->paymentMethod()->first();
        $pm = $this->paymentMethod();
        return [
            'id' => $this->id,
            'type'=>$this->type,
            'transaction_number'=>"TR" . ($this->id),
            'transaction_date' => $this->transaction_date,
            'amount' => $this->amount,
            'category' => new Category($this->category),
            'payment_method' => ($pm!=null)?null:new PaymentMethod($pm),
            'account' => new \Modules\Accounts\Transformers\Mini\Account($this->account),
        ];
    }
}
