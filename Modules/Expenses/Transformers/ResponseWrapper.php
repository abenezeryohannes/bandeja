<?php

namespace Modules\Expenses\Transformers;
use Modules\Expenses\Transformers\Bill\Index as BillIndex;
use Modules\Expenses\Transformers\Bill\Show as BillShow;
use Modules\Expenses\Transformers\Bill\Mini as BillMini;
use Modules\Expenses\Transformers\Bill\PaymentResponse;
use Modules\Accounts\Transformers\Index\Transaction as TransacionIndex;

use Modules\Expenses\Transformers\Vendor\Index as VendorIndex;
use Modules\Expenses\Transformers\Vendor\Show as VendorShow;
use Modules\Expenses\Transformers\Vendor\Mini as VendorMini;

use Modules\Expenses\Transformers\Payment\Index as PaymentIndex;
use Modules\Expenses\Transformers\Payment\Show as PaymentShow;
use Modules\Expenses\Transformers\Payment\Mini as PaymentMini;
use Modules\Expenses\Transformers\Recurring\Mini as RecurringMini;

use Modules\Expenses\Transformers\VendorCategory\Mini as VendorCategoryMini;


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
            case "minirecurring":
                $response = new RecurringMini($data);
                break;
            case "minivendorcategory":
                $response = new VendorCategoryMini($data);
                break;



                break;
            case "showbill":
                $response = new BillShow($data);
                break;
            case "indexbillcollection":
                $response =  BillIndex::Collection($data);
                break;
            case "billpaymentresponse":
                $response = new PaymentResponse($data);
                break;


            case "showvendor":
                $response = new VendorShow($data);
                break;
            case "indexvendorcollection":
                $response =  VendorShow::collection($data);
                break;
            case "indextransactioncollection":
                $response =  TransacionIndex::Collection($data);
                break;



            case "indexpaymentcollection":
                $response = PaymentIndex::collection($data);
                break;
            case "showpayment":
                $response = new PaymentShow($data);
                break;
            case "minipayment":
                $response = new PaymentMini($data);
                break;

            default: 
                $response = null;
        } return $response;
    }

}