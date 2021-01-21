<?php

namespace Modules\Properties\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Properties\Jobs\Site\SearchAndSortSite;
use Modules\Properties\Transformers\Index\Site as SiteIndex;
use \Modules\Properties\Transformers\Index\Site as SiteIndexResource;
use \Modules\Properties\Transformers\Show\Site as SiteShowResource;
use \Modules\Properties\Jobs\Site\CreateSite;
use \Modules\Properties\Jobs\Site\UpdateSite;
use \Modules\Properties\Jobs\Site\DeleteSite;
use \Modules\Properties\Entities\Site;
use \Modules\Properties\Transformers\ResponseWrapper;

class SitesController extends Controller
{
    public $perpage = 20;


    public function index(Request $request)
    {

        $site = SearchAndSortSite::dispatchNow($request['search'],$request['sort_by'],$request['order']);

        return SiteIndex::Collection($site);

    }


    public function create()
    {
        return response()->json([
            'form' => [
                'fields' => [
                    [ 'label' => 'Name', 'required' => 'required', 'icon' => 'fa fa-font', 'type' => 'input', 'column' => 'col-md-6', 'input_type' => 'text', 'default' =>  null, 'name' => 'name' ],
                    [ 'label' => 'Picture', 'required' => 'required', 'icon' => 'fa fa-key', 'type' => 'file', 'column' => 'col-md-6', 'file_types' => 'img', 'default' =>  null, 'name' => 'picture' ],

                    [ 'label' => 'Address', 'required' => 'required', 'icon' => 'fa fa-envelope', 'type' => 'textarea', 'column' => 'col-md-12', 'input_type' => 'email', 'default' =>  null, 'name' => 'address' ],

                    [ 'label' => 'Status', 'required' => 'required', 'icon' => 'fa fa-save', 'type' => 'switcher', 'column' => 'col-md-6', 'options' => [ [ 'label' => 'Enabled', 'value' => '1'],[ 'label' => 'Disabled', 'value' => '0']  ], 'default' =>  '1', 'name' => 'enabled' ],
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
        $request->validate([
            'name' => 'bail|required|string',
            'address' => 'bail|required|string',
//            'picture' => 'bail|required|string',
        ]);

        //save to database and return the response
        $response = CreateSite::dispatchNow($request);

        return ResponseWrapper::WrapSuccess($response, 'Site');
    }


    public function show($id)
    {   
        $site = Site::find($id);
        if($site==null)$site = "No site found with this id";
        return ResponseWrapper::WrapSuccess($site, 'showSite');
    }


    public function edit($id)
    {
        
        return view('properties::edit');
    }


    public function update(Request $request, int $id)
    {
        //save to database and return the response
        $response = UpdateSite::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Site');
   
    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteSite::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }




    public function destroyAll(Request $request)
    {
        $request->validate(['ids'=>'required']);

        $ids = explode(',', $request['ids']);

        foreach ($ids as $id){
            $response = DeleteSite::dispatchNow($id);
        }

        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
