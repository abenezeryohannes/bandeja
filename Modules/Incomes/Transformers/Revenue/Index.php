<?php

namespace Modules\Incomes\Transformers\Revenue;

use Carbon\Carbon;
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
        $date =($transaction==null)?"Unknown":$transaction->transaction_date ;
        $amount = ($transaction==null)?"Unspecified":$transaction->amount;
        return [
          'id'=>$this->id,
          'date'=>Carbon::parse($date)->toFormattedDateString(),
          'amount'=>"ETB " . number_format($amount, 2),
          'tenant'=>$this->tenant()->first()->name,
          'category'=>($transaction==null)?"Unknown":$transaction->category()->first()->name,

        ];
    }
}
