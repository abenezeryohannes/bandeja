<?php

namespace Modules\Expenses\Transformers\Vendor;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;

class Index extends JsonResource
{

    public function toArray($request)
    {

        return [
            'id'=>$this->id,
            "name"=>$this->name,
            "vendor_category"=>$this->vendorCategory()->first()->name,
            "unpaid"=>$this->unpaid($this->id),
            "status"=>$this->enabled,
        ];
    }
}
