<?php

namespace Modules\Accounts\Transformers\Mini;

use Illuminate\Http\Resources\Json\JsonResource;

class Interest extends JsonResource
{

    public function toArray($request)
    {
        return [
         'id'=>$this->id,
         'account'=>$this->account->name,
         'amount'=>$this->amount,
         'date'=>$this->date,
        ];
    }
}
