<?php

namespace Modules\Expenses\Transformers\Bill;

use Illuminate\Http\Resources\Json\JsonResource;

class PaymentResponse extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request
     * @return array
     */
    public function toArray($request)
    {
        return parent::toArray($request);
    }
}
