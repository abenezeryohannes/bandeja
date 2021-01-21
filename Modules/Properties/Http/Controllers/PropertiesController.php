<?php

namespace Modules\Properties\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Incomes\Transformers\Invoice\Index;
use Modules\Properties\Jobs\Property\SearchAndSortProperty;
use \Modules\Properties\Transformers\Index\Property as PropertyIndexResource;
use \Modules\Properties\Transformers\Show\Property as PropertyShowResource;
use \Modules\Properties\Transformers\ResponseWrapper;
use \Modules\Properties\Jobs\Property\CreateProperty;
use \Modules\Properties\Entities\Property;
use \Modules\Properties\Jobs\Property\UpdateProperty;
use \Modules\Properties\Jobs\Property\deleteProperty;

class PropertiesController extends Controller
{
    public $perpage = 20;


    public function index(Request $request)
    {
        $property = SearchAndSortProperty::dispatchNow($request->search,$request->sort_by,$request->order);
        return PropertyIndexResource::Collection($property);
    }

    public function availableProperties(Request $request)
    {
        $property = Property::where('available_after', '<', Carbon::now())->get();
        return \Modules\Properties\Transformers\Mini\AvailableProperty::Collection($property);
    }


    public function csrf()
    {
        return csrf_token(); 
    }


    public function create()
    {
        return response()->json([
            'form' => [
                'fields' => [
                    [ 'label' => 'Name', 'required' => 'required', 'icon' => 'fa fa-font', 'type' => 'input', 'column' => 'col-md-6', 'input_type' => 'text', 'default' =>  null, 'name' => 'name' ],
                    [ 'label' => 'Status', 'required' => 'required', 'icon' => 'fa fa-save', 'type' => 'switcher', 'column' => 'col-md-3', 'options' => [ [ 'label' => 'Enabled', 'value' => '1'],[ 'label' => 'Disabled', 'value' => '0']  ], 'default' =>  '1', 'name' => 'enabled' ],

                    // [ 'label' => 'Floors', 'required' => 'required', 'icon' => 'fa fa-font', 'type' => 'input', 'column' => 'col-md-3', 'input_type' => 'text', 'default' =>  null, 'name' => 'floors' ],

                    [ 'label' => 'Site', 'required' => 'required', 'icon' => 'fa fa-envelope', 'type' => 'select', 'column' => 'col-md-6', 'options' => \Modules\Properties\Entities\Site::all()->map(function($s){
                        return [
                            'label' => $s['name'],
                            'value' => $s['id'],
                        ];
                    }), 'default' =>  null, 'name' => 'site_id' ],
                    [ 'label' => 'Type', 'required' => 'required', 'icon' => 'fa fa-save', 'type' => 'switcher', 'column' => 'col-md-3', 'options' => [ [ 'label' => 'Apartment', 'value' => 'apartment'],[ 'label' => 'Villa', 'value' => 'villa']  ], 'default' =>  'apartment', 'name' => 'type' ],


                    [ 'label' => 'Category', 'required' => 'required', 'icon' => 'fa fa-envelope', 'type' => 'select', 'column' => 'col-md-6', 'options' => \Modules\Properties\Entities\PropertyCategory::all()->map(function($s){
                        return [
                            'label' => $s['name'],
                            'value' => $s['id'],
                        ];
                    }), 'default' =>  null, 'name' => 'site_id' ],
                    [ 'label' => 'Block', 'required' => 'required', 'icon' => 'fa fa-envelope', 'type' => 'select', 'column' => 'col-md-3', 'options' => \Modules\Properties\Entities\Block::all()->map(function($s){
                        return [
                            'label' => $s['name'],
                            'value' => $s['id'],
                        ];
                    }), 'default' =>  null, 'name' => 'site_id' ],

                    [ 'label' => 'Floor', 'required' => 'required', 'icon' => 'fa fa-font', 'type' => 'input', 'column' => 'col-md-3', 'input_type' => 'number', 'default' =>  null, 'name' => 'floor' ],
                    

                ],
                'strings' => [
                    'save' => 'Save',
                    'saving' => 'Saving ...',
                    // 'save' => 'Update',
                    'cancel' => 'cancel'
                ]
            ] 
        ]);
    }


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


    public function show($id)
    {
        $property = Property::find($id);
        if($property==null)$property = "No property found with this id";
        return new \Modules\Properties\Transformers\Show\Property($property);
    }



    public function invoices($id)
    {
        $property = Property::find($id);
        if($property==null)$property = "No property found with this id";
        $invoices = $property->invoices()->simplepaginate($this->perpage);
        return Index::collection($invoices);
    }


    public function edit($id)
    {
        return view('properties::edit');
    }


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


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteProperty::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }



    public function destroyAll(Request $request)
    {
        $request->validate(['ids'=>'required']);

        $ids = explode(',', $request['ids']);

        foreach ($ids as $id){
            $response = DeleteProperty::dispatchNow($id);
        }

        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
