<?php

namespace Modules\Accounts\Transformers\Index;

use Illuminate\Http\Resources\Json\JsonResource;

class Account extends JsonResource
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
            'name' => $this->name,
            'opening_balance' => $this->opening_balance,
            'balance' => $this->balance,
            'bank' => $this->bank,
            'type' => $this->type,
            'no_of_transaction' => $this->transactions->count(),
            'main_account' => $this->main_account,
            'enabled' => $this->enabled,
        ];
    }
}
