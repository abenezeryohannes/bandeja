<?php

namespace Modules\Properties\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use \Modules\Properties\Transformers\Index\Site as SiteIndexResource;
use \Modules\Properties\Transformers\Show\Site as SiteShowResource;
use \Modules\Properties\Jobs\site\CreateSite;
use \Modules\Properties\Jobs\site\UpdateSite;
use \Modules\Properties\Jobs\site\DeleteSite;
use \Modules\Properties\Entities\Site;
use \Modules\Properties\Transformers\ResponseWrapper;

class SitesController extends Controller
{
    public $perpage = 20;
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index(Request $request)
    {
        $site = Site::simplepaginate($this->perpage);
        return \Modules\Properties\Transformers\Index\Site::Collection($site);
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
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return response()->json([
                "status" => "error", 
                "message" => $validator->errors()->first("name")
            ]);
        }

        //save to database and return the response
        $response = CreateSite::dispatchNow($request);

        return ResponseWrapper::WrapSuccess($response, 'Site');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {   
        $site = Site::find($id);
        if($site==null)$site = "No site found with this id";
        return ResponseWrapper::WrapSuccess($site, 'showSite');
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
    public function update(Request $request, int $id)
    {
        //validating the input fields
        $validator = Validator::make($request->all(), [
            'name' => 'bail|required|string',
        ]);
        
        //returning the error if input is not correct
        if ($validator->fails()) {
            return response()->json([
                "status" => "error", 
                "message" => $validator->errors()->first("name")
            ]);
        }

     
        //save to database and return the response
        $response = UpdateSite::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Site');
   
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
    
       
        //save to database and return the response
        $response = DeleteSite::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
