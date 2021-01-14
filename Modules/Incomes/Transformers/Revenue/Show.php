<?php

namespace Modules\Incomes\Transformers\Revenue;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Entities\Transaction;

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
        $transaction = $this->transaction()->first();

        $total = $this->price;
        $tax = $this->tax()->first();
        $tax_price = ($tax == null)?0:($total*(1/$tax->rate));
        return [
          'id'=>$this->id,
          'date'=>($transaction==null)?null:$transaction->transaction_date,
          'tenant'=> new \Modules\Incomes\Transformers\Tenant\Profile($this->tenant()->first()),
          'category'=>($transaction==null)?null:$transaction->category()->first()->name,
          'transaction'=>($transaction==null)?null:new \Modules\Accounts\Transformers\Index\Transaction($transaction),
            'price'=>$total,
            "tax"=> ($tax==null)?null:$tax->name,
            "subtotal"=>$total - $tax_price,
            "tax_price"=>$tax_price,
            "total"=>$total,
        ];
    }
}
