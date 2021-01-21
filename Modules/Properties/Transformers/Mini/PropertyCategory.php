<?php

namespace Modules\Properties\Transformers\Mini;

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
            "picture" => $picture,
            "enabled" => $this->enabled, 
        ];
    }
}
