<?php

namespace Modules\Incomes\Transformers;
use Modules\Incomes\Transformers\Invoice\Index as InvoiceIndex;
use Modules\Incomes\Transformers\Invoice\Show as InvoiceShow;
use Modules\Accounts\Transformers\Index\Transaction as TransacionIndex;

use Modules\Incomes\Transformers\Tenant\Index as TenantIndex;
use Modules\Incomes\Transformers\Tenant\Show as TenantShow;

use Modules\Incomes\Transformers\Revenue\Index as RevenueIndex;
use Modules\Incomes\Transformers\Revenue\Show as RevenueShow;


class ResponseWrapper
{
    
    public static function WrapSuccess( $data, $transformer ){
        
        $response = null;
        
        if ($data == null || is_string($data)) {
            return response()->json(["status"=>"error", "message"=>$data], 400);
        }

        $response = ResponseWrapper::getType($data, $transformer);
        return 
            ($response==null) ?
                (response()->json(["status"=>"success"], 200)):
                (response()->json(["status"=>"success", "data"=> $response], 200));
       
    }



    public static function getType($data, $transformer){
        $response = null;
        switch(strtolower($transformer)){
            case "showinvoice":
                $response = new InvoiceShow($data);
                break;
            case "indexinvoicecollection":
                $response =  InvoiceIndex::Collection($data);
                break;
            case "indextransactioncollection":
                $response =  TransacionIndex::Collection($data);
                break;

            case "showtenant":
                $response = new TenantShow($data);
                break;

            case "showrevenue":
                $response = new RevenueShow($data);
                break;

            default: 
                $response = null;
        } return $response;
    }

}