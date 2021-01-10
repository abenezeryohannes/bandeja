<?php

namespace Modules\Properties\Transformers\Mini;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;


class PropertyCategory extends JsonResource
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
            "id" => $this->id,
            "name" => $this->name, 
            "enabled" => $this->enabled, 
        ];
    }
}
