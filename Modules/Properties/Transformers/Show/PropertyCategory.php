<?php

namespace Modules\Properties\Transformers\Show;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;


class PropertyCategory extends JsonResource
{
    
    public function toArray($request)
    {
        
        $current_date = Carbon::now();
        $noOfproperties = $this->properties->count();
        $noOfAvailableProperties = 
            $this->properties->where('available_after', '<=', $current_date)->where('enabled','!=', 0)->count(); 
                            
        $noOfDesabledproperties = 
            $this->properties->where('enabled','==', 0)->count();
                            
   
        return [
            "id" => $this->id,
            "name" => $this->name, 
            "description" => $this->description, 
            "enabled" => $this->enabled, 
            "picture" => $this->picture, 
            "rent_price" => $this->rent_price, 
            "sell_price" => $this->sell_price, 
            "no_of_properties" => $this->properties->count(),
            "no_of_available_properties" => $noOfAvailableProperties,
            "no_of_occupied_properties" => ($noOfproperties - $noOfAvailableProperties),
            "no_of_disabled_properties" => $noOfDesabledproperties,
            "created_at" => Carbon::createFromFormat('Y-m-d H:i:s', $this->created_at)->toFormattedDateString()
        ];
    }
}
