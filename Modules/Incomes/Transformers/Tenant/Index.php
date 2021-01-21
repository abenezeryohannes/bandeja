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
        $open_invoice = $this->CurrentWaiting($this->id);
        $defaulted = $this->TotalDefaulted();
        return [
            "id" => $this->id,
            "name" => $this->name,
            "phone_number" => $this->phone_number,
            "no_of_open_invoices" => "ETB ". number_format($open_invoice, 2),
            "no_of_defaulted" => "ETB ". number_format($defaulted, 2)
        ];
    }
}
