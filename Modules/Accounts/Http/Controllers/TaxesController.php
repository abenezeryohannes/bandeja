<?php

namespace Modules\Accounts\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Accounts\Entities\Tax;
use Modules\Accounts\Jobs\Tax\CreateTax;
use Modules\Accounts\Jobs\Tax\DeletePaymentMethods;
use Modules\Accounts\Jobs\Tax\DeleteTax;
use Modules\Accounts\Jobs\Tax\UpdatePaymentMethods;
use Modules\Accounts\Jobs\Tax\UpdateTax;
use Modules\Accounts\Transformers\ResponseWrapper;

class TaxesController extends Controller
{

    public $perpage = 20;

    public function index()
    {
        $taxes = Tax::simplepaginate($this->perpage);
        return \Modules\Accounts\Transformers\Index\Tax::Collection($taxes);
    }


    public function create()
    {
        return view('accounts::create');
    }


    public function store(Request $request)
    {
        //validating the input fields
        $request->validate([
            'name' => 'bail|required|string',
            'rate' => 'bail|required',
        ]);


        //save to database and return the response
        $response = CreateTax::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'TaxIndex');
    }



    public function edit($id)
    {
        return view('accounts::edit');
    }


    public function update(Request $request, $id)
    {

        //save to database and return the response
        $response = UpdateTax::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'TaxIndex');

    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteTax::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
