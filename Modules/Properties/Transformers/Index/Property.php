<?php

namespace Modules\Properties\Transformers\Index;

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
        if($this->inside_block!=0)
            return [
                "id" => $this->id,
                "name" => $this->name, 
                "inside_block" => $this->inside_block!=0?true:false,
                "block" => new \Modules\Properties\Transformers\Mini\Site($this->block), 
                "floor" => $this->floor, 
                "property_category" => new \Modules\Properties\Transformers\Mini\PropertyCategory($this->propertyCategory),
                "available" => Carbon::now()->isAfter(Carbon::parse($this->available_after)), 
                "enabled" => $this->enabled, 
                // "created_at" => Carbon::createFromFormat('Y-m-d H:i:s', $this->created_at)->toFormattedDateString()
            ];
        else
            return[
                "id" => $this->id,
                "name" => $this->name, 
                "inside_block" => $this->inside_block!=0?true:false,
                "address" => $this->address,
                "site" => new \Modules\Properties\Transformers\Mini\Site($this->site), 
                "property_category" => new \Modules\Properties\Transformers\Mini\PropertyCategory($this->propertyCategory),
                "available" => Carbon::now()->isAfter(Carbon::parse($this->available_after)), 
                "enabled" => $this->enabled, 
                // "created_at" => Carbon::createFromFormat('Y-m-d H:i:s', $this->created_at)->toFormattedDateString()
            ];
    }
}
