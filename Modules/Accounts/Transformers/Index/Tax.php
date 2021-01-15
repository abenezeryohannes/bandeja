<?php

namespace Modules\Accounts\Transformers\Mini;

use Illuminate\Http\Resources\Json\JsonResource;

class Tax extends JsonResource
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
            'enabled' => $this->enabled,
        ];
    }
}
