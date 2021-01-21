<?php

namespace Modules\Expenses\Transformers\Payment;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Transformers\Index\Transaction;
use \Modules\Expenses\Transformers\Vendor\Mini as MiniVendor;
class Index extends JsonResource
{

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
