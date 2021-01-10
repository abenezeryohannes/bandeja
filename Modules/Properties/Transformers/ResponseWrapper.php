<?php

namespace Modules\Properties\Transformers;
use Modules\Properties\Transformers\Mini\Site as SiteMiniResource;
use Modules\Properties\Transformers\Mini\Block as BlockMiniResource;
use Modules\Properties\Transformers\Mini\PropertyCategory as PropertyCategoryMiniResource;
use Modules\Properties\Transformers\Mini\Property as PropertyMiniResource;

use Modules\Properties\Transformers\Show\Site as SiteShowResource;
use Modules\Properties\Transformers\Show\Block as BlockShowResource;
use Modules\Properties\Transformers\Show\PropertyCategory as PropertyCategoryShowResource;
use Modules\Properties\Transformers\Show\Property as PropertyShowResource;

use Modules\Properties\Transformers\Index\Site as SiteIndexResource;
use Modules\Properties\Transformers\Index\Block as BlockIndexResource;
use Modules\Properties\Transformers\Index\PropertyCategory as PropertyCategoryIndexResource;
use Modules\Properties\Transformers\Index\Property as PropertyIndexResource;


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
        switch($transformer){
            case "Site": 
                $response = new SiteMiniResource($data);
                break;
            case "Property": 
                $response = new PropertyMiniResource($data);
                break;
            case "Block": 
                $response = new BlockMiniResource($data);
                break;
            case "PropertyCategory": 
                $response = new PropertyCategoryMiniResource($data);
                break;

                
            case "showSite": 
                $response = new SiteShowResource($data);
                break;
            case "showProperty": 
                $response = new PropertyShowResource($data);
                break;
            case "showBlock": 
                $response = new BlockShowResource($data);
                break;
            case "showPropertyCategory": 
                $response = new PropertyCategoryShowResource($data);
                break;

                
            case "indexSite": 
                $response = new SiteIndexResource($data);
                break;
            case "indexProperty": 
                $response = new PropertyIndexResource($data);
                break;
            case "indexBlock": 
                $response = new BlockIndexResource($data);
                break;
            case "indexPropertyCategory": 
                $response = new PropertyCategoryIndexResource($data);
                break;
            default: 
                $response = null;
        }
        return $response;
    }

}