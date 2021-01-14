<?php

namespace Modules\Incomes\Transformers\Tenant;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;

class Profile extends JsonResource
{
    /**
     * Transform the resource into an array.
     *name phonenumber openinvoices defaulted
     * @param  \Illuminate\Http\Request
     * @return array
     */
    // email, phone, website,
    // tax, address,
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "name" => $this->name,
            "phone_number" => $this->phone_number,
            "email" => $this->email_address,
            "physical_address" => $this->physical_address,
            "email_address" => $this->email_address,
            "tin_number" => $this->tin_number,
        ];
    }
}
