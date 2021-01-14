<?php

namespace Modules\Accounts\Transformers\Index;

use Illuminate\Http\Resources\Json\JsonResource;
use Modules\Accounts\Transformers\Mini\Category;

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
        return [
            'id' => $this->id,
            'transaction_date' => $this->transaction_date,
            'amount' => $this->amount,
            'category' => new Category($this->category),
            'account' => new \Modules\Accounts\Transformers\Mini\Account($this->account),
        ];
    }
}
