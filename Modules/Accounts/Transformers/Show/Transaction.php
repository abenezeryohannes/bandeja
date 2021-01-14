<?php

namespace Modules\Accounts\Transformers\Show;

use Illuminate\Http\Resources\Json\JsonResource;

class Transaction extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request
     * @return array
     */
    public function toArray($request)
    {
        $response =
         [
            'id' => $this->id,
            'name' => $this->name,
            'opening_balance' => $this->opening_balance,
            'balance' => $this->balance,
            'bank' => $this->bank,
            'type' => $this->type,
            'no_of_transaction' => $this->transactions->count(),
            'main_account' => $this->main_account,
            'enabled' => $this->enabled,
        ];

        if($this->invoice_id!=null){
            $response['invoice'] = $this->invoice;

        }else if ($this->revenue_id!=null){
            $response['revenue'] = $this->revenue;
        }

        return $response;
    }
}
