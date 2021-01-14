<?php

namespace Modules\Incomes\Transformers\Tenant;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;

class Index extends JsonResource
{
    /**
     * Transform the resource into an array.
     *name phonenumber openinvoices defaulted
     * @param  \Illuminate\Http\Request
     * @return array
     */
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "name" => $this->name,
            "phone_number" => $this->phone_number,
            "no_of_open_invoices" => $this->invoices()->where('end_date', '>', Carbon::now())->count(),
            "no_of_defaulted" => $this->TotalDefaulted()
        ];
    }
}
