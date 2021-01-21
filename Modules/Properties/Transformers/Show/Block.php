<?php

namespace Modules\Properties\Transformers\Show;

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
        $current_date = Carbon::now();
        $noOfproperties = $this->properties->count();
        $noOfAvailableProperties = 
            $this->properties->where('available_after', '<=', $current_date)->where('enabled','!=', 0)->count(); 
                            
        $noOfDesabledproperties = 
            $this->properties->where('properties.enabled','=', 0)->count();

        $picture = $this->picture;
        if ($picture) {
            $picture = route('media',['path' => $picture['files'][0] ?? 'placeholder.jpg' ]);
        }
        return [
            "id" => $this->id,
            "name" => $this->name, 
            "address" => $this->address, 
            "picture" => $picture,
            "site" => new \Modules\Properties\Transformers\Index\Site($this->site),
            "no_of_properties" => $this->properties->count(),
            "no_of_available_properties" => $noOfAvailableProperties,
            "no_of_occupied_properties" => ($noOfproperties - $noOfAvailableProperties),
            "no_of_disabled_properties" => $noOfDesabledproperties,
             "enabled" => $this->enabled, 
            "created_at" => Carbon::createFromFormat('Y-m-d H:i:s', $this->created_at)->toFormattedDateString()
        ];
    }
}
