<?php

namespace Modules\Properties\Transformers\Index;

use Illuminate\Http\Resources\Json\JsonResource;
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
        $picture = $this->picture;
        if ($picture) {
            $picture = route('media',['path' => $picture['files'][0] ?? 'placeholder.jpg' ]);
        }

        return [
            "id" => $this->id,
            "name" => $this->name,
            "address" => mb_strimwidth($this->address, 0, 30, '...'),
            "enabled" => $this->enabled,
            "picture" => $picture,
            "no_of_blocks" => $this->blocks->count(),
            "no_of_properties" => $this->properties->count(),
            "created_at" => Carbon::createFromFormat('Y-m-d H:i:s', $this->created_at)->toFormattedDateString()
        ];
    }
}
