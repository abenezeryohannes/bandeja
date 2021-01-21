<?php

namespace Modules\Properties\Transformers\Show;

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
            "inside_block" => $this->inside_block!=0?true:false,
            "available" => Carbon::now()->isAfter(Carbon::parse($this->available_after)),
            "enabled" => $this->enabled,
            "property_category" => new PropertyCategory($this->propertyCategory),
        ];

        if($this->inside_block!=0)
        {
            $response["floor"] = ($this->floor!=null)?$this->floor:"Unknown";
            $response["block"] = new Block($this->block);
        }else{
            $response["address"] = $this->address;
            $response["site"] =  new Site($this->site);
        }

        return $response;
    }
}
