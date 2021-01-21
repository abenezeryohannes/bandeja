<?php

namespace Modules\Expenses\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Expenses\Entities\Vendor;
use Modules\Expenses\Entities\VendorCategory;
use Modules\Expenses\Jobs\Vendor\CreateVendor;
use Modules\Expenses\Jobs\Vendor\DeleteVendor;
use Modules\Expenses\Jobs\Vendor\UpdateVendor;
use Modules\Expenses\Jobs\VendorCategory\CreateVendorCategory;
use Modules\Expenses\Jobs\VendorCategory\DeleteVendorCategory;
use Modules\Expenses\Jobs\VendorCategory\UpdateVendorCategory;
use Modules\Expenses\Transformers\ResponseWrapper;
use Modules\Expenses\Transformers\VendorCategory\Mini;

class VendorCategoriesController extends Controller
{

    public $perpage = 20;


    public function index()
    {
        $VendorCategorys = VendorCategory::all();
        return Mini::Collection($VendorCategorys);
    }


    public function create()
    {
        return view('accounts::create');
    }


    public function store(Request $request)
    {
        //validating the input fields
        $request->validate([
            'name' => 'required'
        ]);

        //save to database and return the response
        $response = CreateVendorCategory::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'MiniVendorCategory');
    }



    public function edit($id)
    {
        return view('accounts::edit');
    }



    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdateVendorCategory::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'MiniVendorCategory');

    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteVendorCategory::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }

}
