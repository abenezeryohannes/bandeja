<?php

namespace Modules\Properties\Transformers\Show;

use Illuminate\Http\Resources\Json\JsonResource;
use \Modules\Properties\Entities\Property;
use Carbon\Carbon;
class Site extends JsonResource
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
        $properties_insideBlock = $this->GetBlockedProperties($this->id)->count();
        $noOfproperties = $this->properties->count() + $properties_insideBlock;
        $noOfAvailableProperties = $this->properties->where('available_after', '<=', $current_date)->where('properties.enabled','!=', 0)->count() 
                              +  $this->GetBlockedProperties($this->id)->whereDate('available_after', '<=', $current_date)->where('properties.enabled', '!=', 0)->count();

        $picture = $this->picture;
        if ($picture) {
            $picture = route('media',['path' => $picture['files'][0] ?? 'placeholder.jpg' ]);
        }

        return [
            "id" => $this->id,
            "name" => $this->name,
            "address" => $this->address,
            "enabled" => $this->enabled,
            "picture" => $picture,
            "no_of_blocks" => $this->blocks->count(),
            "no_of_properties" => $noOfproperties,
            "no_of_available_properties" => $noOfAvailableProperties,
            "no_of_occupied_properties" => ($noOfproperties - $noOfAvailableProperties),
            "no_of_disabled_properties" => $this->properties->where('properties.enabled', '==', 0)->count(),
            "created_at" => Carbon::createFromFormat('Y-m-d H:i:s', $this->created_at)->toFormattedDateString()
        ];
    }
}
