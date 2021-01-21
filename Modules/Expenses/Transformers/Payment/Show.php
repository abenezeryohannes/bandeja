<?php

namespace Modules\Expenses\Transformers\Payment;

use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Transformers\Show\Transaction;
use Modules\Expenses\Transformers\Vendor\Show as ShowVendor;

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
        $vendor = $this->vendor()->first();
        return [
            "id"=>$this->id,
            "vendor"=> new showVendor($this->vendor()->first()),
            "transaction"=> new Transaction($transaction)
        ];
    }
}
