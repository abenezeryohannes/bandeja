<?php

namespace Modules\Properties\Transformers\Index;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class Block extends JsonResource
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
            "address" => $this->address, 
            "site" => new \Modules\Properties\Transformers\Mini\Site($this->site),
            "no_of_properties" => $this->properties->count(),
            "enabled" => $this->enabled, 
            "created_at" => Carbon::createFromFormat('Y-m-d H:i:s', $this->created_at)->toFormattedDateString()
        ];
    }
}
