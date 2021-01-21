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
        $picture = $this->picture;
        if ($picture) {
            $picture = route('media',['path' => $picture['files'][0] ?? 'placeholder.jpg' ]);
        }

        return [
            "id" => $this->id,
            "name" => $this->name, 
            "description" => mb_strimwidth($this->description, 0, 30, '...'),
            "enabled" => $this->enabled, 
            "picture" => $picture,
            "rent_price" => "ETB ". number_format($this->rent_price, 2),
            "sell_price" => "ETB ". number_format($this->sell_price, 2),
            "no_of_properties" => $this->properties->count(), 
            "created_at" => Carbon::parse($this->created_at)->toFormattedDateString()
        ];
    }
}
