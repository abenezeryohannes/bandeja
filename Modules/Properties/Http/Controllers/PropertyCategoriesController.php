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
use \Modules\Properties\Jobs\Propertycategory\CreatePropertyCategory;
use \Modules\Properties\Jobs\Propertycategory\UpdatePropertyCategory;
use \Modules\Properties\Jobs\Propertycategory\DeletePropertyCategory;
use Modules\Properties\UI\Forms\PropertyCategoriesForm;

class PropertyCategoriesController extends Controller
{
    public $perpage = 20;

    public function __construct()
    {
        $this->middleware('auth');
    }


    public function index(Request $request)
    {
        $property_categories = PropertyCategory::simplepaginate($this->perpage);
        return PropertyCategoryIndexResource::Collection($property_categories);
    }
    


    public function create()
    {
        $form = new PropertyCategoriesForm('create');
        return response()->json($form->generate());
    }


    public function store(Request $request)
    {
        $request->validate([
                        'name' => 'bail|required|string',
            'rent_price' => 'bail|required|string',
        ]);

        //save to database and return the response
        $response = CreatePropertyCategory::dispatchNow($request);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'PropertyCategory');
    }


    public function show($id)
    {
        
        $propertyCategory = PropertyCategory::find($id);
        if($propertyCategory==null)$propertyCategory = "No properties category found with this id";
        return ResponseWrapper::WrapSuccess($propertyCategory, 'showPropertyCategory');
    }



    public function edit($id)
    {
        $propertyCategory = PropertyCategory::find($id);
        $form = new \Modules\Properties\UI\Forms\PropertyCategoriesForm('edit');
        return response()->json($form->generate($id));
    }


    public function update(Request $request, $id)
    {
        //validating the input fields
         $request->validate([
            'name' => 'bail|required|string',
            'rent_price' => 'bail|required|string',
        ]);

        //save to database and return the response
        $response = UpdatePropertyCategory::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'PropertyCategory');
    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeletePropertyCategory::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
