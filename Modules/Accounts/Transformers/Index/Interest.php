<?php

namespace Modules\Accounts\Transformers\Index;

use Illuminate\Http\Resources\Json\JsonResource;

class Interest extends JsonResource
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
            'id'=>$this->id,
            'interest_number'=>$this->interest_number,
            'account_name'=>new Account($this->account()),
            'amount'=>$this->amount,
            'date'=>$this->date,
        ];
    }
}
