<?php

namespace Modules\Properties\Transformers\Mini;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class Property extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request
     * @return array
     */
    public function toArray($request)
    {
        $response = [
            "id" => $this->id,
            "name" => $this->name,
            "property_category" => new \Modules\Properties\Transformers\Mini\PropertyCategory($this->propertyCategory),
            "available" => Carbon::now()->isAfter(Carbon::parse($this->available_after)),
            "enabled" => $this->enabled,
        ];
        return $response;
    }
}
