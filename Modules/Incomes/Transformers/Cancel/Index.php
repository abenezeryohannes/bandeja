<?php

namespace Modules\Incomes\Transformers\Cancel;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;

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
        return [
            "id"=>$this->id,
            "reason"=>$this->reason,
            "by"=>$this->by,
            "previous_end_date"=>$this->previous_end_date,
            "created_dat"=>$this->created_at,
             ];
    }
}
