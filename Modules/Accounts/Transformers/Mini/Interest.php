<?php

namespace Modules\Accounts\Transformers\Mini;

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
         'account'=>$this->account()->name,
         'amount'=>$this->amount,
         'date'=>$this->date,
        ];
    }
}
