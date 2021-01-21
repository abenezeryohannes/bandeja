<?php

namespace Modules\Expenses\Transformers\Recurring;

use Illuminate\Http\Resources\Json\JsonResource;

class Mini extends JsonResource
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
          "id"=>$this->id,
          "name"=>$this->name,
          "interval"=>$this->interval,
        ];
    }
}
