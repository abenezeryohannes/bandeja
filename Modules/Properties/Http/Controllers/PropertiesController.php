<?php

namespace Modules\Properties\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use \Modules\Properties\Transformers\Index\Property as PropertyIndexResource;
use \Modules\Properties\Transformers\Show\Property as PropertyShowResource;
use \Modules\Properties\Transformers\ResponseWrapper;
use \Modules\properties\Jobs\Property\CreateProperty;
use \Modules\properties\Entities\Property;
use \Modules\properties\Jobs\Property\UpdateProperty;
use \Modules\properties\Jobs\Property\deleteProperty;

class PropertiesController extends Controller
{
    public $perpage = 20;
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index(Request $request)
    {
        $property = Property::simplepaginate($this->perpage);
        return PropertyIndexResource::Collection($property);
    }
    public function csrf()
    {
        return csrf_token(); 
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('properties::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        
        //validating the input fields
         $validator = Validator::make($request->all(), [
            'name' => 'bail|required|string',
            'property_category_id' => 'bail|required',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return response()->json([
                "status" => "error", 
                "message" => $validator->errors()->first("name") . $validator->errors()->first("property_category_id")
            ]);
        }

        //save to database and return the response
        $response = CreateProperty::dispatchNow($request);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Property');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        $property = Property::find($id);
        if($property==null)$property = "No property found with this id";
        return ResponseWrapper::WrapSuccess($property, 'showProperty');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('properties::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        //validating the input fields
        $validator = Validator::make($request->all(), [
            'name' => 'bail|required|string',
            'property_category_id' => 'bail|required',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return response()->json([
                "status" => "error", 
                "message" => $validator->errors()->first("name") . $validator->errors()->first("property_category_id")
            ]);
        }
     
        //save to database and return the response
        $response = \Modules\properties\Jobs\Property\UpdateProperty::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Property');   
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
          
        //save to database and return the response
        $response = DeleteProperty::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
