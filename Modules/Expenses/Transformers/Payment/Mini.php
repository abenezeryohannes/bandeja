<?php

namespace Modules\Expenses\Transformers\Payment;

use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Transformers\Mini\Transaction;
use Modules\Expenses\Transformers\Vendor\Mini as MiniVendor;

class Mini extends JsonResource
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
            "id"=>$this->id,
            "vendor"=> new MiniVendor($this->vendor()->first()),
            "transaction"=> new Transaction($transaction)
        ];
    }
}
