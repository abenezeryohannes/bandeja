<?php

namespace Modules\Accounts\Transformers;
use Modules\Accounts\Transformers\Index\Interest as InterestIndex;
use Modules\Accounts\Transformers\Mini\Account as AccountMiniResource;

use Modules\Accounts\Transformers\Show\Account as AccountShowResource;

use Modules\Accounts\Transformers\Index\Account as AccountIndexResource;


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
            case "accountindex":
                $response = new AccountMiniResource($data);
                break;

            case "interestindex":
                $response = new InterestIndex($data);
                break;
            default: 
                $response = null;
        }
        return $response;
    }

}