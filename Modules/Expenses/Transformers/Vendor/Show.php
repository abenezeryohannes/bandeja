<?php

namespace Modules\Expenses\Transformers\Vendor;

use Illuminate\Http\Resources\Json\JsonResource;

class Show extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request
     * @return array
     */
    public function toArray($request)
    {
        $paymentTransaction = $this->PaymentTransactions($this->id)->count();
        $billTransaction = $this->BillTransactions($this->id)->count();
        return [
          "id"=>$this->id,
          "name"=>$this->name,
          "email"=>$this->email,
          "vendor_category"=>$this->vendorCategory()->first()->name,
          "phone_number"=>$this->phone_number,
          "position"=>$this->position,
          "postal_address"=>$this->postal_address,
          "physical_address"=>$this->physical_address,
          "email_address"=>$this->email_address,
          "tin_number"=>$this->tin_number,
          "memo"=>$this->memo,
          "bank"=>$this->bank,
          "account_number"=>$this->account_number,
          "enabled"=>$this->enabled,
          "no_of_bills"=>$this->bills()->count(),
          "no_of_transactions"=>$paymentTransaction + $billTransaction,
        ];
    }
}
