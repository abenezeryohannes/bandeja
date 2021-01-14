<?php

namespace Modules\Accounts\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Accounts\Entities\Tax;
use Modules\Accounts\Jobs\Tax\CreateTax;
use Modules\Accounts\Jobs\Tax\DeleteTax;
use Modules\Accounts\Jobs\Tax\UpdateTax;
use Modules\Accounts\Transformers\ResponseWrapper;

class TaxesController extends Controller
{

    public $perpage = 20;
    /**
     * Display a listing of the resource.
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function index()
    {
        $taxes = Tax::simplepaginate($this->perpage);
        return $taxes;//AccountIndex::Collection($account);
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('accounts::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        //validating the input fields
        $validator = Validator::make($request->all(), [
            'name' => 'bail|required|string',
            'rate' => 'bail|required',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return ResponseWrapper::WrapSuccess($validator->errors()->first("name"), null);
        }


        //save to database and return the response
        $response = CreateTax::dispatchNow($request);
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return string
     */
    public function show($id)
    {
        $tax = Tax::find($id);
        if($tax==null)$tax = "No tax found with this id";
        return $tax;//ResponseWrapper::WrapSuccess($account, 'showAccount');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('accounts::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {
        //validating the input fields
//        $validator = Validator::make($request->all(), [
//            'name' => 'bail|required|string',
//        ]);

        //returning the error if input is not correct
//        if ($validator->fails())
//            return ResponseWrapper::WrapSuccess($validator->errors()->first("name"), null);

        //save to database and return the response
        $response = UpdateTax::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');

    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteTax::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
