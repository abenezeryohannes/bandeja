<?php

namespace Modules\Properties\Transformers\Index;

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
            "description" => $this->description, 
            "enabled" => $this->enabled, 
            "picture" => $this->picture, 
            "rent_price" => $this->rent_price, 
            "sell_price" => $this->sell_price, 
            "no_of_properties" => $this->properties->count(), 
            "created_at" => Carbon::createFromFormat('Y-m-d H:i:s', $this->created_at)->toFormattedDateString()
        ];
    }
}
