<?php

namespace Modules\Properties\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use \Modules\Properties\Transformers\Index\PropertyCategory as PropertyCategoryIndexResource;
use \Modules\Properties\Transformers\Show\PropertyCategory as PropertyCategoryShowResource;
use \Modules\Properties\Entities\PropertyCategory;
use \Modules\Properties\Transformers\ResponseWrapper;
use \Modules\properties\Jobs\Propertycategory\CreatePropertyCategory;
use \Modules\properties\Jobs\Propertycategory\UpdatePropertyCategory;
use \Modules\Properties\Jobs\Propertycategory\DeletePropertyCategory;

class PropertyCategoriesController extends Controller
{
    public $perpage = 20;
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index(Request $request)
    {
        $property_categories = PropertyCategory::simplepaginate($this->perpage);
        return PropertyCategoryIndexResource::Collection($property_categories);
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
            'rent_price' => 'bail|required|string',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return response()->json([
                "status" => "error", 
                "message" => $validator->errors()->first("name") . $validator->errors()->first("rent_price")
            ]);
        }

        //save to database and return the response
        $response = CreatePropertyCategory::dispatchNow($request);

        //$response returns the data inserted into the database
        
        return ResponseWrapper::WrapSuccess($response, 'PropertyCategory');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        
        $propertyCategory = PropertyCategory::find($id);
        if($propertyCategory==null)$propertyCategory = "No properties category found with this id";
        return ResponseWrapper::WrapSuccess($propertyCategory, 'showPropertyCategory');
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
            'rent_price' => 'bail|required|string',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return response()->json([
                "status" => "error", 
                "message" => $validator->errors()->first("name") . $validator->errors()->first("rent_price")
            ]);
        }

     
        //save to database and return the response
        $response = UpdatePropertyCategory::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'PropertyCategory');
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
        
        //save to database and return the response
        $response = DeletePropertyCategory::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
