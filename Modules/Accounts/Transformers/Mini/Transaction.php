<?php

namespace Modules\Accounts\Transformers\Mini;

use Illuminate\Http\Resources\Json\JsonResource;

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
            'amount' => $this->transaction_date,
            'category' => new Category($this->category),
            'account' => new \Modules\Accounts\Transformers\Index\Account($this->account),

        ];
    }
}
