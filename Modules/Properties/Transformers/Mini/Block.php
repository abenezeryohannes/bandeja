<?php

namespace Modules\Properties\Transformers\Mini;

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
            "site" => new \Modules\Properties\Transformers\Mini\Site($this->site),
            "enabled" => $this->enabled, 
           ];
    }
}
