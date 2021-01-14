<?php

namespace Modules\Incomes\Transformers\Revenue;

use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Entities\Transaction;

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
        $transaction = $this->transaction()->first();
        return [
          'id'=>$this->id,
          'date'=>($transaction==null)?null:$transaction->transaction_date,
          'amount'=>($transaction==null)?null:$transaction->amount,
          'tenant'=>$this->tenant()->first()->name,
          'category'=>($transaction==null)?null:$transaction->category()->first()->name,

        ];
    }
}
