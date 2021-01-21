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
        $tax = $this->tax;

        return [
            'id' => $this->id,
            'transaction_number'=>"TR" . ($this->id),
            'transaction_date' => $this->transaction_date,
            'amount' => $this->transaction_date,
            'tax' => ($tax!=null)?new Tax($this->tax):null,
            'category' => new Category($this->category),
            'account' => new \Modules\Accounts\Transformers\Mini\Account($this->account),
        ];
    }
}
